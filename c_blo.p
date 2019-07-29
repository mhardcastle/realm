{BufferedFile=1}

program realm_blow_conversion;

type blow_type = RECORD
  blow_sub : boolean;
  active : string[50];
  passive : string[50];
  invariant : string[50];
  end;

procedure readb(VAR infile : text; VAR result : boolean);

var tempst : string[10];

begin
readln(infile,tempst);
if tempst='true' then
        result:=true
else
        result:=false;
end;

var outfile : file of blow_type;
    infile : text;

begin
reset(infile,'blows.txt');
rewrite(outfile,'blows.dat');
while not(eof(infile)) do
 with outfile^ do
  begin
  readb(infile,blow_sub);
  readln(infile,active);
  readln(infile,passive);
  readln(infile,invariant);
  writeln(active,' ',invariant);
  put(outfile);
  end;
close(infile);
close(outfile);
end.
