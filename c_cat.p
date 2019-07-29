{BufferedFile=1}

program realm_category_conversion;

type categ = RECORD
   name  : string[16];
   objects : array[1..16] of array[1..2] of integer;
   end;

var outfile : file of categ;
    infile : text;
    i : 1..16;

begin
reset(infile,'cat_out.txt');
rewrite(outfile,'categs.dat');
while not(eof(infile)) do
 begin
 readln(infile,outfile^.name);
 writeln(outfile^.name);
 for i:=1 to 16 do
  begin
  readln(infile,outfile^.objects[i,1]);
  readln(infile,outfile^.objects[i,2]);
  end;
 put(outfile);
 end;
close(infile);
close(outfile);
end.
