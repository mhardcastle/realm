{BufferedFile=1}

type	persona = ^pers_at;
	pers_at = RECORD
		 name,
		 epithet,
		 suffix,
		 passw		: string[20];
		 st,
		 con,
		 dex,
		 magic,
		 max_st,
		 max_con,
		 max_dex,
		 max_magic,
		 charisma,
		 kills,
		 width,
		 descr,
		 contdesc,
		 race,
		 class,
		 user,
		 tempflag,
		 times		: integer;
		 brief,
		 male,
		 registered,
		 compunet,
		 coder,
		 cursed,
		 blessed	: boolean;
		 sc,
		 expire,
		 off_until,
		 last_on,
		 voted,
		 minutes	: integer;
		 end;


var outfile : file of pers_at;
    coder    : pers_at;

begin
coder.name:='Coder';
coder.epithet:='';
coder.suffix:='';
coder.passw:='coder';
coder.st:=300;
coder.con:=300;
coder.dex:=300;
coder.magic:=300;
coder.max_st:=300;
coder.max_dex:=300;
coder.max_con:=300;
coder.max_magic:=300;
coder.charisma:=0;
coder.kills:=0;
coder.width:=80;
coder.descr:=39;
coder.contdesc:=79;
coder.class:=3;
coder.race:=1;
coder.tempflag:=0;
coder.times:=0;
coder.brief:=false;
coder.male:=true;
coder.registered:=true;
coder.compunet:=false;
coder.coder:=true;
coder.cursed:=false;
coder.blessed:=false;
coder.sc:=819200;
coder.expire:=0;
coder.off_until:=0;
coder.last_on:=0;
coder.voted:=0;
coder.minutes:=0;
rewrite(outfile,'personae.dat');
write(outfile,coder);
close(outfile);
end.
