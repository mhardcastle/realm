{BufferedFile=1}

program realm_location_conversion;

type location = RECORD
   name  : string[16];
   exit  : array [1..12] of integer;
   dark,
   wet,
   day  : boolean;
   end;

var outfile : file of location;
    infile : text;
    i : 1..12;
    n : integer;

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
reset(infile,'locat.txt');
rewrite(outfile,'location.dat');
n:=1;
while not(eof(infile)) do
 with outfile^ do
  begin
  readln(infile,name);
  if ((((n-1) DIV 50)*50)=(n-1)) then writeln(name);
  for i:=1 to 12 do
   readln(infile,exit[i]);
  readb(infile,dark);
  readb(infile,wet);
  readb(infile,day);
  put(outfile);
  n:=n+1;
  end;
close(infile);
close(outfile);
end.
