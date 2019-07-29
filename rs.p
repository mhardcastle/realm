{$M+,E+}

program realm_subroutines;

{$I realmhd.p}

type str17 = string[17];

function pascal_random : integer;
	external;

function shl(number, shift : integer) : integer;
	external;

function shr(number, shift : integer) : integer;
	external;

function systime : integer;
	external;

function gettime : integer;
	external;

function isupper(c : char) : boolean;external;
function isupper(c : char) : boolean;

	begin
	isupper:=c IN ['A'..'Z'];
	end;

function islower(c : char) : boolean;external;
function islower(c : char) : boolean;

	begin
	islower:=c IN ['a'..'z'];
	end;

function toupper(c : char) : char;external;
function toupper(c : char) : char;
	
	begin
	if islower(c) then
		toupper:=chr(ord(c)-ord('a')+ord('A'))
	else
		toupper:=c;
	end;

function tolower(c : char) : char;external;
function tolower(c : char) : char;
	
	begin
	if isupper(c) then
		tolower:=chr(ord(c)+ord('a')-ord('A'))
	else
		tolower:=c;
	end;

function isa(c : char) : boolean;external;
function isa(c : char) : boolean;

	begin
	c:=toupper(c);
	isa:=c IN ['A'..'Z'];
	end;

function isan(c : char) : boolean;external;
function isan(c : char) : boolean;

	begin
	c:=toupper(c);
	isan:=c IN ['A'..'Z', '0'..'9'];
	end;

procedure rdinc(VAR number : integer);external;
procedure rdinc(VAR number : integer);

	begin
	number:=number+1;
	if number>bufsize then number:=1;
	end;

procedure cr(whom : pm_range);
	external;

function findwidth(whom : player_range) : integer;external;
function findwidth(whom : player_range) : integer;

	begin
	if position[whom,5]=0 then
		findwidth:=default_wd
	else
		findwidth:=people[position[whom,5]]^.width-2;
	end;

procedure send(whom : pm_range; what : char);external;
procedure pascal_send(whom : pm_range; what : char);external;
procedure send(whom : pm_range; what : char);

	begin
	if whom<>0 then
		begin

		pascal_send(whom,what);
		buffer[whom,position[whom,3]]:=what;
		rdinc(position[whom,3]);
		if what>=' ' then position[whom,2]:=position[whom,2]+1;
		if what=#8 then position[whom,2]:=position[whom,2]-1;
		if what=#13 then position[whom,2]:=0;
		if position[whom,2]>findwidth(whom) then
			cr(whom);
		if position[whom,7]<>0 then
			send(position[whom,7],what);
		if position[whom,9]<>0 then
			send(position[whom,9],what);
		end;
	end;

procedure cr;

var lp	: integer;

	begin
	if whom<>0 then
		begin
		send(whom,#13);
		for lp:=1 to position[whom,10] do
			send(whom,' ');
		end;
	end;

procedure tab(whom,xpos : integer);external;
procedure tab(whom,xpos : integer);

	begin
	if whom<>0 then
		begin
		if xpos>=findwidth(whom) then
			begin
			cr(whom);
			xpos:=xpos mod findwidth(whom);
			end;
		while position[whom,2]<xpos do
			send(whom,' ');
		end;
	end;

procedure wrst(whom : pm_range; what : str255);external;
procedure wrst(whom : pm_range; what : str255);

var curp,
    point	: integer;

	begin
	if whom<>0 then
		begin
		while length(what)>(findwidth(whom)-position[whom,2]) do
			begin
			curp:=findwidth(whom)-position[whom,2];
			while (what[curp]<>' ') and (curp>0) do
				curp:=curp-1;
			if curp=0 then
				begin
				curp:=findwidth(whom)-position[whom,2];
				if position[whom,2]<>0 then
					cr(whom);
				for point:=1 to curp do
					send(whom,what[point]);
				what:=copy(what,curp+1,length(what)-curp);
				end
			else
				begin 
				for point:=1 to curp-1 do
					send(whom,what[point]);
				if position[whom,2]>(findwidth(whom) div 2) then
					cr(whom);
				what:=copy(what,curp+1,length(what)-curp);
				end;
			end;
		for point:=1 to length(what) do
			send(whom,what[point]);
		end;
	end;

procedure wrtln(whom : pm_range; what : str255);external;
procedure wrtln(whom : pm_range; what : str255);

	begin
	wrst(whom,what);
	cr(whom);
	end;

function curlen(posn : integer) : integer;external;
function curlen(posn : integer) : integer;

	begin
	if posn<>100 then
		if posn=13 then
			curlen:=78
		else 
			curlen:=19
	else
		curlen:=126;
	end;

procedure wrtint(whom : pm_range; x : integer);external;
procedure wrtint(whom : pm_range; x : integer);

var receive	: str255;
    lp		: integer;

	begin
	writev(receive,x);
	for lp:=1 to length(receive) do
		if ((receive[lp]>='0') and (receive[lp]<='9')) or (receive[lp]='-') then
			send(whom,receive[lp]);
	end;

function rnd(limit : integer) : integer;external;
function rnd(limit : integer) : integer;

	begin
	rnd:=((pascal_random DIV 2) MOD limit)+1;
	end;

procedure multiwrite(who : pm_range; to_write : str255);external;
procedure multiwrite(who : pm_range; to_write : str255);

var newstring	: str255;
    alternate	: array[1..4] of string[50];
    cpos,
    altcnt	: integer;

	{ takes in a string with alternatives in it & prints it out }
	begin
	if who<>0 then
		begin
		repeat
		cpos:=pos('{',to_write);
		if cpos<>0 then
			begin
			altcnt:=0;
			newstring:=copy(to_write,1,cpos-1);
			repeat
				altcnt:=altcnt+1;
				alternate[altcnt]:='';
				cpos:=cpos+1;
				while (to_write[cpos]<>'/') and (to_write[cpos]<>'}') do
					begin
					alternate[altcnt]:=concat(alternate[altcnt],to_write[cpos]);
					cpos:=cpos+1;
					end;
			until (to_write[cpos]='}');
			wrst(who,newstring);
			wrst(who,alternate[rnd(altcnt)]);
			delete(to_write,1,cpos);
			end;
		until (cpos=0);
		wrst(who,to_write);
		end;
	end;

procedure return_time(ret : integer; var h,m,s : integer);external;
procedure return_time(ret : integer; var h,m,s : integer);

	begin
	s:=(ret & 31)*2;
	ret:=shr(ret,5);
	m:=ret & 63;
	ret:=shr(ret,6);
	h:=ret & 31;
	end;

procedure show_time(whom : player_range; time : integer);external;
procedure show_time(whom : player_range; time : integer);

var h,
    m,
    s	: integer;

	begin
	return_time(time,h,m,s);
	wrtint(whom,h);
	send(whom,':');
	wrtint(whom,m);
	send(whom,':');
	wrtint(whom,s);
	end;

procedure return_date(ret : integer; var d,m,y : integer);external;
procedure return_date(ret : integer; var d,m,y : integer);

	begin
	ret:=shr(ret,16);
	d:=ret & 31;
	ret:=shr(ret,5);
	m:=ret & 15;
	ret:=shr(ret,4);
	y:=1980+ret;
	end;

procedure show_date(whom : player_range; time : integer);external;
procedure show_date(whom : player_range; time : integer);

var d,
    m,
    y	: integer;
    
	begin
	return_date(time,d,m,y);
	wrtint(whom,d);
	send(whom,'/');
	wrtint(whom,m);
	send(whom,'/');
	wrtint(whom,y);
	end;

function add_days(time : integer; days : integer) : integer;external;
function add_days(time : integer; days : integer) : integer;

var d,m,y,lp,len : integer;
    store, ret	: integer;

	begin
	return_date(time,d,m,y);
	for lp:=1 to days do
		begin
		d:=d+1;
		case m of
			2:
				len:=28;
			9,4,6,11:
				len:=30;
			otherwise
				len:=31;
			end;
		if d>len then
			begin
			d:=1;
			m:=m+1;
			if m>12 then
				begin
				m:=1;
				y:=y+1;
				end;
			end;
		end;
	store:=d;
	ret:=shl(store,16);
	store:=m;
	ret:=ret+shl(store,21);
	store:=y-1980;
	ret:=ret+shl(store,25);
	add_days:=ret;
	end;

procedure ban(who,connect,days : integer);external;
procedure ban(who,connect,days : integer);

var d,m,y : integer;

	begin
	if people[who]^.off_until=0 then
		people[who]^.off_until:=gettime;
	people[who]^.off_until:=add_days(people[who]^.off_until,days);
	wrst(connect,'You may not log on again until ');
	show_date(connect,people[who]^.off_until);
	wrtln(connect,'.');
	end;

function get_number(num : str255) : integer;external;
function get_number(num : str255) : integer;

var result	: integer;
    pointer	: integer;

	begin
	pointer:=1;
	result:=0;
	while NOT(num[pointer] IN ['0'..'9']) and (pointer<=length(num)) do
		pointer:=pointer+1;
	if pointer>length(num) then
		result:=-1
	else
		begin
		while (num[pointer] in ['0'..'9']) and (result<999999) and (pointer<=length(num)) do
			begin
			result:=result*10;
			result:=result+(ord(num[pointer])-48);
			pointer:=pointer+1;
			end;
		end;
	get_number:=result;
	end;

function fromlist(f,t : integer) : integer;external;
function fromlist(f,t : integer) : integer;

	begin
	fromlist:=number[(f-1)+rnd((t-f)+1)];
	end;

procedure dotext(whom,st,fin : integer);external;
procedure dotext(whom,st,fin : integer);

var lp	: integer;

	begin
	for lp:=st to fin do
		wrst(whom,tdata[lp]);
	cr(whom);
	end;
	
procedure show_main_menu(whom : pm_range; whole : boolean);external;
procedure show_main_menu(whom : pm_range; whole : boolean);

var l : integer;

	begin
	cr(whom);
	if whole then
		begin
		for l:=1 to 15 do
			wrtln(whom,tdata[l]);
		cr(whom);
		wrst(whom,'Which option ? ');
		end
	else
		wrst(whom,'Which option (RETURN for list)? ');
	for l:=1 to top do
		if position[l,9]=whom then
			position[l,9]:=0;
	end;

function opposite(old : integer) : integer;external;
function opposite(old : integer) : integer;

       	begin
       	case old of
       		1:
       			opposite:=2;
       		2:
        		opposite:=1;
        	3:
       			opposite:=4;
       		4:
       			opposite:=3;
       		5:
       			opposite:=8;
       		6:
       			opposite:=7;
       		7:
       			opposite:=6;
       		8:
       			opposite:=5;
       		otherwise
       			opposite:=rnd(4);
       		end;
       	end;

function f_level(who : integer) : integer;external;
function f_level(who : integer) : integer;

var lp		: integer;
    testsc	: integer;

	begin
	lp:=1;
	testsc:=200;
	while ob[who].sc>=testsc do
		begin
		testsc:=testsc*2;
		lp:=lp+1;
		end;
	f_level:=lp;
	end;

procedure log(action : str255);external;
procedure log(action : str255);

var h,
    m,
    s,
    lp	: integer;

	begin
	for lp:=87 to no_ob do
		if (ob[lp].location>0) and ob[lp].mobile then
				if f_level(lp)>11 then
					wrtln(ob[lp].connect,concat('LOG : ',action));
	return_time(gettime,h,m,s);
	writeln(log_file,h : 2,':',m : 2,' - ',action);
	end;

procedure set_event(kind,flag,flag2 : integer; time : integer);external;
procedure set_event(kind,flag,flag2 : integer; time : integer);

	begin
	if no_events=max_event then
		log('System error - no event space!')
	else
		begin
		no_events:=no_events+1;
		event[no_events].kind:=kind;
		event[no_events].flag:=flag;
		event[no_events].flag2:=flag2;
		event[no_events].time:=time+systime;
		end;
	end;

procedure remove_event(which : integer);external;
procedure remove_event(which : integer);

var lp : integer;
	
	begin
	for lp:=which+1 to no_events do
		begin
		if (event[lp].kind=3) then cur_b[event[lp].flag,4]:=lp-1;
		event[lp-1]:=event[lp];
		end;
	no_events:=no_events-1;
	end;

procedure destroy_event(kind,flag : integer);external;
procedure destroy_event(kind,flag : integer);

var lp		: integer;
    found	: boolean;

	begin
	found:=false;
	lp:=1;
	while not(found) and (lp<=no_events) do
		begin
		if (event[lp].kind=kind) and (event[lp].flag=flag) then
			begin
			found:=true;
			remove_event(lp);
			end;
		lp:=lp+1;
		end;
	end;

procedure generate_maze(jstart,jend,pstart,pend,dstart,dend,centre : integer);external;
procedure generate_maze(jstart,jend,pstart,pend,dstart,dend,centre : integer);

var j_orig,
    p_orig,
    d_orig,
    c_orig,
    olp,
    lp		: integer;

	function count_exit(room : integer) : integer;

	var lp,
	    count	: 1..12;

        	begin
        	count:=0;
        	for lp:=1 to 12 do
        		if places[room].value[lp]<>0 then
        			count:=count+1;
        	count_exit:=count;
        	end;

	procedure do_exits(room : integer);
	
	var new_exit,
	    old_exit,
	    new_room,
	    j_no,
	    p_no,
	    d_no,
	    choice,
	    lp,
	    times	: integer;
	    carry_on	: boolean;
	
	        function proper_exit(room : integer) : integer;
	        	
	        var no_exits	: integer;
	        	
	        	begin
		        no_exits:=0;
		        if (room>=j_orig) and (room<=jend) then
	        		no_exits:=1+rnd(3);
		        if (room>=p_orig) and (room<=pend) then
		        	no_exits:=2;
	        	if ((room>=d_orig) and (room<=dend)) or (room=centre) then
	        		no_exits:=1;
	        	proper_exit:=no_exits;
	        	end;

	        begin
	        carry_on:=true;
		while (count_exit(room)<proper_exit(room)) and carry_on do
	        	begin
	        	{ now choose a room }
	        	times:=0;
	        	repeat
				times:=times+1;
				new_room:=1;
				j_no:=jend-jstart+1;
		        	p_no:=pend-pstart+1;
	        		d_no:=dend-dstart+1;
				if (d_no+p_no+j_no)<>0 then
					begin
		        		choice:=rnd(j_no+p_no+d_no);
		        		if (choice>(j_no+p_no)) and (count_exit(dstart)<proper_exit(dstart)) then
	        				begin
	        				new_room:=dstart;
	        				dstart:=dstart+1;
	        				end
		        		else
		        			if (choice>j_no) and (count_exit(pstart)<proper_exit(dstart)) then
	        					begin
	        					new_room:=pstart;
	        					pstart:=pstart+1;
	        					end
		        			else
		        				if (count_exit(jstart)<4) then
								begin
		        					new_room:=jstart;
	        						jstart:=jstart+1;
	        						end;
					end
				else
					times:=50;
	        	until (count_exit(new_room)<proper_exit(new_room)) or (times=50);
	        	if times=50 then
				carry_on:=false
	        	else
	        		begin
				times:=0;
				repeat
			        	times:=times+1;
					{ choose an exit }
			        	if (room>=p_orig) and (room<=pend) then
	        				begin
	        				old_exit:=0;
	        				for lp:=1 to 4 do
			        			if places[room].value[lp]<>0 then
			        				old_exit:=lp;
			        		new_exit:=opposite(old_exit);
		        			end
		        		else
		        			new_exit:=rnd(4);
		        	until ((places[room].value[new_exit]=0) and (places[new_room].value[opposite(new_exit)]=0)) or (times>100);
				if times<=100 then
					begin
			        	places[room].value[new_exit]:=new_room;
			        	places[new_room].value[opposite(new_exit)]:=room;
					if (dstart<=dend) then
						do_exits(new_room);
					end;
				end;
			end;
		end;

	begin
	j_orig:=jstart;
	p_orig:=pstart;
	d_orig:=dstart;
	jstart:=jstart+1;
	olp:=0;
	for olp:=1 to 25 do
		for lp:=j_orig to jstart do
			while (dstart-d_orig<(((dend-d_orig)*3) div 4)) and (count_exit(lp)<4) and (count_exit(lp)<>0) do
				do_exits(lp);
	while (centre<>0) and (dstart>=d_orig) do
		begin
		dstart:=dstart-1;
		if count_exit(dstart)<>0 then
			begin
			for lp:=1 to 4 do
				if places[dstart].value[lp]<>0 then
					olp:=lp;
			places[places[dstart].value[olp]].value[opposite(olp)]:=centre;
			places[centre].value[olp]:=places[dstart].value[olp];
			centre:=0;
			end;
		end;
	end;

procedure reset_objs;external;
procedure reset_objs;

var lp,
    junk	: integer;

	begin
	reset(door_file,concat(main_drv,'door.dat'));
	no_door:=0;
	while not(eof(door_file)) do
		begin
		no_door:=no_door+1;
		read(door_file,doors[no_door]);
		end;
	close(door_file);
	reset(loc_file,concat(main_drv,'location.dat'));
	no_place:=0;
	while not(eof(loc_file)) do
		begin
		no_place:=no_place+1;
		read(loc_file,places[no_place]);
		end;
	close(loc_file);
	reset(obj_file,concat(main_drv,'objects.dat'));
	no_ob:=0;
	while not(eof(obj_file)) do
		begin
		no_ob:=no_ob+1;
		read(obj_file,ob[no_ob]);
		if ob[no_ob].mobile then
			begin
			ob[no_ob].control:=0;
			ob[no_ob].connect:=0;
			ob[no_ob].fighting:=0;
			ob[no_ob].weapon1:=0;
			ob[no_ob].weapon2:=0;
			ob[no_ob].dislike:=0;
			end
		else
			ob[no_ob].vorpal:=false;
		end;
	close(obj_file);
	fixed_ob:=no_ob;
	for lp:=no_ob+1 to maxobject do
		begin
		ob[lp].name:='';
		ob[lp].location:=-1;
		ob[lp].carries:=0;
		end;
	{ assigns certain objects to random range of locations }
	for lp:=79 to 86 do
		ob[lp].location:=fromlist(31,46);
	ob[3].location:=fromlist(47,60);
	ob[114].location:=fromlist(81,85);
	for lp:=5 to 9 do
		ob[lp].location:=fromlist(47,60);
	for lp:=21 to 30 do
		ob[number[lp]].location:=fromlist(61,80);
	ob[213].location:=rnd(122);
	{ sets certain flags to null values }
	blow_no:=0;
	lever1:=false;
	lever2:=false;
	ice_melt:=false;
	water_f:=false;
	wall_hole:=false;
	sesame:=false;
	palm_dig:=0;
	volcano:=true;
	kobolds_bl:=true;
	nine_to_1:=false;
	pandora_per:=0;
	stocks:=0;
	glass_sh:=true;
	mirror:=true;
	ice_pond:=true;
	seaweed:=true;
	clockwnd:=false;
	clockwk:=true;
	rockfall:=true;
	tree:=true;
	garg_pd:=false;
	grassburn:=false;
	dragonwoken:=false;
	resetting:=false;
	duckfl:=true;
	peace:=false;
	acidlake:=1;
	nastytree:=true;
	balloon:=0;
	turnstile:=true;
	return_time(gettime,r_h,r_m,r_s);
	r_h:=(r_h+1) mod 24;
	volc_mins:=(r_m+rnd(50)) mod 60;
	weather:=sunny;
	new_weather:=sunny;
	w_time:=100;
	arena_bonus:=0;
	no_wall:=0;
	no_fol:=0;
	no_ssn:=0;
	pirate:=396;
	no_events:=0;
	whosays:=0;
	for lp:=1 to 20 do
		resisting[lp]:=0;
	set_event(2,0,0,10);
	set_event(4,0,0,6000);
	set_event(8,0,0,400);
	set_event(9,0,0,2000);
	set_event(11,0,0,15000);
	set_event(13,0,0,100);
	set_event(15,0,0,500);
	set_event(20,0,0,12000);
	set_event(21,0,0,600);
	{ Re-seed the random number generator }
	{for lp:=1 to r_s do
		junk:=rnd(2); -- shouldn't be needed on decent machines :-) }
	{ and finally, do the two mazes }
        generate_maze(711,724,725,732,733,742,710);
	generate_maze(744,751,752,760,761,770,743);
	end;

procedure initialise;external;
procedure initialise;

var loop1,
    loop2,
    countpos	: integer;
    tempst	: line;
    spaceused	: integer;

	begin
	tcode[1]:=$2039;
	tcode[2]:=0;
	tcode[3]:=$4BA;
	tcode[4]:=$4E75;
	for loop1:=1 to top do
		begin
		position[loop1,1]:=1;
		position[loop1,2]:=0;
		position[loop1,3]:=1;
		position[loop1,4]:=1;
		position[loop1,5]:=0;
		position[loop1,8]:=0;
		position[loop1,9]:=0;
		position[loop1,10]:=0;
		position[loop1,11]:=0;
		position[loop1,14]:=0;
		end;
	writeln('Reading files, please wait:');
	writeln('...realm.inf');
	reset(infile,'realm.inf');
	readln(infile,main_drv);
	readln(infile,locs_drv);
	readln(infile,tempst);
	swap:=tempst[1]='Y';
	readln(infile,tempst);
	memory:=tempst[1]='Y';
	readln(infile,default_wd);
	readln(infile,tempst);
	register:=tempst[1]='Y';
	readln(infile,tempst);
	cnet:=tempst[1]='Y';
	close(infile);
	writeln('...personae.dat');
	reset(pers_file,concat(main_drv,'personae.dat'));
	no_people:=0;
	while not(eof(pers_file)) do
		begin
		no_people:=no_people+1;
		new(people[no_people]);
		read(pers_file,people[no_people]^);
		people[no_people]^.tempflag:=0; { everyone is off to start with }
		end;
	close(pers_file);
	writeln('...categs.dat');
	reset(cat_file,concat(main_drv,'categs.dat'));
	no_cat:=0;
	while not(eof(cat_file)) do
		begin
		no_cat:=no_cat+1;
		read(cat_file,categs[no_cat]);
		end;
	close(cat_file);
	writeln('...blows.dat');
	reset(blow_file,concat(main_drv,'blows.dat'));
	for loop1:=1 to 18 do
		read(blow_file,blows[loop1]);
	close(blow_file);
	writeln('...numbers.txt');
	reset(infile,concat(main_drv,'numbers.txt'));
	for loop1:=1 to 85 do
		readln(infile,number[loop1]);
	close(infile);
	reset_objs;
	if swap then
		begin
		writeln('Insert locations disc into working drive & press RETURN.');
		readln;
		end;
	writeln('...game.txt');
	reset(infile,concat(locs_drv,'game.txt'));
	for loop1:=1 to 189 do
		readln(infile,tdata[loop1]);
	close(infile);
	writeln('...descs.txt');
	reset(infile,concat(locs_drv,'descs.txt'));
	no_desc:=1;
	while not eof(infile) do
		begin
		readln(infile,descs[no_desc]);
		no_desc:=no_desc+1;
		end;
	close(infile);
	writeln('...verbs.txt');
	reset(infile,concat(locs_drv,'verbs.txt'));
	no_verb:=0;
	while not(eof(infile)) do
		begin
		no_verb:=no_verb+1;
		readln(infile,verb[no_verb]);
		end;
	close(infile);
	writeln('...levels.txt');
	reset(infile,concat(locs_drv,'levels.txt'));
	for loop1:=1 to 100 do
		readln(infile,level[loop1]);
	close(infile);
	writeln('...races.txt');
	reset(infile,concat(locs_drv,'races.txt'));
	for loop1:=1 to 12 do
		readln(infile,races[loop1]);
	close(infile);
	writeln('...fight.txt');
	reset(infile,concat(locs_drv,'fight.txt'));
	for loop1:=1 to 97 do
		readln(infile,fight[loop1]);
	close(infile);
	writeln('...riddles.txt');
	reset(infile,concat(locs_drv,'riddles.txt'));
	no_riddle:=0;
	while not(eof(infile)) do
		begin
		no_riddle:=no_riddle+1;
		readln(infile,riddle[no_riddle].question);
		if not(eof(infile)) then
			readln(infile,riddle[no_riddle].answer1);
		if not(eof(infile)) then
			readln(infile,riddle[no_riddle].answer2);
		end;
	close(infile);
	writeln('...swears.txt');
	reset(infile,concat(locs_drv,'swears.txt'));
	swears:=0;
	while not(eof(infile)) do
		begin
		swears:=swears+1;
		readln(infile,swear[swears]);
		end;
	close(infile);
	writeln('...moveerrs.txt');
	reset(infile,concat(locs_drv,'moveerrs.txt'));
	loop1:=1;
	while not(eof(infile)) do
		begin
		readln(infile,exerrs[loop1]);
		loop1:=loop1+1;
		end;
	close(infile);
	writeln('...sysmess.txt');
	reset(infile,concat(locs_drv,'sysmess.txt'));
	no_sysm:=0;
	while not(eof(infile)) and (no_sysm<50) do
		begin
		no_sysm:=no_sysm+1;
		readln(infile,sysmess[no_sysm]);
		end;
	close(infile);
	writeln('...fluids.txt');
	reset(infile,concat(locs_drv,'fluids.txt'));
	no_liquids:=0;
	loop1:=0;
	while not(eof(infile)) do
		begin
		no_liquids:=no_liquids+1;
		readln(infile,liquids[no_liquids].name);
		readln(infile,liquids[no_liquids].describe);
		readln(infile,liquids[no_liquids].howmany);
		for loop2:=1 to liquids[no_liquids].howmany do
			begin
			loop1:=loop1+1;
			readln(infile,liqloc[loop1]);
			end;
		end;
	close(infile);
	writeln('...emotes.txt');
	reset(infile,concat(locs_drv,'emotes.txt'));
	no_emote:=0;
	while not(eof(infile)) do
		begin
		no_emote:=no_emote+1;
		readln(infile,emotes[no_emote].vrb);
		readln(infile,tempst);
		emotes[no_emote].audio:=(tempst[1]='A');
		readln(infile,emotes[no_emote].what);
		end;
	close(infile);
	writeln('...spellvb.txt');
	reset(infile,concat(locs_drv,'spellvb.txt'));
	for loop1:=1 to 28 do
		begin
		readln(infile,spellvb[loop1].words);
		readln(infile,tempst);
		spellvb[loop1].spoken:=(tempst[1]='A');
		end;
	close(infile);
	writeln('...coder.txt');
	reset(infile,concat(locs_drv,'coder.txt'));
	no_coder:=0;
	while not(eof(infile)) and (no_coder<50) do
		begin
		no_coder:=no_coder+1;
		readln(infile,coder[no_coder]);
		end;
	close(infile);
	no_help:=0;
	writeln('...help.txt');
	reset(infile,concat(locs_drv,'help.txt'));
	loop1:=1;
	while not(eof(infile)) do
		begin
		no_help:=no_help+1;
		readln(infile,help_item[no_help].name);
		help_item[no_help].startline:=loop1;
			repeat
			readln(infile,tempst);
			if (tempst<>'@') and (tempst<>'*') then
				begin
				help_txt[loop1]:=tempst;
				loop1:=loop1+1;
				end;
			until (tempst='@') or (tempst='*');
		help_item[no_help].endline:=loop1-1;
		help_item[no_help].immortal:=(tempst='*');
		end;
	close(infile);
	writeln('...examine.txt');
	reset(infile,concat(locs_drv,'examine.txt'));
	no_exam:=0;
	while not(eof(infile)) do
		begin
		no_exam:=no_exam+1;
		new(examine[no_exam]);
		readln(infile,examine[no_exam]^.what);
		readln(infile,tempst);
		examine[no_exam]^.read:=tempst[1] IN ['r','R'];
		examine[no_exam]^.when_carried:=isupper(tempst[1]);
		examine[no_exam]^.lines:=0;
		repeat
			readln(infile,tempst);
			if tempst[1]<>'@' then
				begin
				examine[no_exam]^.lines:=examine[no_exam]^.lines+1;
				new(examine[no_exam]^.examtxt[examine[no_exam]^.lines]);
				examine[no_exam]^.examtxt[examine[no_exam]^.lines]^:=tempst;
				end;
		until (tempst[1]='@') or eof(infile);
		end;
	close(infile);
	writeln('...virtual.txt');
	reset(infile,concat(locs_drv,'virtual.txt'));
	no_virtual:=0;
	countpos:=1;
	while not(eof(infile)) do
		begin
		no_virtual:=no_virtual+1;
		readln(infile,virtuals[no_virtual].name);
		readln(infile,virtuals[no_virtual].howmany);
		for loop1:=1 to virtuals[no_virtual].howmany do
			begin
			virtuals[no_virtual].lines[loop1]:=0;
			repeat
				readln(infile,tempst);
				if (tempst[1]<>'@') and (tempst[1]<>'*') then
					begin
					virtuals[no_virtual].lines[loop1]:=virtuals[no_virtual].lines[loop1]+1;
					new(virtuals[no_virtual].examtxt[loop1,virtuals[no_virtual].lines[loop1]]);
					virtuals[no_virtual].examtxt[loop1,virtuals[no_virtual].lines[loop1]]^:=tempst;
					end;
			until (tempst[1]='@') or (tempst[1]='*');
			virtuals[no_virtual].door_f[loop1]:=(tempst[1]='*');
			readln(infile,virtuals[no_virtual].rooms[loop1,2]);
			virtuals[no_virtual].rooms[loop1,1]:=countpos;
			for loop2:=1 to virtuals[no_virtual].rooms[loop1,2] do
				begin
				readln(infile,vlocs[countpos]);
				countpos:=countpos+1;
				end;
			end;
		end;
	close(infile);
	writeln('...mobacts.txt');
	reset(infile,concat(locs_drv,'mobacts.txt'));
	no_acts:=0;
	while not(eof(infile)) do
		begin
		no_acts:=no_acts+1;
		readln(infile,acts[no_acts].which);
		readln(infile,tempst);
		acts[no_acts].hear:=(tempst='A');
		readln(infile,acts[no_acts].what);
		end;
	close(infile);
	writeln('...l_info.dat');
	reset(desfile,concat(locs_drv,'l_info.dat'));
	if memavail<(maxlsize div 2) then memory:=false;
	if memory then
		begin
		new(loctxt);
		reset(desfile,concat(locs_drv,'l_info.dat'));
		l_pointer[1]:=0;
		for loop1:=1 to no_place do
			begin
			lp:=512;
			while desfile^[lp]=' ' do
				lp:=lp-1;
			for loop2:=1 to lp do
				loctxt^[l_pointer[loop1]+loop2-1]:=desfile^[loop2];
			l_pointer[loop1+1]:=l_pointer[loop1]+lp;
			get(desfile);
			end;
		close(desfile);
		end;
	if swap then
		begin
		writeln('Insert main disc into working drive & press RETURN.');
		readln;
		end;
	rewrite(log_file,concat(main_drv,'log.txt'));
	if not(cnet) then 
		begin
		writeln('...message.dat');
		reset(mess_file,concat(main_drv,'message.dat'));
		messageno:=0;
		seek(mess_file,0);
		while not(eof(mess_file)) do
			begin
			get(mess_file);
			messageno:=messageno+1;
			end;
		messageno:=messageno-1;
		end;
	logoffst:='NO CARRIER';
	psize[1]:=1;
	psize[2]:=16;
	psize[3]:=3;
	pers_edit:=0;
	blackpt:=0;
	end;

procedure tellwiz(action : str255);external;
procedure tellwiz(action : str255);

var lp : integer;

	begin
	for lp:=87 to no_ob do
		if (ob[lp].location>0) and ob[lp].mobile then
			if f_level(lp)>11 then
				wrtln(ob[lp].connect,concat('Immortals'' info : ',action));
	end;

procedure dir_string(dir : integer; caps : boolean);external;
procedure dir_string(dir : integer; caps : boolean);

	begin
	case dir of
		1:
			dirs:='north';
		2:
			dirs:='south';
		3:
			dirs:='west';
		4:
			dirs:='east';
		5:
			dirs:='northwest';
		6:
			dirs:='northeast';
		7:
			dirs:='southwest';
		8:
			dirs:='southeast';
		9:
			dirs:='up';
		10:
			dirs:='down';
		11:
			dirs:='inside';
		12:
			dirs:='out';
		otherwise
			dirs:='error';
		end;
	if caps then
		dirs[1]:=chr(ord(dirs[1])-32);
	end;

procedure new_object(VAR variable : integer);external;
procedure new_object(VAR variable : integer);

{ overhauled version 30/12/90. Returns the next free position in the
  object array. }

	begin
	variable:=fixed_ob+1;
	while (ob[variable].location<>-1) and (variable<=maxobject) do
		variable:=variable+1;
	if variable>maxobject then
		begin
		log('WARNING - Maximum object number exceeded! Overwriting object 1.');
		variable:=1;
		end
	else
		if variable>no_ob then
			begin
			no_ob:=variable;
			categs[1].objects[1,2]:=no_ob;
			end;
	end;

procedure add_ssn(who : integer);external;
procedure add_ssn(who : integer);

	begin
	if no_ssn=10 then
		log('WARNING - Supersnoop allocation exceeded!')
	else
		begin
		no_ssn:=no_ssn+1;
		wrtln(ob[who].connect,'Now supersnooping.');
		ssn[no_ssn]:=who;
		end;
	end;

procedure remove_ssn(who : integer);external;
procedure remove_ssn(who : integer);

var lp,
    lp2		: integer;

	begin
	for lp:=1 to no_ssn do
		if ssn[lp]=who then
			begin
			wrtln(ob[who].connect,'No longer supersnooping.');
			for lp2:=lp to no_ssn-1 do
				ssn[lp2]:=ssn[lp2+1];
			no_ssn:=no_ssn-1;
			end;
	end;

function being_fought(who : integer) : integer;external;
function being_fought(who : integer) : integer;

var lp,
    no : integer;

	begin
	no:=0;
	for lp:=87 to no_ob do
		if (ob[lp].location>0) and ob[lp].mobile then
			if (ob[lp].fighting=who) and not(ob[lp].sleep) then
				no:=no+1;
	being_fought:=no;
	end;

function find_door(lieu : integer) : integer;external;
function find_door(lieu : integer) : integer;

var dloop,
    rval : integer;

	begin
	rval:=0;
	for dloop:=1 to no_door do
		if (doors[dloop].first=lieu) or (doors[dloop].second=lieu) then
			rval:=dloop;
	find_door:=rval;
	end;

function blind_q(who : integer) : boolean;external;
function blind_q(who : integer) : boolean;

var blindfold	: boolean;

	begin
	if (ob[146].carries=who) and ob[146].worn then
		blindfold:=true
	else
		blindfold:=false;
	blind_q:=blindfold or ob[who].blind;
	end;

function real_loc(what : integer) : integer;external;
function real_loc(what : integer) : integer;

	begin
	while ob[what].carries<>0 do
		what:=ob[what].carries;
	real_loc:=ob[what].location;
	end;

function dark(where,who : integer) : boolean;external;
function dark(where,who : integer) : boolean;

var lp		: integer;
    tempdk	: boolean;

	begin
	if not(places[where].dark) then
		dark:=false
	else
		begin
		tempdk:=true;
		for lp:=1 to no_ob do
			if not(ob[lp].mobile) then
				begin
				if ob[lp].light then
					if real_loc(lp)=where then
						tempdk:=false;
				end
			else
				if ob[lp].glowing then
					if ob[lp].location=where then
						tempdk:=false;
		for lp:=1 to no_wall do
			if ((walls[lp].where1=where) or (walls[lp].where2=where)) and walls[lp].fire then
				tempdk:=false;
		{ some mobiles can see in the dark }
		if ((who>=94) and (who<=99)) or (who=104) or ((who>=149) and (who<=151)) or
			((who>=117) and (who<=124)) or (who=195) then tempdk:=false;
		dark:=tempdk;
		end;
	end;

function cant_see_obj(who,what : integer) : boolean;external;
function cant_see_obj(who,what : integer) : boolean;

var cant_see	: boolean;

	begin
	cant_see:=false;
	while ob[what].carries<>0 do
		what:=ob[what].carries;
	if dark(ob[what].location,who) then cant_see:=true;
	if (what<>who) and ob[what].mobile and ob[what].invisible then cant_see:=true;
	if blind_q(who) then cant_see:=true;
	cant_see_obj:=cant_see;
	end;

procedure shortname(who,whom : integer; caps,pronoun,notsee : boolean);external;
procedure shortname(who,whom : integer; caps,pronoun,notsee : boolean);

	begin
	if cant_see_obj(whom,who) and notsee then
		if pronoun then
			if caps then
				wrst(ob[whom].connect,'It')
			else
				wrst(ob[whom].connect,'it')
		else
			if caps then
				wrst(ob[whom].connect,'Something')
			else
				wrst(ob[whom].connect,'something')
	else
		if pronoun then
			if caps then
				if ob[who].male then
					wrst(ob[whom].connect,'He')
				else
					wrst(ob[whom].connect,'She')
			else
				if ob[who].male then
					wrst(ob[whom].connect,'he')
				else
					wrst(ob[whom].connect,'she')
		else
			if isupper(ob[who].name[1]) then
				wrst(ob[whom].connect,ob[who].name)
			else
				begin
				if caps then
					wrst(ob[whom].connect,'The ')
				else
					wrst(ob[whom].connect,'the ');
				wrst(ob[whom].connect,ob[who].name);
				end;
	end;

procedure fullname(who,whom : integer);external;
procedure fullname(who,whom : integer);

var temp	: integer;
    lp		: 1..52;
    str		: string[25];
    str2	: string[25];

	begin
	if ob[who].mobile and (ob[who].control<>0) then
		begin
		lp:=f_level(who);
		if lp>12 then
			begin
			lp:=98+(2*(lp-13));
			if ob[who].male then lp:=lp-1;
			end
		else
			begin
			lp:=lp+(24*(ob[who].class-1));
			if not(ob[who].male) then lp:=lp+12;
			end;
		str:=people[ob[who].control]^.epithet;
		if (str='') and (ob[who].race>1) then
			str:=races[ob[who].race];
		if str<>'' then str:=concat(str,' ');
		str2:=people[ob[who].control]^.suffix;
		if str2='' then
			str2:=level[lp];
		wrst(ob[whom].connect,ob[who].name);
		wrtln(ob[whom].connect,concat(' the ',str,str2));
		end
	else
		begin
		shortname(who,whom,true,false,false);
		cr(ob[whom].connect);
		end;
	end;

function sign(what : integer) : integer;external;
function sign(what : integer) : integer;

	begin
	if what<0 then
		sign:=-1
	else
		if what>0 then
			sign:=1
		else
			sign:=0;
	end;

procedure tellall(where,except : integer; what : str255; blind_s, deaf_s : boolean);
	external;

procedure act(who : integer; what : str255; blind_s, deaf_s : boolean);
	external;

procedure score_point(who : integer; points : integer);external;
procedure score_point(who : integer; points : integer);

var old_level,
    st_bonus,
    dex_bonus,
    con_bonus,
    magic_bonus,
    bonus,
    change_lp,
    biasvar,
    size	: integer;

	begin
	old_level:=f_level(who);
	if old_level>11 then
		wrtln(ob[who].connect,'Your score can''t change, you''re an Immortal.')
	else
		begin
		ob[who].sc:=ob[who].sc+points;
		if (ob[who].sc>10000) and (ob[who].control<>0) and not(register) then
			if not(people[ob[who].control]^.registered or people[ob[who].control]^.compunet) then
				begin
				wrtln(ob[who].connect,'Non-registered users can''t score above 10,000 points. REGISTER!');
				ob[who].sc:=ob[who].sc-points;
				end;
		if ob[who].sc<0 then
			ob[who].sc:=0;
		if ob[who].sc>=204800 then
			begin
			ob[who].sc:=204800;
			dotext(ob[who].connect,179,187);
			tellall(ob[who].location,who,'A bearded old man with a glowing staff appears suddenly!',true,false);
			act(who,'is spoken to briefly by the old man, who then vanishes.',true,false);
			end;
		wrst(ob[who].connect,'Score: ');
		wrtint(ob[who].connect,ob[who].sc);
		wrtln(ob[who].connect,'.');
		if old_level<>f_level(who) then
			begin
			wrst(ob[who].connect,'You are now ');
			fullname(who,who);
			if ob[who].control<>0 then
				tellwiz(concat(ob[who].name,' has just changed level.'));
			for change_lp:=1 to abs(old_level-f_level(who)) do
				begin
				biasvar:=rnd(3);
				magic_bonus:=3+rnd(3);
				size:=19;
				if ob[who].class=2 then
					begin
					if rnd(4)<2 then
						biasvar:=3;
					size:=18;
					end;
				if ob[who].class>2 then
					size:=16;
				if ob[who].race=4 then
					size:=size-2;
				if ob[who].race=2 then
					size:=size-1;
				if ob[who].class<3 then
					case biasvar of
						1:
							begin
							st_bonus:=rnd(size);
							dex_bonus:=rnd(size);
							con_bonus:=(size*2)-(st_bonus+dex_bonus);
							end;
						2:
							begin
							dex_bonus:=rnd(size);
							con_bonus:=rnd(size);
							st_bonus:=(size*2)-(con_bonus+dex_bonus);
							end;
						3:
							begin
							con_bonus:=rnd(size);
							st_bonus:=rnd(size);
							dex_bonus:=(size*2)-(st_bonus+con_bonus);
							end;
					end
				else
					begin
					st_bonus:=rnd(size);
					dex_bonus:=rnd(size);
					con_bonus:=rnd(size);
					magic_bonus:=(size*2)-(st_bonus+dex_bonus);
					end;
				bonus:=st_bonus*sign(points);
				ob[who].st:=ob[who].st+bonus;
				if ob[who].st<5 then ob[who].st:=5;
				ob[who].max_st:=ob[who].max_st+bonus;
				if ob[who].max_st<5 then ob[who].max_st:=5;
				bonus:=dex_bonus*sign(points);
				ob[who].dex:=bonus+ob[who].dex;
				if ob[who].dex<5 then ob[who].dex:=5;
				ob[who].max_dex:=ob[who].max_dex+bonus;
				if ob[who].max_dex<5 then ob[who].max_dex:=5;
				bonus:=con_bonus*sign(points);
				ob[who].con:=bonus+ob[who].con;
				if ob[who].con<5 then ob[who].con:=5;
				ob[who].max_con:=ob[who].max_con+bonus;
				if ob[who].max_con<5 then ob[who].max_con:=5;
				bonus:=magic_bonus*sign(points);
				ob[who].magic:=bonus+ob[who].magic;
				if ob[who].magic<5 then ob[who].magic:=5;
				ob[who].max_magic:=ob[who].max_magic+bonus;
				if ob[who].max_magic<5 then ob[who].max_magic:=5;
				end;
			end;
		end;
	end;

function mobile_value(who : integer) : integer;external;
function mobile_value(who : integer) : integer;

	begin
	if ob[who].control=0 then
		mobile_value:=ob[who].sc DIV 100
	else
		mobile_value:=ob[who].sc DIV 12;
	end;

procedure door_stat(dr,whom : integer);external;
procedure door_stat(dr,whom : integer);

	begin
	wrst(ob[whom].connect,'The ');
	wrst(ob[whom].connect,doors[dr].name);
	wrst(ob[whom].connect,' is ');
	if doors[dr].broken then
		wrst(ob[whom].connect,'broken and hangs loose on its hinges')
	else
		if doors[dr].open then
			wrst(ob[whom].connect,'open')
		else
			wrst(ob[whom].connect,'shut');
	if doors[dr].s_hole then
		wrtln(ob[whom].connect,', but a small hole has been hacked near the bottom.')
	else
		wrtln(ob[whom].connect,'.');
	end;

procedure dsall(dr : integer);external;
procedure dsall(dr : integer);

var lp	: integer;

	begin
	for lp:=87 to no_ob do
		if ob[lp].location>0 then
			if (ob[lp].location=doors[dr].first) or (ob[lp].location=doors[dr].second) then
				if ob[lp].mobile and not(ob[lp].blind) then
					door_stat(dr,lp);
	end;

procedure sexconv(VAR what : str255; object : integer);external;
procedure sexconv(VAR what : str255; object : integer);

var where	: integer;
    tempst	: array[1..2] of str255;
    possadj	: string[5];

	begin
	if ob[object].mobile then
		if ob[object].male then
			possadj:='his'
		else
			possadj:='her'
	else
		possadj:='its';
	where:=pos('#',what);
	while where<>0 do
		begin
		tempst[1]:=copy(what,1,where-1);
		tempst[2]:=copy(what,where+1,(length(what)-where));
		what:=concat(tempst[1],possadj,tempst[2]);
		where:=pos('#',what);
		end;
	end;
	
procedure display_ob(who, obj, desc : integer);external;
procedure display_ob(who, obj, desc : integer);

var search	: integer;

	begin
	junk:=descs[desc];
	sexconv(junk,obj);
	search:=pos('@',junk);
	if search<>0 then
		begin
		wrst(ob[who].connect,copy(junk,1,search-1));
		wrst(ob[who].connect,ob[obj].name);
		wrst(ob[who].connect,copy(junk,search+1,length(junk)-search));
		end
	else
		wrst(ob[who].connect,junk);
	end;					

function carrying_ob(who,obj : integer) : boolean;external;
function carrying_ob(who,obj : integer) : boolean;

{ returns whether or not the object is carrying anything at all }

var which,
    found	: integer;
    andflag,
    jbool	: boolean;

	procedure showob(found,who : integer);
	
		begin
		shortname(found,who,false,false,false);
		if ob[found].extinguish and ob[found].light then
			wrst(ob[who].connect,' (which is lit)');
		if ob[found].c_liquid and (ob[found].liquid<>0) then
			begin
			wrst(ob[who].connect,' (which contains ');
			wrst(ob[who].connect,liquids[ob[found].liquid].name);
			send(ob[who].connect,')');
			end;
		if ob[found].worn then
			begin
			wrst(ob[who].connect,' (which ');
			shortname(obj,who,false,true,false);
			wrst(ob[who].connect,' is wearing)');
			end;
		if ob[found].bolts=1 then
			wrst(ob[who].connect,' (which has 1 arrow with it)');
		if ob[found].bolts>1 then
			begin
			wrst(ob[who].connect,' (which has ');
			wrtint(ob[who].connect,ob[found].bolts);
			wrst(ob[who].connect,' arrows with it)');
			end;
		if (found=244) and (balloon=1) then
			wrst(ob[who].connect,' (which is blown up)');
		end;

    	begin
	found:=-1;
	andflag:=false;
	for which:=1 to no_ob do
		if (which<>obj) then
			if ob[which].carries=obj then
				begin
				if found=-1 then
					begin
					send(ob[who].connect,' ');
					display_ob(who,obj,ob[obj].contdesc);
					end
				else
					begin
					andflag:=true;
					showob(found,who);
					wrst(ob[who].connect,', ');
					end;
				found:=which;
				end;
	if found<>-1 then
		begin
		if andflag then wrst(ob[who].connect,'and ');
		showob(found,who);
		wrst(ob[who].connect,'.');
		for which:=1 to no_ob do
			if (which<>obj) then
				if ob[which].carries=obj then
					jbool:=carrying_ob(who,which);
		end;
	carrying_ob:=(found<>-1);
	end;

procedure arenawln(whom : integer; what : str255; loc1, loc2 : integer);external;
procedure arenawln(whom : integer; what : str255; loc1, loc2 : integer);

	begin
	if (loc1<>706) or (loc2<>666) then
		wrtln(whom,what)
	else
		begin
		what[1]:=tolower(what[1]);
		wrtln(whom,concat('In the Arena, ',what));
		end;
	end;

procedure tellall;

var lp	: integer;

	begin
	for lp:=87 to no_ob do
		if ob[lp].location>0 then
			if ob[lp].mobile and (lp<>except) and not(ob[lp].sleep) then
				if ((ob[lp].location=where) or 
				   ((ob[lp].location=706) and
				   (where=666))) and
				   (not(blind_s and blind_q(lp)) and
				   not(deaf_s and ob[lp].deaf)) then
					arenawln(ob[lp].connect,what,ob[lp].location,where);
	end;

procedure act;

var tempst	: string[40];
    lp		: integer;
    place	: integer;

	begin
	sexconv(what,who);
	place:=real_loc(who);
	for lp:=87 to no_ob do
		if ob[lp].location>0 then
			if ob[lp].mobile and ((ob[lp].location=place) or ((place=666) and (ob[lp].location=706))) 
			   and (lp<>who) and not(ob[lp].sleep) then
				begin
				if isupper(ob[who].name[1]) then
					tempst:=ob[who].name
				else
					tempst:=concat('The ',ob[who].name);
				if cant_see_obj(lp,who) then
					tempst:='Something';
				if not(ob[lp].deaf and deaf_s) and not(cant_see_obj(lp,who) and blind_s) then
					arenawln(ob[lp].connect,concat(tempst,' ',what),ob[lp].location,place);
				end;
	end;

procedure doubleact(who,whom : integer; what : str255; blind_s, deaf_s, inv_check : boolean);external;
procedure doubleact(who,whom : integer; what : str255; blind_s, deaf_s, inv_check : boolean);

var tempst1,
    tempst2	: string[40];
    lp,
    place	: integer;

	begin
	sexconv(what,who);
	place:=real_loc(who);
	for lp:=87 to no_ob do
		if ob[lp].location>0 then
			if ob[lp].mobile and ((ob[lp].location=place) or ((ob[lp].location=706) and (place=666))) and
			   (lp<>who) and (lp<>whom) and not(ob[lp].sleep) then
				begin
				if isupper(ob[who].name[1]) then
					tempst1:=ob[who].name
				else
					tempst1:=concat('The ',ob[who].name);
				if cant_see_obj(lp,who) then
					tempst1:='Something';
				if isupper(ob[whom].name[1]) then
					tempst2:=ob[whom].name
				else
					tempst2:=concat('the ',ob[whom].name);
				if cant_see_obj(lp,whom) and inv_check then
					tempst2:='something';
				if not(ob[lp].deaf and deaf_s) and not((ob[lp].blind or (cant_see_obj(lp,who)
				   and cant_see_obj(lp,whom) and inv_check)) and blind_s) then
					arenawln(ob[lp].connect,concat(tempst1,' ',what,' ',tempst2,'.'),ob[lp].location,place);
				end;
	end;

procedure tripleact(who, what, whom : integer; what1,what2 : line; blind_s, inv_check : boolean);external;
procedure tripleact(who, what, whom : integer; what1,what2 : line; blind_s, inv_check : boolean);

var tempst1,
    tempst2,
    tempst3	: string[40];
    lp,
    place	: integer;

	begin
	place:=real_loc(who);
	for lp:=87 to no_ob do
		if ob[lp].location>0 then
			if ob[lp].mobile and ((ob[lp].location=place) or ((ob[lp].location=706) and (place=666))) and
			   (lp<>who) and (lp<>whom) and (lp<>what) and not(ob[lp].sleep) then
				begin
				if isupper(ob[who].name[1]) then
					tempst1:=ob[who].name
				else
					tempst1:=concat('The ',ob[who].name);
				if cant_see_obj(lp,who) then
					tempst1:='Something';
				if isupper(ob[whom].name[1]) then
					tempst2:=ob[whom].name
				else
					tempst2:=concat('the ',ob[whom].name);
				if cant_see_obj(lp,whom) then
					tempst2:='something';
				if isupper(ob[what].name[1]) then
					tempst3:=ob[what].name
				else
					tempst3:=concat('the ',ob[what].name);
				if cant_see_obj(lp,what) and inv_check then
					tempst3:='something';
				if not((ob[lp].blind or (cant_see_obj(lp,who) and cant_see_obj(lp,whom)
				   and cant_see_obj(lp,what) and inv_check)) and blind_s) then
					arenawln(ob[lp].connect,concat(tempst1,' ',what1,' ',tempst3,' ',what2,' ',tempst2,'.'),ob[lp].location,place);
				end;
	end;


procedure dispossess(who : player_range);external;
procedure dispossess(who : player_range);

	begin
	wrtln(who,'Your possess spell is ended.');
	ob[position[who,8]].possessed:=false;
	ob[position[who,8]].connect:=position[who,7];
	position[who,8]:=0;
	wrtln(position[who,7],'You are free once more!');
	position[who,7]:=0;
	act(position[who,6],'comes out of # trance.',true,false);
	end;

function who_possesses(what : integer) : integer;external;
function who_possesses(what : integer) : integer;

var lp,
    whoisit 	: integer;

	begin
	whoisit:=0;
	for lp:=1 to top do
		if position[lp,8]=what then
			whoisit:=position[lp,6];
	who_possesses:=whoisit;
	end;

function find_virtual(which, where : integer) : integer;external;
function find_virtual(which, where : integer) : integer;

var lp,
    lp2,
    fwhere	: integer;

	begin
	fwhere:=0;
	for lp:=1 to virtuals[which].howmany do
		for lp2:=virtuals[which].rooms[lp,1] to (virtuals[which].rooms[lp,2]+virtuals[which].rooms[lp,1]-1) do
			if vlocs[lp2]=where then
				fwhere:=lp;
	find_virtual:=fwhere;
	end;

function drowns(who,where : integer) : boolean;external;
function drowns(who,where : integer) : boolean;

var tempflag	: boolean;

	begin
	if places[where].wet then
		begin
		tempflag:=true;
		if ob[72].carries=who then
			tempflag:=false;
		if ob[73].carries=who then
			tempflag:=false;
		drowns:=tempflag;
		end
	else
		drowns:=false;
	end;

procedure stam_display(whom : integer);external;
procedure stam_display(whom : integer);

	begin
	wrst(ob[whom].connect,'Stamina = ');
	wrtint(ob[whom].connect,ob[whom].con);
	wrst(ob[whom].connect,' / ');
	wrtint(ob[whom].connect,ob[whom].max_con);
	cr(ob[whom].connect);
	end;

procedure lower(VAR adollar : str255);external;
procedure lower(VAR adollar : str255);

var loopv	: integer;

	begin
	for loopv:=1 to length(adollar) do
		adollar[loopv]:=tolower(adollar[loopv]);
	end;

function compare(a,b : str255) : boolean;external;
function compare(a,b : str255) : boolean;

	begin
	lower(a);
	lower(b);
	compare:=a=b;
	end;

function lcompare(a,b : str255) : boolean;external;
function lcompare(a,b : str255) : boolean;

var i : integer;
    c : char;

	begin
	i:=1;
	while i<=ord(b[0]) do
		begin
		c:=tolower(a[i]);
		if c<>b[i] then
			i:=999;
		i:=i+1;
		end;
	lcompare:=i<>1000;
	end;

function l1compare(a : str17; VAR b : str17) : boolean;external;
function l1compare(a : str17; VAR b : str17) : boolean;

{ converts 1st letter of a to lower case }

	begin
	a[1]:=tolower(a[1]);
	if length(a)>length(b) then
		a[0]:=b[0];
	l1compare:=a=b;
	end;

function ncompare(a : str17; var b : str17) : boolean;external;
function ncompare(a : str17; var b : str17) : boolean;

	begin
	if length(a)>length(b) then
		a[0]:=b[0];
	ncompare:=a=b;
	end;

function parse(player : player_range; data : in_buffer; print : boolean; me : integer) : boolean;external;
function parse(player : player_range; data : in_buffer; print : boolean; me : integer) : boolean;

var point,
    temp	: 0..129;
    old_no_com	: 0..10;
    error	: boolean;
    at_pointer	: char;
    word	: str17;
    find_loop	: integer;
    found	: boolean;
    lp,
    ilp,
    lenquote	: integer;

	procedure extract(casec : boolean);
	
	var lp	: integer;
	
		begin
		word:='';
		temp:=point;
		while (data[temp]<>' ') and (temp<=length(data)) do
			temp:=temp+1;
		temp:=temp-1;
		for lp:=point to temp do
			if length(word)<16 then
				word:=concat(word,data[lp]);
		point:=temp+1;
		if casec then
			for lp:=1 to length(word) do
				word[lp]:=tolower(word[lp]);
		end;

	begin
	point:=1;
	no_com:=0;
	error:=false;
	junk:=data;
	lower(junk);
	for lp:=1 to swears do
		while pos(swear[lp],junk)>0 do
			begin
			temp:=pos(swear[lp],junk);
			for ilp:=temp+1 to length(swear[lp])+temp-1 do
				begin
				data[ilp]:='*';
				junk[ilp]:='#';
				end;
			end;
	while (point<=length(data)) and (no_com<10) and not(error) do
		begin
		old_no_com:=no_com;
		{ check character at pointer }
		at_pointer:=data[point];
		if at_pointer<>' ' then
			begin
			if (at_pointer='"') and (point<>length(data)) then
				begin
				no_com:=no_com+1;
				commands[no_com].which:=5;
				commands[no_com].quoted:=copy(data,point+1,length(data)-point);
				temp:=0;
				lenquote:=0;
				while temp<length(commands[no_com].quoted) do
					begin
					temp:=temp+1;
					lenquote:=lenquote+1;
					if commands[no_com].quoted[temp]='"' then
						if (temp=length(commands[no_com].quoted)) or (commands[no_com].quoted[temp+1]<>'"') then
							{ we have found the closing quote }
							begin
							commands[no_com].quoted:=copy(commands[no_com].quoted,1,temp-1);
							lenquote:=lenquote+1;
							end
						else
							begin
							{ this is a quote with another following it }
							delete(commands[no_com].quoted,temp+1,1);
							{ cut out the second one }
							lenquote:=lenquote+1;
							end;
					end;
				point:=point+1+lenquote;
				end;
			if at_pointer in ['0'..'9'] then
				begin
				{ a number }
				extract(false);
				no_com:=no_com+1;
				commands[no_com].which:=4;
				commands[no_com].number:=get_number(word);
				end;
			if (at_pointer='\') or (at_pointer='/') then
				begin
				{ a string, preceded by a backslash }
				point:=point+1;
				extract(false);
				no_com:=no_com+1;
				commands[no_com].which:=6;
				commands[no_com].slashed:=word;
				end;
			if isa(at_pointer) then
				begin
				{ a textual string }
				extract(true);
				{ do the special checks }
				if 'go'=word then
					begin
					no_com:=no_com+1;
					commands[no_com].which:=1;
					commands[no_com].vb:=0;
					end;
				if ('bow'=word) and (no_com>0) then
					begin
					no_com:=no_com+1;
					commands[no_com].which:=3;
					commands[no_com].category:=15;
					end;
				if 't'=word then
					begin
					no_com:=no_com+1;
					commands[no_com].which:=3;
					commands[no_com].category:=2;
					end;
				if word='i' then
					begin
					no_com:=no_com+1;
					commands[no_com].which:=1;
					commands[no_com].vb:=29;
					end;
				if word='wh' then
					begin
					no_com:=no_com+1;
					commands[no_com].which:=1;
					commands[no_com].vb:=55;
					end;
				if word='qw' then
					begin
					no_com:=no_com+1;
					commands[no_com].which:=1;
					commands[no_com].vb:=44;
					end;
				if word='x' then
					begin
					no_com:=no_com+1;
					commands[no_com].which:=1;
					commands[no_com].vb:=133;
					end;
				if word='me' then
					begin
					no_com:=no_com+1;
					commands[no_com].which:=2;
					commands[no_com].object:=me;
					end;
				if (word='hat') then
					if ob[247].name='hat' then
						begin
						no_com:=no_com+1;
						commands[no_com].which:=2;
						commands[no_com].object:=247;
						end;
				if (word='book') then
					if ob[45].name='book' then
						begin
						no_com:=no_com+1;
						commands[no_com].which:=2;
						commands[no_com].object:=45;
						end;
				if (old_no_com=no_com) and (word<>'q') then
					begin
					{ is it a verb ? }
					find_loop:=1;
					found:=false;
					while (find_loop<=no_verb) and not(found) do
						begin
						found:=ncompare(verb[find_loop],word);
						find_loop:=find_loop+1;
						end;
					if found then
						begin
						{ it's a verb }
						no_com:=no_com+1;
						commands[no_com].which:=1;
						commands[no_com].vb:=find_loop-1;
						end;
					end;
				if old_no_com=no_com then
					begin
					{ is it, then, a category ? }
					find_loop:=1;
					found:=false;
					while (find_loop<=no_cat) and not(found) do
						begin
						found:=ncompare(categs[find_loop].name,word);
						find_loop:=find_loop+1;
						end;
					if found then
						begin
						{ it's a category }
						no_com:=no_com+1;
						commands[no_com].which:=3;
						commands[no_com].category:=find_loop-1;
						end;
					end;
				if old_no_com=no_com then
					begin
					{ is it a liquid? }
					find_loop:=1;
					found:=false;
					while (find_loop<=no_liquids) and not(found) do
						begin
						found:=ncompare(liquids[find_loop].name,word);
						find_loop:=find_loop+1;
						end;
					if found then
						begin
						{ it's a liquid }
						no_com:=no_com+1;
						commands[no_com].which:=7;
						commands[no_com].liquid:=find_loop-1;
						end;
					end;
				if old_no_com=no_com then
					begin
					{ is it a virtual object? }
					find_loop:=1;
					found:=false;
					while (find_loop<=no_virtual) and not(found) do
						begin
						found:=ncompare(virtuals[find_loop].name,word);
						find_loop:=find_loop+1;
						end;
					if found then
						begin
						{ it's a virtual }
						no_com:=no_com+1;
						commands[no_com].which:=8;
						commands[no_com].virtual:=find_loop-1;
						end;
					end;
				if old_no_com=no_com then
					begin
					{ is it, finally, an object ? }
					find_loop:=1;
					found:=false;
					while (find_loop<=no_ob) and not(found) do
						begin
						found:=l1compare(ob[find_loop].name,word) and (ob[find_loop].name<>'');
						find_loop:=find_loop+1;
						end;
					if found then
						begin
						{ it's an object }
						no_com:=no_com+1;
						commands[no_com].which:=2;
						commands[no_com].object:=find_loop-1;
						end;
					end;
				if old_no_com=no_com then
					begin
					if print then
						begin
						wrst(player,'The parser doesn''t know the word "');
						wrst(player,word);
						wrtln(player,'".');
						end;
					no_com:=no_com+1;
					commands[no_com].which:=0;
					error:=true;
					end;
				end;
			if old_no_com=no_com then
				begin
				if print then
					begin
					wrst(player,'The parser couldn''t interpret the character "');
					wrst(player,at_pointer);
					wrtln(player,'".');
					end;
				error:=true;
				end;
			end
		else
			point:=point+1;
		end;
	parse:=not(error) and (no_com>0);
	end;

function weigh(what : integer) : integer;external;
function weigh(what : integer) : integer;
	
var lp,
    c_weight	: integer;
	
	begin
	if (what=0) or (what>no_ob) then
		weigh:=0
	else
		begin
		c_weight:=ob[what].weight;
		if ob[what].contdesc>0 then
			for lp:=1 to no_ob do
				if ob[lp].carries=what then
					c_weight:=c_weight+weigh(lp);
		weigh:=c_weight;
		end;
	end;

function fsize(what : integer) : integer;external;
function fsize(what : integer) : integer;

var lp,
    c_size	: integer;
    
    	begin
	if (what=0) or (what>no_ob) then
		fsize:=0
	else
		begin
		c_size:=ob[what].size;
		if (ob[what].contdesc>0) and ((c_size<50) or (c_size>150)) then
			for lp:=1 to no_ob do
				if ob[lp].carries=what then
					c_size:=c_size+fsize(lp);
		fsize:=c_size;
		end;
	end;

procedure err(who,number : integer; fatal : boolean);external;
procedure err(who,number : integer; fatal : boolean);

	begin
	if (number>8) or fatal then
		begin
		wrtln(ob[who].connect,tdata[91+number]);
		if number>8 then
			begin
			curstop:=true;
			curcno:=1;
			end;
		end;
	end;

function forbidden(who,where : integer) : boolean;external;
function forbidden(who,where : integer) : boolean;

	begin
	if f_level(who)<=11 then
		begin
		forbidden:=(where=123) or (where=125) or (where=184) or
			   (where=185) or (where=139) or (where=317) or
			   (where=421) or (where=318) or (where=339) or
			   (where=365) or (where=793) or (where=790) or
			   (where=205) or (where=522) or (where=523) or 
			   (where=535) or (where=575) or (where=642) or
			   (where=685) or (where=686) or (where=674) or
			   (where=830) or (where=831) or (where=872) or
			   (where=887) or (where=826) or (where=245);
		if ob[189].location=where then
			forbidden:=true;
		end
	else
		begin
		forbidden:=(where=205) or (where=686) or (where=773) or (where=774) or (where=775) or (where=893);
		if (ob[who].control=1) then forbidden:=false;
		if (ob[who].control=11) then forbidden:=((where=205) or (where=686));
		if (ob[who].name='Flamebitch') and (where=775) then forbidden:=false;
		if (ob[who].name='Joker') and (where=893) then forbidden:=false;
		end;
	if where=ob[who].location then forbidden:=false;
	if where=-1 then forbidden:=true;
	end;

function newname(name : in_buffer; persona : boolean) : boolean;external;
function newname(name : in_buffer; persona : boolean) : boolean;

{ tests to see if the submitted name is valid : if persona is true, 
  checks through to see if the name has been used for a persona }

var found : boolean;
    lp    : integer;

	begin
	if (length(name)>20) or (length(name)<2) or (pos(' ',name)>0) or not(isa(name[1])) then
		newname:=false
	else
		if parse(1,name,false,0) then
			newname:=false
		else
			begin
			junk:=name;
			lower(junk);
			found:=false;
			for lp:=1 to swears do
				if pos(swear[lp],junk)>0 then found:=true;
			if found then
				newname:=false
			else
				if persona then
					begin
					found:=false;
					for lp:=1 to no_people do
						if people[lp]<>NIL then
							if compare(name,people[lp]^.name) then
								found:=true;
					newname:=not(found);
					end
				else
					newname:=true;
			end;
	end;

{ here endeth the list of routines that can be separately compiled }

