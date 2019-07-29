#include "constants.h"

#define PORT 2000

/*
 * We redefine send, otherwise we get a definition in sys/socket.h that
 * conflicts with the defintion in rs.p.
 */

#define send foobar
#define _XOPEN_SOURCE

#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <ctype.h>
#include <time.h>
#include <string.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <fcntl.h>
#include <unistd.h>

long int random(void);
int getdtablesize(void);


#undef send

typedef struct {
  char buffer [BUFSIZE];
  int reader,writer,newlines;
} circular;

typedef struct {
  circular input,output;
  int fd,in_use;
} connection;

static connection connections [TOP];
static long nextevent = 0;
static int s;

/*
 * Useful operation on a socket.  Writing a message to it normally means
 * writing the message in the code twice, so you can also count how long it is.
 */

#define WRITETOSOCKET(s,x) write(s,x,sizeof(x))

/*
 * Operations on circular buffers.
 */

#define EMPTY(x) (x.reader == x.writer)
#define RESET(x) x.reader = x.writer = 0
#define PUTIN(x,y) \
  if(x.writer == BUFSIZE) x.writer = 0; \
  x.buffer [x.writer++] = y; \
  if(y == '\n') x.newlines++;
#define TAKEOUT(x,y) \
  if(x.reader == BUFSIZE) x.reader = 0; \
  y = x.buffer [x.reader++]; \
  if(y == '\n') x.newlines--;
#define CONTAINSLINE(x) (x.newlines > 0)
#define WRITE(f,x) \
{ \
  int oldreader,k; \
\
  if(x.reader == BUFSIZE) x.reader = 0; \
  oldreader = x.reader; \
  x.reader += write(f,x.buffer + x.reader,x.reader > x.writer ? BUFSIZE - x.reader : x.writer - x.reader); \
  for(k = oldreader;k < x.reader;k++) if(x.buffer [k] == 3) hangup = 1; \
}

/*
 * First a few things which are really library routines.  They have to be
 * provided here or the Pascal doesn't work.
 */

extern void pascal_rename(char *fn1,char *fn2)
{
  rename(fn1,fn2);
}

extern long pascal_random()
{
  return random();
}

extern long shl(long number,int shift)
{
  return number << shift;
}

extern long shr(long number,int shift)
{
  return number >> shift;
}

extern void erase(char *fn)
{
  remove(fn);
}

/*
 * systime() is a 200Hz clock, monotonically increasing.  This is a hassle, we
 * have to read the time of day, and merge the seconds and microseconds fields.
 * Of course, we have to watch out for the result wrapping round as well.  Note
 * the unary plus to prevent integer overflow if the compiler reorders!
 */

extern long systime(void)
{
  struct timeval tv;
  long result;

  static int fiddle_factor = 0;

  gettimeofday(& tv,0);
  result = tv.tv_usec / 5000;		/* Convert 1MHz to 200Hz */

  if(fiddle_factor == 0) fiddle_factor = tv.tv_sec;
  result += (+(tv.tv_sec - fiddle_factor)) * 200;

  return result;
}

/*
 * gettime() is a call that returns a time encoded into a bitfield.
 */

extern long gettime(void)
{
  time_t t1 = time(0);
  struct tm *t2 = localtime(& t1);
  long result;

  result  = t2->tm_sec / 2;
  result |= t2->tm_min << 5;
  result |= t2->tm_hour << 11;
  result |= t2->tm_mday << 16;
  result |= (t2->tm_mon + 1) << 21;
  result |= (t2->tm_year - 80) << 25;

  return result;
}

/*
 * Now the more important stuff.  This deals with the circular buffers, the
 * sockets, etc.
 */

extern void pete_init(void)
{
  struct sockaddr_in sin;

  s = socket(AF_INET,SOCK_STREAM,0);
  if(s < 0) {
    perror("socket");
    exit(1);
  }

  sin.sin_family = AF_INET;
  sin.sin_port = htons(PORT);
  sin.sin_addr.s_addr = htonl(INADDR_ANY);

  if(bind(s,(struct sockaddr *) & sin,sizeof(sin)) < 0) {
    perror("bind");
    exit(1);
  }

  if(listen(s,5) < 0) {
    perror("listen");
    exit(1);
  }
}

extern void note_event_time(long t)
{
  if(nextevent > t) nextevent = t;
}

extern void poll(void)
{
  fd_set readable,writable;
  int i,pending_input = 0;
  struct timeval tv;
  long entry_time = systime();

  FD_ZERO(& readable);
  FD_ZERO(& writable);

  /*
   * Be ready to accept new connections if anyone is trying to attach to the
   * game.
   */

  FD_SET(s,& readable);

  /*
   * Now run through all the sessions - we want to know if any of them can
   * be read or written.
   */

  for(i = 0;i < TOP;i++)
  {
    if(connections [i].in_use) {
      FD_SET(connections [i].fd,& readable);
      if(! EMPTY(connections [i].output)) {
	FD_SET(connections [i].fd,& writable);
      }
      if(! EMPTY(connections [i].input)) pending_input = 1;
    }
  }

  /*
   * Finally, see if any of the required operations can be done yet.  If not,
   * then delay until the next event time.  If input to any session is pending,
   * don't delay in select.
   */

  if(nextevent < entry_time | pending_input) tv.tv_usec = 0;
  else tv.tv_usec = (nextevent - entry_time) * 5000;
  tv.tv_sec = tv.tv_usec / 1000000;
  tv.tv_usec %= 1000000;

  if(select(getdtablesize(),& readable,& writable,0,& tv) < 0)
    perror("select");

  if(FD_ISSET(s,& readable)) {
    struct sockaddr_in from;
    int len = sizeof(from);
    int channel = accept(s,(struct sockaddr *) & from,& len);
    int i,position = -1;

    if(channel == -1) perror("accept");
    printf("New connection from %s.\n",inet_ntoa(from.sin_addr));

    /*
     * Mark the new call non-blocking.  We do NOT want to be blocked waiting
     * for something to transmit.
     */

    fcntl(channel,F_SETFL,fcntl(channel,F_GETFL,0) | O_NDELAY);

    /*
     * We now have a new connection - look for a slot to put it in.
     */

    for(i = 0;i < TOP;i++)
    {
      if(! connections [i].in_use) {
	position = i;
	break;
      }
    }

    if(position == -1) {
      printf("--- connection refused.\n");
      WRITETOSOCKET(channel,"Sorry, there are no free sessions at the moment.  Please try again later, but\ndo not poll.  Polling wastes network bandwidth and reduces the number of\nsessions we can support.\n\n");
      close(channel);
    } else {
      printf("--- session number is %d.\n",position);
      connections [position].in_use = 1;
      RESET(connections [position].input);
      RESET(connections [position].output);
      connections [position].fd = channel;

      /*
       * Below, we have rather a kludge.  First we send a single line with
       * chr(2) on it - this tells the main code that a new connection has been
       * established.  So far so good, but then we send more linefeeds.  The
       * precise number has been empirically determined :-) to get the server
       * into the proper state.
       */

      PUTIN(connections [position].input,2);
      PUTIN(connections [position].input,'\n');
      PUTIN(connections [position].input,'\n');
    }
  }

  /*
   * Now look to see whether any channel is readable that we are interested
   * in.
   */

  for(i = 0;i < TOP;i++)
  {
    if(connections [i].in_use) {
      if(FD_ISSET(connections [i].fd,& readable)) {
	char buffer [2048];
	int size_read,j;

	size_read = read(connections [i].fd,buffer,2048);

	if(size_read == 0) {

	  /*
	   * Haven't read any characters - this means the person has hung up.
	   * Illogical but there you go.
	   *
	   * We put an appropriate command in their input buffer, to get their
	   * call dropped, and then mark this connection unused.
	   */

	  RESET(connections [i].input);
	  RESET(connections [i].output);
	  PUTIN(connections [i].input,3);
	  PUTIN(connections [i].input,'\n');
	  connections [i].in_use = 0;
	  close(connections [i].fd);
	}
	for(j = 0;j < size_read;j++)
	{
	  if(buffer [j] == '\n' || isprint(buffer [j])) {
	    PUTIN(connections [i].input,buffer [j]);
	  }
	}
      }
    }
  }

  /*
   * Now look to see whether any channel is writable that we are interested
   * in.
   */

  for(i = 0;i < TOP;i++)
  {
    if(connections [i].in_use) {
      if(FD_ISSET(connections [i].fd,& writable)) {
	int hangup = 0;

	/*
	 * Hangup is set by WRITE, if it notices a command from Realm to drop
	 * this particular call.
	 */

	WRITE(connections [i].fd,connections [i].output);
	if(hangup) {
	  RESET(connections [i].input);
	  RESET(connections [i].output);
	  connections [i].in_use = 0;
	  close(connections [i].fd);
	}
      }
    }
  }

  /*
   * Reset nextevent, ready to record a fresh batch of events next time round
   * the loop.
   */

  nextevent = LONG_MAX;
}

extern void pascal_send(int player,char what)
{
  /*
   * Correct for the different array indices - again... :-)
   */

  player--;
  if(what == '\r') { PUTIN(connections [player].output,'\n'); }
  PUTIN(connections [player].output,what);
}

extern void getcommand(int player,char *buffer)
{
  /*
   * Realm numbers sessions from 1.  Sigh; these Pascal programmers... :-)
   */

  player--;

  if(CONTAINSLINE(connections [player].input)) {
    int i;

    for(i = 0;i < 128;i++)
    {
      TAKEOUT(connections [player].input,buffer [i]);
      if(buffer [i] == '\n') {
	buffer [i] = 0;
	break;
      }
    }
  } else {
    buffer [0] = 1;
    buffer [1] = 0;
  }
}

/*
 * Functions for encrypting and testing passwords.  We use the standard Unix
 * password encryption routines.  Note that a password will match if it is
 * stored either clear or encrypted in the persona file.  This is to allow new
 * personae to be set up without messing about generating encrypted passwords.
 */

extern int compare_password(char *clear,char *pass)
{
  char *encrypted = crypt(clear,pass);

  if(! strcmp(clear,pass)) {
    printf("*** WARNING: Cleartext password found.\n");
    return 1;
  }
  return(! strcmp(encrypted,pass));
}

extern void password_crypt(char *pass)
{
  char setting [9];
  char *encoding = "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
  int salt = random() % (64*64);

  setting [0] = encoding [salt % 64];
  setting [1] = encoding [salt / 64];
  strcpy(pass,crypt(pass,setting));
}
