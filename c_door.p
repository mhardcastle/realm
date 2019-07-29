{BufferedFile=1}

program realm_door_conversion;

type door = RECORD
   name  : string[40];
   first,
   second,
   key1,
   key2  : integer;
   open,
   break,
   openable,
   broken,
   s_hole  : boolean;
   end;

var infile : text;
    outfile : file of door;

procedure readb(VAR infile : text; VAR result : boolean);

var tempst : string;

begin
readln(infile,tempst);
if tempst='true' then
        result:=true
else
        result:=false;
end;

begin
reset(infile,'door_out.txt');
rewrite(outfile,'door.dat');
while not(eof(infile)) do
 with outfile^ do
  begin
  readln(infile,name);
  readln(infile,first);
  readln(infile,second);
  readln(infile,key1);
  readln(infile,key2);
  readb(infile,open);
  readb(infile,break);
  readb(infile,openable);
  readb(infile,broken);
  readb(infile,s_hole);
  put(outfile);
  end;
end.
