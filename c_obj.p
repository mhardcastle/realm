{BufferedFile=1}

program realm_object_conversion;

type obj_at = RECORD
  name : string[20];
  location,
  descr,
  contdesc,
  size,
  weight,
  carries : integer;
  CASE mobile : boolean of
  true: ( movem : string[10];
     st,
     con,
     dex,
     magic,
     max_st,
     max_con,
     max_dex,
     max_magic,
     control,
     weapon1,
     weapon2,
     connect,
     fighting,
     dislike,
     thirsty,
     drunk,
     race,
     class,
     obey  : integer;
     possessed,
     male,
     blind,
     deaf,
     dumb,
     crippled,
     glowing,
     invisible,
     cursed,
     blessed,
     shield,
     sleep  : boolean;
     sc  : integer );
     false: ( worth,
     slash,
     stab,
     hit,
     parry,
     armour,
     liquid,
     contsize,
     throw,
     bolts : integer;
     two_hand,
     flammable,
     light,
     burns,
     wearable,
     vorpal,
     worn,
     extinguish,
     c_liquid,
     kept : boolean );
     end;

var outfile : file of obj_at;
    infile : text;


procedure readb(VAR infile : text; VAR result : boolean);

var tempst : string[10];

begin
readln(infile,tempst);
if tempst='true' then
        result:=true
else
        result:=false;
end;


begin
reset(infile,'ob_out.txt');
rewrite(outfile,'objects.dat');
while not(eof(infile)) do
 with outfile^ do
  begin
  readln(infile,name);
  readln(infile,location);
  if location=123 then writeln(name);
  readln(infile,descr);
  readln(infile,contdesc);
  readln(infile,size);
  readln(infile,weight);
  readln(infile,carries);
  readb(infile,mobile);
  if mobile then
   begin
   readln(infile,movem);
   readln(infile,max_st);
   st:=max_st;
   readln(infile,max_dex);
   dex:=max_dex;
   readln(infile,max_con);
   con:=max_con;
   readln(infile,max_magic);
   magic:=max_magic;
   readln(infile,race);
   readln(infile,class);
   readln(infile,obey);
   readb(infile,male);
   readb(infile,sleep);
   readln(infile,sc);
   fighting:=0;
   weapon1:=0;
   dislike:=0;
   weapon2:=0;
   connect:=0;
   control:=0;
   thirsty:=0;
   drunk:=0;
   glowing:=false;
   invisible:=false;
   possessed:=false;
   blind:=false;
   deaf:=false;
   dumb:=false;
   crippled:=false;
   cursed:=false;
   blessed:=false;
   shield:=false;
   end
  else
   begin
   readln(infile,worth);
   readln(infile,slash);
   readln(infile,stab);
   readln(infile,hit);
   readln(infile,parry);
   readln(infile,armour);
   readln(infile,liquid);
   readln(infile,contsize);
   readln(infile,throw);
   readln(infile,bolts);
   readb(infile,two_hand);
   readb(infile,flammable);
   readb(infile,light);
   readb(infile,burns);
   readb(infile,wearable);
   readb(infile,worn);
   readb(infile,extinguish);
   readb(infile,c_liquid);
   vorpal:=false;
   kept:=false;
   end;
  put(outfile);
  end;
close(infile);
close(outfile);
end.
