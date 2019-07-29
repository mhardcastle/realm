program realm2;

{$I realmhd.p}

procedure poll;
	external;

procedure note_event_time(time : integer);
	external;

procedure getcommand(player : integer; buffer : string [128]);
	external;

procedure erase(fn : string[32]);
	external;

procedure pascal_rename(fn1, fn2 : string [32]);
	external;

function systime : integer;
	external;

procedure rdinc(VAR number : integer);
	external;

function gettime : integer;
	external;

procedure cr(whom : pm_range);
	external;

function findwidth(whom : player_range) : integer;
	external;

procedure send(whom : pm_range; what : char);
	external;

procedure tab(whom,xpos : integer);
	external;

procedure wrst(whom : pm_range; what : str255);
	external;

procedure wrtln(whom : pm_range; what : str255);
	external;

function curlen(posn : integer) : integer;
	external;

procedure wrtint(whom : pm_range; x : integer);
	external;

function isupper(c : char) : boolean;
	external;

function islower(c : char) : boolean;
	external;

function isa(c : char) : boolean;
	external;

function isan(c : char) : boolean;
	external;

function tolower(c : char) : char;
	external;

function toupper(c : char) : char;
	external;

function rnd(limit : integer) : integer;
	external;

procedure multiwrite(who : pm_range; to_write : str255);
	external;

procedure return_time(ret : integer; var h,m,s : integer);
	external;

procedure show_time(whom : player_range; time : integer);
	external;

procedure return_date(ret : integer; var d,m,y : integer);
	external;

procedure show_date(whom : player_range; time : integer);
	external;

function add_days(time : integer; days : integer) : integer;
	external;

procedure ban(who,connect,days : integer);
	external;

procedure lower(VAR adollar : str255);
	external;

function compare(a,b : str255) : boolean;
	external;

function compare_password(a,b : str255) : boolean;
	external;

procedure password_crypt(VAR a : str255);
	external;

function lcompare(a,b : str255) : boolean;
	external;

function get_number(num : str255) : integer;
	external;

function fromlist(f,t : integer) : integer;
	external;

procedure dotext(whom,st,fin : integer);
	external;

procedure show_main_menu(whom : pm_range; whole : boolean);
	external;

function opposite(old : integer) : integer;
	external;

procedure reset_objs;
	external;

procedure initialise;
	external;

procedure pete_init;
	external;

procedure dir_string(dir : integer; caps : boolean);
	external;

procedure new_object(VAR variable : integer);
	external;

procedure add_ssn(who : integer);
	external;

procedure remove_ssn(who : integer);
	external;

procedure stop_fight(who : integer);
	forward;
	
procedure dropall(what : integer; tell,move : boolean);
	forward;

procedure stop_follow(who : integer; stop_me, stop_them : boolean);
	forward;

procedure log(action : str255);
	external;

procedure remove_object(which : integer);

{ removes an object from the list and reclaims its space. Use with 
  quitting players, killed mobiles, lake'd T and so on. }

	begin
	if ob[which].location=-1 then
		log('System error - attempt to remove nonexistent object.')
	else
		begin
		dropall(which,true,false);
		if ob[which].mobile then
			begin
			remove_ssn(which);
			stop_fight(which);
			stop_follow(which,true,true);
			ob[which].connect:=0;
			end;
		ob[which].location:=-1;
		ob[which].carries:=0;
		if ob[which].control>0 then
			begin
			ob[which].control:=0;
			ob[which].name:='';
			end;
		while (ob[no_ob].location=-1) and (no_ob>fixed_ob) do
			begin
			no_ob:=no_ob-1;
			categs[1].objects[1,2]:=no_ob;
			end;
		end;
	end;

function being_fought(who : integer) : integer;
	external;

function find_door(lieu : integer) : integer;
	external;

function f_level(who : integer) : integer;
	external;

function cant_see_obj(who,what : integer) : boolean;
	external;

procedure shortname(who,whom : integer; caps,pronoun,notsee : boolean);
	external;

procedure fullname(who,whom : integer);
	external;

procedure score_point(who : integer; points : integer);
	external;

function mobile_value(who : integer) : integer;
	external;

procedure door_stat(dr,whom : integer);
	external;

procedure dsall(dr : integer);
	external;

procedure display_ob(who, obj, desc : integer);
	external;

function real_loc(what : integer) : integer;
	external;

function dark(where,who : integer) : boolean;
	external;

function carrying_ob(who,obj : integer) : boolean;
	external;

function blind_q(who : integer) : boolean;
	external;

procedure tellall(where,except : integer; what : str255; blind_s, deaf_s : boolean);
	external;

procedure act(who : integer; what : str255; blind_s, deaf_s : boolean);
	external;

procedure doubleact(who,whom : integer; what : str255; blind_s, deaf_s, inv_check : boolean);
	external;

procedure tripleact(who,what,whom : integer; what1,what2 : line; blind_s, inv_check : boolean);
	external;

procedure tellwiz(action : str255);
	external;

procedure dispossess(who : player_range);
	external;

function who_possesses(what : integer) : integer;
	external;

procedure mu_chance(who : integer);

	begin
	if rnd(4)=3 then
		if (ob[who].class=1) and (ob[who].race<>4) and (ob[who].race<6) then
			begin
			dotext(ob[who].connect,179,181);
			dotext(ob[who].connect,55,58);
			tellall(ob[who].location,who,'A bearded old man with a glowing staff appears suddenly!',true,false);
			act(who,'is whisked away magically by the old man, who then vanishes.',true,false);
			stop_fight(who);
			ob[who].location:=830;
			act(who,'appears here.',true,false);
			end;
	end;

procedure addlimit(VAR addto : integer; limit,add : integer);

var temp	: integer;

	begin
	temp:=addto+add;
	if temp>limit then
		addto:=limit
	else
		addto:=temp;
	end;
	
procedure de_drunk(who, howmuch : integer);
	forward;

function find_virtual(which, where : integer) : integer;
	external;

procedure destroy_event(kind,flag : integer);
	external;

procedure logoff(who : integer);

var lp : integer;

	begin
	if ob[who].control=11 then
		tellall(ob[who].location,who,concat(tdata[120],tdata[121]),true,false)
	else
		act(who,'fades away.',true,false);
	if pandora_per=who then
		pandora_per:=-1;
	if leverp1=who then
		leverp1:=0;
	if leverp2=who then
		leverp2:=0;
	if stocks=who then
		stocks:=0;
	de_drunk(who,ob[who].drunk);
	for lp:=1 to 20 do
		if resisting[lp]=who then resisting[lp]:=0;
	destroy_event(1,who);
	destroy_event(18,who);
	destroy_event(19,who);
	destroy_event(22,who);
	for lp:=1 to no_events do
		begin
		if (event[lp].kind=23) and (event[lp].flag=who) then
			ob[who].st:=ob[who].st-event[lp].flag2;
		if (event[lp].kind=24) and (event[lp].flag=who) then
			ob[who].dex:=ob[who].dex-event[lp].flag2;
		end;
	destroy_event(23,who);
	destroy_event(24,who);
	if ob[who].connect<>0 then
		begin
		if position[ob[who].connect,8]<>0 then
			dispossess(ob[who].connect);
		position[ob[who].connect,9]:=0;
		for lp:=1 to top do
			if position[lp,9]=ob[who].connect then
				position[lp,9]:=0;
		end;
	if ob[who].control<>0 then
		with ob[who] do
			begin
			tellwiz(concat(name,' has left the Realm.'));
			dotext(connect,38,39);
			people[control]^.name:=name;
			people[control]^.st:=st;
			people[control]^.con:=con;
			people[control]^.dex:=max_dex;
			people[control]^.max_con:=max_con;
			people[control]^.max_st:=max_st;
			people[control]^.max_dex:=max_dex;
			people[control]^.max_magic:=max_magic;
			people[control]^.magic:=magic;
			people[control]^.male:=male;
			people[control]^.class:=class;
			people[control]^.race:=race;
			people[control]^.sc:=sc;
			people[control]^.descr:=descr;
			people[control]^.contdesc:=contdesc;
			if connect>0 then
				position[connect,1]:=4
			else
				people[control]^.tempflag:=0;
			end;
	remove_object(who);
	end;

procedure dead(who : integer);

var temp : pm_range;

	begin
	temp:=ob[who].connect;
	dotext(temp,50,51);
	if temp<>0 then
		if position[temp,8]<>0 then
			dispossess(temp);
	act(who,'has died.',true,false);
	temp:=ob[who].connect;
	logoff(who);
	if temp<>0 then
		show_main_menu(temp,false);
	end;

function share_point(who : integer; points : integer; inc_kill : boolean) : integer;

var temp,lp : integer;

	begin
	temp:=being_fought(who);
	if ob[who].fighting<>0 then
		if ob[ob[who].fighting].fighting<>who then
			temp:=temp+1;
	for lp:=87 to no_ob do
		if ob[lp].location>0 then
			if ob[lp].mobile then
				if (ob[lp].fighting=who) or (ob[who].fighting=lp) then
					begin
					score_point(lp,points DIV temp);
					if (ob[lp].control>0) and inc_kill then
						people[ob[lp].control]^.kills:=people[ob[lp].control]^.kills+1;
					end;
	share_point:=temp;
	end;

procedure dead_dead(who, killer : integer);

var temp, lp : integer;

	begin
	temp:=ob[who].connect;
	if ob[who].control<>0 then dotext(temp,47,49) else dotext(temp,47,48);
	if temp<>0 then
		if position[temp,8]<>0 then
			dispossess(temp);
	wrst(ob[killer].connect,'You have killed ');
	shortname(who,killer,false,false,false);
	wrtln(ob[killer].connect,' in combat.');
	doubleact(killer,who,'has killed',true,false,true);
	if (ob[killer].control<>0) and (ob[who].control<>0) then
		log(concat(ob[killer].name,' killed ',ob[who].name,'.'));
	temp:=share_point(who,mobile_value(who),true);
	score_point(who,-(ob[who].sc DIV 2));
	ob[who].con:=ob[who].max_con;
	ob[who].magic:=ob[who].max_magic;
	ob[who].st:=ob[who].max_st;
	ob[who].dex:=ob[who].max_dex;
	if (ob[killer].location=666) and (arena_bonus<>0) and (temp=1) and
		(((killer=ar1) and (who=ar2)) or ((killer=ar2) and (who=ar1))) then
		begin
		score_point(killer,arena_bonus);
		arena_bonus:=0;
		end;
	if (ob[killer].location=116) and (ob[killer].weapon1=2) and (temp=1) and (ob[who].control=0) then
		begin
		wrtln(ob[killer].connect,'As your foe''s blood runs on the stone you feel a tingle through your body...');
		score_point(killer,100);
		{ possible magic user here }
		if rnd(5)=3 then mu_chance(killer);
		end;
	if (who=100) and (ob[23].location=123) then
		begin
		for lp:=87 to no_ob do
			if ob[lp].location=ob[100].location then
				if ob[lp].mobile then
					dotext(ob[lp].connect,59,61);
		ob[23].location:=ob[100].location;
		end;
	if ((who=149) or (who=123) or (who=99) or (who=100) or (who=195)) and (temp=1) then
		mu_chance(killer);
	temp:=ob[who].connect;
	logoff(who);
	if temp<>0 then
		show_main_menu(temp,false);
	end;

procedure half_dead(who, killer : integer);

var temp : pm_range;

	begin
	temp:=ob[who].connect;
	wrtln(temp,'You have been killed by another player outside a fight. You lose some points.');
	if temp<>0 then
		if position[temp,8]<>0 then
			dispossess(temp);
	wrst(ob[killer].connect,'You have foully slain ');
	shortname(who,killer,false,false,false);
	wrtln(ob[killer].connect,'.');
	doubleact(killer,who,'has sneakily killed',true,false,true);
	score_point(killer,mobile_value(who) div 4);
	score_point(who,-(mobile_value(who) div 2));
	temp:=ob[who].connect;
	logoff(who);
	if temp<>0 then
		show_main_menu(temp,false);
	end;

function drowns(who,where : integer) : boolean;
	external;

procedure give_object(who,what,whom : integer; errors : boolean);
	forward;

procedure set_event(kind,flag,flag2 : integer; time : integer);
	external;

procedure remove_event(which : integer);
	external;

procedure health_st(who, whom : integer);

	begin
	if ob[whom].con<(ob[whom].max_con div 4) then
		begin
		send(ob[who].connect,' ');
		shortname(whom,who,true,true,false);
		wrst(ob[who].connect,' is severely hurt.');
		end
	else
		if ob[whom].con<(ob[whom].max_con div 2) then
			begin
			send(ob[who].connect,' ');
			shortname(whom,who,true,true,false);
			wrst(ob[who].connect,' is injured.');
			end;
	end;

procedure look(object : integer; action : boolean);

var tempstr	: string[90];
    posn,
    coplp	: integer;
    which,
    h,
    m,
    s,
    search	: integer;
    found	: boolean;

	begin
	if (stocks=object) and (ob[object].location<>847) and action then
		stocks:=0;
	if drowns(object,ob[object].location) and action then
		begin
		wrst(ob[object].connect,'There''s no ground beneath your feet! ');
		dotext(ob[object].connect,135,137);
		act(object,'drowns!',true,false);
		dead(object);
		end
	else
		if (ob[object].location>=431) and (ob[object].location<=445) and volcano and action then
			begin
			dotext(ob[object].connect,138,139);
			dead(object);
			end
		else
		with ob[object] do
			if connect>0 then
				if blind_q(object) and action then
					wrtln(connect,'You cannot see.')
				else
					if dark(location,object) and action then
						wrtln(connect,'It''s dark here.')
					else
						begin
						wrst(connect,places[location].name);
						if not(people[position[connect,5]]^.brief) and (ob[object].sc>204799) then
							begin
							wrst(connect,' [');
							wrtint(connect,location);
							send(connect,']');
							end;
						wrtln(connect,'.');
						if not(people[position[connect,5]]^.brief) then
							begin
							cr(connect);
							if memory then
								begin
								posn:=l_pointer[location];
								repeat
									if (posn+79)>(l_pointer[location+1]-1) then
										coplp:=(l_pointer[location+1]-1)
									else
										begin
										coplp:=posn+79;
										while loctxt^[coplp]<>' ' do
											coplp:=coplp-1;
										end;
									tempstr:='';
									while posn<=coplp do
										begin
										tempstr:=concat(tempstr,loctxt^[posn]);
										posn:=posn+1;
										end;
									wrst(connect,tempstr);
								until posn=l_pointer[location+1];
								end
							else
								begin
								get(desfile{,location-1 --- this won't do ************});
								if l_pointer[location]=0 then
									begin
									l_pointer[location]:=512;
									while desfile^[l_pointer[location]]=' ' do
										l_pointer[location]:=l_pointer[location]-1;
									end;
								posn:=1;
								repeat
									if (posn+79)>l_pointer[location] then
										coplp:=l_pointer[location]
									else
										begin
										coplp:=posn+79;
										while desfile^[coplp]<>' ' do
											coplp:=coplp-1;
										end;
									tempstr:='';
									while posn<=coplp do
										begin
										tempstr:=concat(tempstr,desfile^[posn]);
										posn:=posn+1;
										end;
									wrst(connect,tempstr);
								until posn=l_pointer[location]+1;
								end;
							if (location>709) and (location<771) then
								begin
								wrst(connect,' Exits are');
								for which:=1 to 4 do
									if places[location].value[which]<>0 then
										wrst(connect,concat(' ',verb[which],','));
								send(connect,#8);
								send(connect,'.');
								end;
							if ob[173].location=location then
								wrst(connect,' There''s a large sign here, saying "KEEP OFF THE GRASS."');
							if places[location].day then
								if ((location>=126) and (location<=160)) or 
								   ((location>=547) and (location<=601)) then
								   	begin
								   	if (rnd(5)<5) then
								   		wrst(connect,' It is snowing.');
								   	end
								else
									case weather of
										light_rain:
											wrst(connect,' It''s raining slightly.');
										raining:	
											wrst(connect,' It is raining.');
										pouring:	
											wrst(connect,' It is pouring with rain.');
										snow:
											wrst(connect,' It is snowing.');
										hail:
											wrst(connect,' It is hailing.');
										sleet:
											wrst(connect,' It is sleeting.');
										cloudy:
											wrst(connect,' It''s cloudy.');
										black_clouds:
											wrst(connect,' The sky is dark and threatening.');
										end;
							if location=591 then
								if mirror then
									wrst(connect,' A full-length mirror reflects your every movement to the west.')
								else
									wrst(connect,' There''s a gaping hole in the western wall of the wardrobe.');
							if location=592 then
								if mirror then
									wrst(connect,' A full-length mirror reflects your every movement to the east.')
								else
									wrst(connect,' There''s a gaping hole in the eastern wall of the passage.');
							cr(connect);
							end;
						cr(connect);
						for search:=1 to no_wall do
							begin
							if walls[search].where1=location then
								begin
								dir_string(walls[search].direction,false);
								if walls[search].fire then
									wrtln(connect,concat('A magical wall of fire is to the ',dirs,'!'))
								else
									wrtln(connect,concat('A wall of stone blocks movement to the ',dirs,'!'));
								end;
							if walls[search].where2=location then
								begin
								dir_string(opposite(walls[search].direction),false);
								if walls[search].fire then
									wrtln(connect,concat('A magical wall of fire is to the ',dirs,'!'))
								else
									wrtln(connect,concat('A wall of stone blocks movement to the ',dirs,'!'));
								end;
							end;
						{ specials }
						if (location=626) and garg_pd then
							wrtln(connect,'Someone has repaired the broken statue so that it looks as good as new.');
						if (location=138) and ice_melt then
							wrtln(connect,tdata[72]);
						if (location=358) and wall_hole then
							wrtln(connect,tdata[73]);
						if (location=141) then
							if ob[38].location=123 then
								wrtln(connect,tdata[71]);
						if ((location=420) or (location=421)) then
							if not(sesame) then
								wrtln(connect,tdata[74])
							else
								wrtln(connect,'Fragments of a large boulder lie on every side.');
						if (location>=407) and (location<=411) and volcano then
							wrtln(connect,'The volcano''s erupting.');
						if (location=521) and kobolds_bl then
							dotext(connect,84,85);
						if location=pirate then
							wrtln(connect,tdata[70]);
						if (location=563) then
							begin
							wrst(connect,'A brass plaque high on the wall reads "Hamlet''s Castle - 1987-88.');
							wrtln(connect,' Better late than never."');
							end;
						if ((location=548) or (location=550)) and ice_pond then
							wrtln(connect,'There''s a thin layer of ice over the pool - you might be able to cross it.');
						if (location=575) then
							if clockwk then
								wrtln(connect,'A giant pendulum swings across the gantry to the south.')
							else
								wrtln(connect,'A giant pendulum hangs unmoving above the gantry.');
						if (location=576) then
							if clockwk then
								wrtln(connect,'A giant pendulum swings across the gantry to the north.')
							else
								wrtln(connect,'A giant pendulum hangs unmoving above the gantry.');
						if (location=247) and (ob[102].location=245) then
							wrtln(connect,'A large ogre stands at the bottom of the tower, to the north.');
						if (location=599) then
							if clockwk then
								begin
								return_time(gettime,h,m,s);
								wrst(connect,'A clock face set in the northeast tower reads ');
								h:=h mod 12;
								if h=0 then h:=12;
								wrtint(connect,h);
								send(connect,':');
								wrtint(connect,m);
								wrtln(connect,'.');
								end
							else
								begin
								return_time(stoptime,h,m,s);
								wrst(connect,'A clock face set in the northeast tower reads ');
								h:=h mod 12;
								if h=0 then h:=12;
								wrtint(connect,h);
								send(connect,':');
								wrtint(connect,m);
								wrtln(connect,'.');
								end;
						if (location=568) and clockwnd then
							wrtln(connect,'The clock is broken and clearly beyond repair.');
						if (location=794) and grassburn then
							wrtln(connect,'There is a large burnt area of grass here.');
						if (location=596) and glass_sh then
							wrtln(connect,'A sheet of thick, opaque glass bars your passage west.');
						if (location=597) and glass_sh then
							wrtln(connect,'A sheet of thick, opaque glass bars your passage east.');
						if (location=595) and (pandora_per=0) and (f_level(object)<12) and action then { immortals immune! }
							begin
							dotext(connect,95,96);
							pandora_per:=object;
							set_event(10,0,0,8000);
							end;
						if (location=673) and not(rockfall) then
							wrtln(connect,'There''s a large pile of boulders in the middle of the passage.');
						if ((location=618) or (location=639)) and tree then
							wrtln(connect,'A large apple tree blocks the doorway.');
						if (location=532) then wrtln(connect,'A rockfall has blocked the exit to the south.');
						if (location=531) then wrtln(connect,'A rockfall has blocked the exit to the north.');
						if (location=1) then wrtln(connect,'A blackboard has been fixed to the cliff face.');
						if (find_door(location)>0) and (location<>555) then
							begin
							door_stat(find_door(location),object);
							cr(connect);
							end;
						found:=false;
						for which:=1 to no_ob do
							if (which<>object) and (ob[which].location=location) then
									if not(ob[which].mobile and ob[which].invisible) then
										begin
										if not(ob[which].mobile) and places[ob[which].location].wet then
											begin
											{ this is cheating }
											if ob[which].extinguish then
												begin
												ob[which].light:=false;
												ob[which].burns:=false;
												end;
											shortname(which,object,true,false,false);
											wrst(connect,' floats here.');
											end
										else
											if (which=245) and duckfl then
												if ob[which].location=871 then
													begin
													shortname(which,object,true,false,false);
													wrst(connect,' floats here in the trough.');
													end
												else
													begin
													duckfl:=false;
													display_ob(object,245,ob[245].descr);
													end
											else
												if which<>173 then
													display_ob(object,which,ob[which].descr);
										if ob[which].mobile and ob[which].sleep then
											begin
											send(connect,' ');
											shortname(which,object,true,true,false);
											wrst(connect,' is asleep.');
											end;
										if (ob[which].mobile) and (ob[which].drunk>35) then
											begin
											send(connect,' ');
											shortname(which,object,true,true,false);
											wrst(connect,' is drunk.');
											end;
										if which=stocks then
											begin
											send(connect,' ');
											shortname(which,object,true,true,false);
											wrst(connect,' is in the stocks, by order of the Immortals.');
											end;
										if (ob[which].mobile) and (ob[which].blind) then
											begin
											send(connect,' ');
											shortname(which,object,true,true,false);
											wrst(connect,' seems to be blind.');
											end;
										if (ob[which].mobile) and ((class=4) or (ob[object].sc>409599)) then
											health_st(object,which);
										if (ob[which].mobile) and (ob[which].fighting>0) then
											begin
											send(connect,' ');
											shortname(which,object,true,true,false);
											wrst(connect,' is fighting ');
											if ob[which].fighting=object then
												wrst(connect,'you')
											else
												if ob[ob[which].fighting].invisible then
													wrst(connect,'something you can''t see')
												else
													shortname(ob[which].fighting,object,false,false,false);
											send(connect,'.');
											end;
										if not(ob[which].mobile) and ob[which].extinguish and ob[which].light then
											wrst(connect,' It is lit.');
										if (which=244) and (balloon=1) then
											wrst(connect,' It has been blown up.');
										if not(ob[which].mobile) and (ob[which].c_liquid) and (ob[which].liquid<>0) then
											begin
											wrst(connect,' It contains ');
											wrst(connect,liquids[ob[which].liquid].describe);
											send(connect,'.');
											end;
										if not(ob[which].mobile) and (ob[which].bolts>0) then
											if ob[which].bolts=1 then
												wrst(connect,' With it is 1 arrow.')
											else
												begin
												wrst(connect,' With it are ');
												wrtint(connect,ob[which].bolts);
												wrst(connect,' arrows.');
												end;
										if which<>173 then
											begin
											found:=true or carrying_ob(object,which);
											cr(connect);
											end;
										end;
						if found then cr(connect);
						if action then
							begin
							if (location=ob[196].location) and (ob[196].connect=0) then
								if ob[186].location=-1 then
									act(196,'says "Be off with you, scoundrel!"',false,true)
								else
									if ob[186].location=123 then
										act(196,'says "Who are you? No visitors except on business!"',false,true)
									else
										act(196,'says "Go away. Can''t you see I''m busy?',false,true);
							if location=ob[198].location then
								if ob[45].carries=object then
									act(198,'is pleased to see you.',true,false)
								else
									if ob[54].carries=object then
										act(198,'is plainly glad to see you.',true,false)
									else
										act(198,'frowns sternly and puts a finger to # lips.',true,false);
							if ob[223].location=location then
								if (ob[214].carries=223) and not(invisible) and not(ob[223].blind) then
									begin
									give_object(223,214,object,false);
									if ((ob[66].carries=object) and ob[66].worn) or ((ob[203].carries=object) and ob[203].worn) then
										begin
										wrtln(connect,'The crone tries to prick your finger with the spindle, but fails.');
										act(223,'vanishes, muttering a curse.',true,false);
										remove_object(223);
										end
									else
										begin
										wrst(connect,'The spindle pricks your finger as you take it and you fall asleep ');
										wrtln(connect,'for about 100 years. Somewhere during this time you die of old age.');
										act(object,'is pricked by the spindle and dies.',true,false);
										dead(object);
										ob[214].location:=0;
										ob[214].carries:=223;
										end;
									end;
							end;
						end;
	end;

procedure stam_display(whom : integer);
	external;

function parse(player : player_range; data : in_buffer; print : boolean; me : integer) : boolean;
	external;
	
function weigh(what : integer) : integer;
	external;
	
function fsize(what : integer) : integer;
	external;

procedure lose(who,what : integer; drown,move : boolean);
	forward;

procedure change_st(who,howmuch : integer);

var lp,found,weight,max	: integer;

	begin
	max:=ob[who].max_st;
	for lp:=1 to no_events do
		if (event[lp].kind=23) and (event[lp].flag=who) then
			max:=max+event[lp].flag2;
	addlimit(ob[who].st,max,howmuch);
	if ob[who].st<0 then
		ob[who].st:=0;
	if not(ob[who].sleep) then
		begin
		if (ob[who].st<(ob[who].max_st DIV 3)) then
			wrtln(ob[who].connect,'You''re feeling very tired.');
		if (weigh(who)-ob[who].weight)>ob[who].st then
			begin
			weight:=0;
			found:=0;
			for lp:=1 to no_ob do
				if (lp<>78) and (not(places[ob[who].location].wet) or
				   ((lp<>72) and (lp<>73))) and (ob[lp].carries=who) then
					if weigh(lp)>weight then
						begin
						found:=lp;
						weight:=weigh(lp);
						end;
			if found<>0 then
				begin
				shortname(found,who,true,false,false);
				wrtln(ob[who].connect,' slips from your grasp.');
				doubleact(who,found,'can no longer hold',true,false,false);
				lose(who,found,false,false);
				end;
			end;
		if ob[who].st=0 then
			begin
			wrtln(ob[who].connect,'A terrible weakness overcomes you... you slump to the ground.');
			act(who,'falls unconscious, dropping everything.',true,false);
			ob[who].sleep:=true;
			set_event(1,who,0,4000+rnd(2000));
			dropall(who,true,false);
			end;
		end;
	end;

procedure change_dex(who,howmuch : integer);

var lp,max	: integer;

	begin
	max:=ob[who].max_dex;
	for lp:=1 to no_events do
		if (event[lp].kind=24) and (event[lp].flag=who) then
			max:=max+event[lp].flag2;
	addlimit(ob[who].dex,max,howmuch);
	if ob[who].dex<0 then ob[who].dex:=0;
	end;

procedure lose;

var remove,
    laked,
    clobber_him	: boolean;
    new_loc,
    temp : integer;

	begin
	with ob[what] do
		begin
		remove:=false;
		laked:=false;
		clobber_him:=false;
		new_loc:=0;
		location:=real_loc(who);
		carries:=0;
		worn:=false;
		kept:=false;
		if ob[who].mobile then
			begin
			if ob[who].weapon1=what then
				ob[who].weapon1:=0;
			if ob[who].weapon2=what then
				ob[who].weapon2:=0;
			change_dex(who,(ob[what].size DIV 15));
			end;
		if move then
			begin
			case location of
				92,93,87,89,48,47:
					begin
					wrtln(ob[who].connect,'Splash!');
					{ score points! }
					score_point(who,value);
					remove:=true;
					laked:=true;
					end;
				46:
					new_loc:=45;
				122:
					new_loc:=29;
				438,439,477:
					begin
					wrtln(ob[who].connect,'It falls into the lava and is destroyed.');
					remove:=true;
					end;
				509,508,507:
					new_loc:=506;
				880,881:
					new_loc:=879;
				878:
					new_loc:=877;
				526,662:
					begin
					wrtln(ob[who].connect,'It falls down the pit.');
					{ bonuses, score, etc }
					if value>0 then
						begin
						wrtln(ob[who].connect,'You feel a strange tingling sensation.');
						case rnd(20) of
							1,2,3,10:
								addlimit(ob[who].magic,ob[who].max_magic,rnd(20)+5);
							4,5,6,11,19:
								begin
								addlimit(ob[who].con,ob[who].max_con,rnd(20)+5);
								change_st(who,rnd(20)+5);
								end;
							7,8,9,12,18:
								score_point(who,value div 2);
							13,17:
								begin
								ob[who].glowing:=true;
								wrtln(ob[who].connect,'You have started to glow!');
								act(who,'starts to glow!',true,false);
								end;
							14:
								if rnd(6)=1 then
									addlimit(ob[who].max_con,32766,1)
								else
									score_point(who,value);
							15:
								if rnd(6)=1 then
									addlimit(ob[who].max_st,32766,1)
								else
									score_point(who,value);
							16:
								if rnd(6)=1 then
									addlimit(ob[who].max_dex,32766,1)
								else
									score_point(who,value);
							20:
								begin
								wrtln(ob[who].connect,'You have become invisible!');
								act(who,'vanishes away.',true,false);
								ob[who].invisible:=true;
								if f_level(who)<12 then
									set_event(18,who,0,30000+rnd(30000));
								end;
							end;
						end;
					remove:=true;
					end;
				170,161,200,201:
					new_loc:=195;
				130:
					new_loc:=131;
				146,147,148,149,152:
					begin
					wrtln(ob[who].connect,'It falls into the chasm.');
					remove:=true;
					end;
				247:
					{ falls on ogre! }
					if ob[102].location=245 then
						begin
						location:=245;
						if weigh(what)>105 then
							begin
							dotext(ob[who].connect,127,129);
							act(102,'vanishes in a cloud of dirty black smoke.',true,false);
							remove_object(102);
							score_point(who,100);
							end
						else
							if what=78 then
								begin
								clobber_him:=true;
								remove:=true;
								end
							else
								dotext(ob[who].connect,125,126);
						end
					else
						new_loc:=245;
				150:
					new_loc:=479;
				151:
					new_loc:=469;
				267,266,265,264,263,262,261,260:
					new_loc:=8;
				570:
					begin
					wrtln(ob[who].connect,'Splosh! It falls into the water.');
					if what=172 then
						begin
						tellall(ob[who].location,0,'The poison capsule dissolves. The seaweed turns brown and withers.',true,false);
						seaweed:=false;
						remove:=true;
						end;
					end;
				580:
					begin
					wrtln(ob[who].connect,'It falls into the machinery below.');
					if clockwk then
						begin
						stoptime:=gettime;
						wrtln(ob[who].connect,'There is a terrible grinding crash as the machinery shudders to a halt.');
						clockwk:=false;
						score_point(who,100);
						end;
					remove:=true;
					end;
				626:
					if what=13 then
						begin
						wrtln(ob[who].connect,'You place the gargoyle on the pedestal and it slips into place.');
						act(who,'repairs the statue with the gargoyle.',true,false);
						remove:=true;
						garg_pd:=true;
						score_point(who,120);
						end;
				end;
			if (what=175) and ((location=672) or (location=673)) then
				begin
				act(what,'rolls away.',true,false);
				if (location=672) and rockfall then
					begin
					tellall(672,0,'There is a rumble as of many rocks falling.',false,true);
					rockfall:=false;
					end;
				location:=674;
				act(what,'rolls in.',true,false);
				end;
			if new_loc<>0 then
				begin
				act(what,'falls from sight.',true,false);
				location:=new_loc;
				act(what,'falls from above, landing here.',true,false);
				end;
			if (places[location].wet) then
				begin
				if fsize(what)<weigh(what) then
					begin
					laked:=true;
					act(what,'sinks like a stone.',true,false);
					remove:=true;
					end
				else
					if extinguish then
						begin
						light:=false;
						burns:=false;
						act(what,'flickers and goes out.',true,false);
						end;
				end;
			if remove then
				begin
				dropall(what,false,true);
				remove_object(what);
				end;
			end;
		if drowns(who,location) and ob[who].mobile and drown then
			begin
			act(who,'drowns!',true,false);
			dotext(ob[who].connect,135,137);
			dead(who);
			end;
		if (what=78) and move then
			if clobber_him then
				begin
				act(who,'is struck by some kind of missile from below!',true,false);
				dotext(ob[who].connect,130,132);
				dead(who);
				end
			else
				if (remove or (new_loc<>0)) and not(laked) then
					begin
					wrtln(ob[who].connect,tdata[75]);
					score_point(who,100);
					if not(remove) then
						begin
						act(78,'smashes to thousands of pieces.',true,false);
						remove_object(78);
						end;
					end
				else
					begin
					wrtln(ob[who].connect,tdata[76]);
					act(who,'drops the egg, which bursts, giving off noxious fumes.',true,false);
					dead(who);
					remove_object(78);
					end;
		end;
	end;

procedure move(who,where : integer);

var dr,
    newloc,
    wherefr,
    lp		: integer;
    movestr	: string[10];
    safe	: boolean;

	begin
	wherefr:=ob[who].location;
	safe:=false;
	for lp:=87 to no_ob do
		if ob[lp].location>0 then
			if ob[lp].mobile then
				if ob[lp].fighting=who then
					if ob[lp].sleep then
						ob[lp].fighting:=0
					else
						safe:=true;
	if (ob[who].crippled) or (who=stocks) then
		wrtln(ob[who].connect,'You cannot move!')
	else
		if safe then
			wrtln(ob[who].connect,'You can''t leave while people are fighting you!')
		else
			with places[wherefr] do
				begin
				ob[who].fighting:=0;
				newloc:=0;
				if (value[where]=0) or ((value[where]>no_place) and (value[where]<32766)) then
					if value[where]>32700 then
						wrtln(ob[who].connect,exerrs[32766-value[where]])
					else
						if value[where]=32600 then
							begin
							dotext(ob[who].connect,158,164);
							act(who,'has a go on the Ferris Wheel.',true,false);
							end
						else
							begin
							dir_string(where,false);
							wrtln(ob[who].connect,concat('You can''t go ',dirs,' from here.'));
							end;
				if (value[where]>0) and (value[where]<=no_place) then
					begin
					if drowns(who,value[where]) and not(ice_pond and (value[where]=549)) then
						wrtln(ob[who].connect,'You can''t go that way without a boat.')
					else
						newloc:=value[where];
					end;
				if value[where]=32767 then
					begin
					dr:=find_door(wherefr);
					if doors[dr].open or doors[dr].broken or (doors[dr].s_hole and (fsize(who)<=25)) or
					   ((dr=4) and (f_level(who)>11)) then
						begin
						if dr=4 then
							begin
							wrst(ob[who].connect,'As you move towards it the door fades into nothingness, appearing ');
							wrtln(ob[who].connect,'again as you pass through the other side.');
							end;
						if wherefr=doors[dr].first then
							newloc:=doors[dr].second
						else
							newloc:=doors[dr].first;
						end
					else
						door_stat(dr,who);
					end;
				if value[where]=32766 then
					newloc:=fromlist(8,20);
				for dr:=1 to no_wall do
					if ((wherefr=walls[dr].where1) and (newloc=walls[dr].where2)) or 
					   ((wherefr=walls[dr].where2) and (newloc=walls[dr].where1)) then
					   	{ has hit a wall }
					   	if walls[dr].fire then
							begin
							if f_level(who)<12 then
						   		if (ob[who].con>10) then
						   			begin
						   			wrtln(ob[who].connect,'The wall of fire gives you a nasty burn as you pass through it...');
						   			ob[who].con:=ob[who].con-10;
						   			end
						   		else
					   				begin
						   			wrtln(ob[who].connect,'The fire''s heat is too much for you and you collapse.');
						   			act(who,'is burnt up in the wall of fire!',true,false);
						   			dead(who);
						   			newloc:=0;
						   			end;
					   		end
					   	else
					   		begin
					   		wrtln(ob[who].connect,'The wall of stone blocks your way.');
					   		newloc:=0;
					   		end;
				if (((wherefr=197) and (lever2 and not(lever1) and (who=leverp2)))
                                 or ((wherefr=170) and (lever1 and not(lever2) and (who=leverp1)))) and (newloc<>0) then
					begin
					wrtln(ob[who].connect,tdata[43]);
					newloc:=0;
					end;
				if (newloc=168) and (wherefr=166) then
					if ob[32].carries<>who then
						begin
						dotext(ob[who].connect,44,46);
						newloc:=0;
						act(who,'tries to go south and is turned to stone.',true,false);
						dead(who);
						end
					else
						wrtln(ob[who].connect,'A beam of light comes from the south door but your mirror reflects it.');
				if (newloc=139) and not(ice_melt) then
					begin
					newloc:=0;
					wrtln(ob[who].connect,'The ice blocks your way.');
					end;
				if ((newloc=365) or (wherefr=365)) and not(wall_hole) then
					begin
					newloc:=0;
					wrtln(ob[who].connect,'You can''t walk through walls.');
					end;
				if ((newloc=531) and (wherefr=532)) or ((newloc=532) and (wherefr=531)) then 
                                   begin
                                   wrtln(ob[who].connect,'You can''t get through the fallen rocks.');
                                   newloc:=0;
                                   end;
				if ((newloc=421) or (wherefr=421)) and not(sesame) then
					begin
					newloc:=0;
					wrtln(ob[who].connect,tdata[74]);
					end;
				if (ob[who].location>0) then
					if (wherefr=ob[124].location) and not(ob[124].sleep) and not(ob[124].blind) then
						if ((newloc=486) and doors[15].open) or ((newloc=484) and doors[14].open) then
							begin
							wrtln(ob[who].connect,'The Guardian forbids your passage this way.');
							newloc:=0;
							end;
				if newloc=430 then
					if (ob[39].carries=who) and (ob[62].carries=who) and (ob[63].carries=who) and ob[39].worn then
						begin
						dotext(ob[who].connect,90,91);
						score_point(who,1000);
						mu_chance(who);
						if ob[who].location=830 then newloc:=0;
						lose(who,39,false,false);
						remove_object(39);
						lose(who,62,false,false);
						remove_object(62);
						lose(who,63,false,false);
						remove_object(63);
						end
					else
						begin
						dotext(ob[who].connect,86,89);
						newloc:=0;
						act(who,'tries to mount the throne and crashes back, dead.',true,false);
						dead(who);
						end;
				if (newloc=446) and (who<>117) and not(doors[13].open) then
					begin
					wrtln(ob[who].connect,'As you enter the room, you hear a hum of machinery from the west.');
					nine_to_1:=true;
					end;
				if ((newloc>446) and (newloc<455)) and (who<>117) and nine_to_1 and not(doors[13].open) then
					if wherefr<>(newloc-1) then
						begin
						wrtln(ob[who].connect,'Something slams shut, not far away.');
						nine_to_1:=false;
						end
					else
						if newloc=454 then
							begin
							score_point(who,75);
							doors[13].open:=true;
							dsall(13);
							end;
				if ((newloc=431) or (newloc=432)) and volcano then
					begin
					wrtln(ob[who].connect,'Are you crazy! It''s covered in red-hot lava!');
					newloc:=0;
					end;
				if (newloc=528) and (ob[who].location>0) then
					if (weigh(who)>1406) then
						begin
						wrtln(ob[who].connect,'The bridge creaks and groans under your weight, and you retreat hastily.');
						act(who,'tries to cross the bridge, but is too heavy.',true,false);
						newloc:=0;
						end;
				if (newloc=867) and (ob[who].location>0) then
					if (ob[235].location<>ob[who].location) or (ob[who].size<1000) then
						begin
						wrtln(ob[who].connect,'You can''t reach the trapdoor.');
						newloc:=0;
						end;
				if (newloc=545) and (ob[who].location>0) then
					if (fsize(who)>1230) then
						begin
						wrtln(ob[who].connect,'You can''t quite squeeze through the crack.');
						act(who,'tries to fit through the crack, but is too bulky.',true,false);
						newloc:=0;
						end;
				if ob[who].location>0 then
					if (wherefr=534) and not(blind_q(who)) then
						begin
						wrtln(ob[who].connect,'You cannot escape the fascination of the patterns.');
						newloc:=0;
						end;
				if ob[who].location>0 then
					if (newloc=522) and (wherefr=521) and kobolds_bl then
						begin
						wrtln(ob[who].connect,'The kobolds grab you and drag you off to prison.');
						act(who,'is dragged away by the kobolds.',true,false);
						ob[who].location:=517;
						doors[17].open:=false;
						act(who,'is thrown in by angry kobolds.',true,false);
						look(who,true);
						newloc:=0;
						end;
				if ob[who].location>0 then
					if (wherefr=570) and seaweed then
						begin
						act(who,'struggles in the clutches of the weed.',true,false);
						wrtln(ob[who].connect,'The weed holds tightly onto your legs. You can''t escape!');
						newloc:=0;
						end;
				if ob[who].location>0 then
					if (((wherefr=591) and (newloc=592)) or ((wherefr=592) and (newloc=591))) and mirror then
						begin
						wrtln(ob[who].connect,'You can''t go that way.');
						newloc:=0;
						end;
				if (newloc=549) and ice_pond then
					begin
					wrtln(ob[who].connect,'As you step onto the ice it breaks and you are pitched into freezing water...');
					ice_pond:=false;
					end;
				if ob[who].location>0 then
					if (((wherefr=597) and (newloc=596)) or ((wherefr=596) and (newloc=597))) and glass_sh then
						begin
						wrtln(ob[who].connect,'The glass bars your way - it''s too thick to break through.');
						newloc:=0;
						end;
				if (newloc=642) then
					if (ob[174].carries<>who) or not(ob[174].worn) then
						begin
						newloc:=0;
						wrtln(ob[who].connect,'You''re not authorised to go in there!');
						end;
				if ob[who].location>0 then
					if wherefr=666 then
						begin
						safe:=true;
						for dr:=86 to no_ob do
							if (dr<>who) and (ob[dr].location=666) and ob[dr].mobile then
								safe:=false;
						if not(safe) then
							begin
							wrtln(ob[who].connect,'You are not permitted to leave the Arena.');
							newloc:=0;
							end;
						end;
				if (newloc=673) and rockfall then
					begin
					dotext(ob[who].connect,152,154);
					act(who,'trips a hidden wire and perishes under a fall of rocks.',true,false);
					dead(who);
					newloc:=0;
					rockfall:=false;
					end;
				if newloc=887 then
					if (ob[244].carries=who) and (balloon=1) then
						begin
						score_point(who,100);
						balloon:=2;
						end
					else
						begin
						dotext(ob[who].connect,173,174);
						newloc:=0;
						end;
				if (((newloc=871) and (wherefr=870)) or ((newloc=870) and (wherefr=871))) and turnstile then
					begin
					newloc:=0;
					wrtln(ob[who].connect,'The turnstile obstinately refuses to turn.');
					end;
				if ((newloc>=787) and (newloc<=790)) and (acidlake<>0) then
					begin
					acidlake:=acidlake+1;
					if acidlake>=4 then
						begin
						dotext(ob[who].connect,143,145);
						act(who,'is overpowered by the fumes of the lake.',true,false);
						dead(who);
						newloc:=0;
						end
					else
						wrtln(ob[who].connect,'The fumes of the lake are affecting you badly.');
					end;
				if (newloc=634) and (ob[173].location=633) then
					begin
					wrtln(ob[who].connect,'ZAP! That''s what you get for not reading notices!');
					act(who,'is magically struck dead as # foot touches the grass.',true,false);
					dead(who);
					newloc:=0;
					end;
				if (((newloc=639) and (wherefr=618)) or ((newloc=618) and
				    (wherefr=639))) and tree then
					begin
					wrtln(ob[who].connect,'The tree blocks your way.');
					newloc:=0;
					end;
				if (newloc=826) and (ob[225].location=wherefr) and
				    not(ob[225].blind) and not(ob[225].sleep) then
						begin
						wrtln(ob[who].connect,'The pirate won''t let you go through the door.');
						newloc:=0;
						end;
				if newloc=686 then
					if who<>197 then
						begin
						safe:=(ob[who].control>0);
						if (ob[197].location<>686) or (ob[197].possessed) or ob[who].possessed then
							safe:=false;
						if safe then
							begin
							act(who,'turns into a mouse!',true,false);
							ob[197].possessed:=true;
							ob[197].male:=ob[who].male;
							position[ob[who].connect,8]:=197;
							position[ob[who].connect,7]:=0;
							ob[who].deaf:=true;
							ob[197].connect:=ob[who].connect;
							ob[197].location:=681;
							ob[who].location:=686;
							wrtln(ob[who].connect,'You have turned into a mouse!');
							newloc:=0;
							end
						else
							begin
							wrtln(ob[who].connect,'Magic prevents you from going that way.');
							newloc:=0;
							end;
						end
					else
						begin
						safe:=true;
						if ob[position[ob[197].connect,6]].location<0 then
							safe:=false
						else
							if (ob[position[ob[197].connect,6]].location<>686) or (ob[position[ob[197].connect,6]].possessed) then
								safe:=false;
						if safe then
							begin
							act(197,'turns into a human again!',true,false);
							ob[197].possessed:=false;
							position[ob[197].connect,8]:=0;
							ob[197].location:=686;
							ob[who].deaf:=false;
							ob[position[ob[197].connect,6]].location:=681;
							wrtln(ob[who].connect,'You have turned into a human again!');
							newloc:=0;
							ob[197].connect:=0;
							end
						else
							begin
							wrtln(ob[who].connect,'Magic prevents you from going that way.');
							newloc:=0;
							end;
						end;
				if (newloc=677) and (who=197) then
					begin
					wrtln(ob[197].connect,'Mice can''t go that way - the gap in the floor''s too wide.');
					newloc:=0;
					end;
				if ob[who].location>0 then
					if (((wherefr=575) and (newloc=576)) or ((wherefr=576) and (newloc=575))) and clockwk then
						begin
						act(who,'is struck by the pendulum and falls from the gantry.',true,false);
						dotext(ob[who].connect,146,147);
						ob[who].location:=551;
						act(who,'crashes down from above.',true,false);
						dead(who);
						newloc:=0;
						end;
				if ob[who].location>0 then
					if (newloc=831) and (ob[who].class<>2) then
						begin
						wrtln(ob[who].connect,'The portal will not let you pass!');
						newloc:=0;
						end;
				if ob[who].location>0 then
					if ((newloc=881) and (wherefr=880)) or ((wherefr=881) and (newloc=880)) then
						if (ob[241].carries=who) and ((weigh(who)-ob[who].weight)=50) then
							dotext(ob[who].connect,169,172)
						else
							begin
							dotext(ob[who].connect,165,168);
							newloc:=0;
							ob[who].location:=879;
							act(who,'plunges from above through the net, leaving # possessions behind.',true,false);
							dropall(who,false,false);
							ob[who].location:=876;
							act(who,'crashes down from above.',true,false);
							dead(who);
							end;
				if newloc<>0 then
					begin
					repeat
					safe:=true;
					lp:=1;
					while (lp<=no_fol) and safe do
						begin
						if follows[lp,2]=who then
							if (ob[who].location<>ob[follows[lp,1]].location) or
							   cant_see_obj(follows[lp,1],who) or ob[follows[lp,1]].sleep then
								begin
								stop_follow(follows[lp,1],true,false);
								safe:=false;
								end;
						lp:=lp+1;
						end;
					until safe;
					movestr:=ob[who].movem;
					if places[wherefr].wet then
						movestr:='rows';
					dir_string(where,false);
					if where>8 then
						act(who,concat('goes ',dirs,'.'),true,false)
					else
						act(who,concat(movestr,' out, ',dirs,'wards.'),true,false);
					ob[who].location:=newloc;
					look(who,true);
					if ob[who].location>0 then
						begin
						act(who,concat(movestr,' in.'),true,false);
						for lp:=1 to no_fol do
							if follows[lp,2]=who then
								move(follows[lp,1],where);
						if (who<>102) and (ob[102].location=newloc) then
							begin
							doubleact(who,102,'is kicked sky-high by',true,false,true);
							dotext(ob[who].connect,52,54);
							ob[who].location:=rnd(122);
							act(who,'hurtles from the skies.',true,false);
							look(who,true);
							end;
						end;
					if (ob[who].location=808) and (weigh(who)>1415) then
						begin
						act(who,'sinks into the mud.',true,false);
						dotext(ob[who].connect,148,149);
						dead(who);
						end;
					if (who<>222) and (ob[who].location=792) and (ob[222].location=793) and not(ob[222].sleep) then
						begin
						act(222,'picks up a boulder and hurls it down onto the ladder.',true,false);
						tellall(792,0,'Something throws a boulder down from above.',true,false);
						if (ob[204].carries=who) and ob[204].worn then
							wrtln(ob[who].connect,'A boulder bounces off your helm and falls to the ground.')
						else
							begin
							wrtln(ob[who].connect,'Something strikes you on the head and sends you crashing to the ground.');
							ob[who].location:=798;
							act(who,'falls from above, stunned.',true,false);
							look(who,true);
							end;
						end;
					if nastytree and (ob[who].location=801) then
						begin
						act(who,'is trapped in the evil tree.',true,false);
						dotext(ob[who].connect,150,151);
						dead(who);
						end;
					if ob[who].location>0 then
						if (newloc=886) and (wherefr=885) then
							begin
							tellall(886,0,'There is a loud crash from above!',false,true);
							doors[24].open:=false;
							dsall(24);
							end;
					end;
				end;
	end;

procedure grab(who,what : integer);

	begin
	with ob[what] do
		begin
		location:=0;
		carries:=who;
		if ob[who].mobile then
			begin
			if (ob[36].carries=who) and (ob[33].carries=who) and (ob[35].carries=who) and (ob[74].location=123) then
				begin
				{ we have g'powder ingredients }
				lose(who,36,false,false);
				lose(who,33,false,false);
				lose(who,35,false,false);
				remove_object(36);
				remove_object(33);
				remove_object(35);
				grab(who,74);
				wrtln(ob[who].connect,'You now have gunpowder!');
				act(who,'now has some gunpowder!',true,false);
				end;
			if ob[what].location<>-1 then
				ob[who].dex:=ob[who].dex-(ob[what].size DIV 15);
			end;
		end;
	end;

procedure err(who,number : integer; fatal : boolean);
	external;

procedure get_object(who,what : integer; errors,suppress,lawful : boolean);

var getit	: boolean;

	begin
	if ob[what].carries<>0 then
		begin
		if (ob[ob[what].carries].location=ob[who].location) and
		   not(ob[ob[what].carries].mobile) then
			lose(ob[what].carries,what,false,false);
		end;
	if ob[what].carries<>0 then
		begin
		if errors then
			if ob[what].carries=who then
				wrtln(ob[who].connect,'You already have that!')
			else
				if ob[ob[what].carries].location=ob[who].location then
					begin
					shortname(ob[what].carries,who,true,false,false);
					wrtln(ob[who].connect,' is carrying that.');
					end
				else
					err(who,7,errors);
		end
	else
		if ob[who].location<>ob[what].location then
			err(who,7,errors)
		else
			if ob[what].mobile then
				err(who,6,errors)
			else
				if (weigh(who)+weigh(what)-ob[who].weight)>ob[who].st then
					begin
					if weigh(what)>ob[who].st then
						begin
						shortname(what,who,true,false,false);
						wrtln(ob[who].connect,' is too heavy for you to lift.');
						end
					else
						begin
						wrst(ob[who].connect,'You''re carrying too much to take ');
						shortname(what,who,false,false,false);
						wrtln(ob[who].connect,' at the moment.');
						end;
					end	
				else
					begin
					getit:=true;
					if (what=245) and duckfl then
						begin
						if ob[240].carries=who then
							begin
							wrtln(ob[who].connect,'Using the hooked stick you pull the duck from the water.');
							duckfl:=false;
							end
						else
							begin
							wrtln(ob[who].connect,'The duck is out of your reach, in the water.');
							getit:=false;
							end;
						end;
					if what=189 then
						begin
						curcno:=curcno+1;
						{ the Philosopher's Stone }
						act(who,'touches the Philosopher''s Stone, which vanishes.',true,false);
						wrtln(ob[who].connect,'The stone vanishes in your hands but leaves you refreshed and healed.');
						de_drunk(who,ob[who].drunk);
						ob[who].thirsty:=0;
						ob[189].location:=rnd(no_place);
						act(189,'appears!',true,false);
						addlimit(ob[who].magic,ob[who].max_magic,25+rnd(25));
						change_st(who,30+rnd(30));
						addlimit(ob[who].con,ob[who].max_con,25+rnd(25));
						stam_display(who);
						end
					else
						if getit then
							begin
							grab(who,what);
							curcno:=curcno+1;
							if ob[what].location<>-1 then
								begin
								wrst(ob[who].connect,'You have ');
								shortname(what,who,false,false,false);
								wrtln(ob[who].connect,'.');
								if not(suppress) then
									doubleact(who,what,'takes',true,false,false);
								end;
							if (what=209) and (((f_level(who)<14) and not(lawful)) or (f_level(who)<12)) then
								begin
								wrtln(ob[who].connect,'The hellsword''s power is too great for you - you feel it burning you away!');
								act(who,'is destroyed by the power of the hellsword.',true,false);
								dead(who);
								curstop:=true;
								end;
							end;
					end;
	end;

procedure drop_object(who,what : integer; errors : boolean);

	begin
	if ob[what].carries<>who then
		err(who,8,errors)
	else
		begin
		doubleact(who,what,'drops',true,false,false);
		wrst(ob[who].connect,'Dropped ');
		shortname(what,who,false,false,false);
		wrtln(ob[who].connect,'.');
		lose(who,what,true,true);
		curcno:=curcno+1;
		end;
	end;


procedure de_drunk;

	begin
	ob[who].drunk:=ob[who].drunk-howmuch;
	change_st(who,howmuch);
	change_dex(who,howmuch);
	if (ob[who].drunk<=0) and (howmuch<>0) then
		begin
		ob[who].drunk:=0;
		wrtln(ob[who].connect,'You are sober.');
		end;
	end;

procedure moberr(who : integer);

var tempst	: string[40];

	begin
	case rnd(6) of
		1:
			tempst:='What?';
		2:
			tempst:='Sorry?';
		3:
			tempst:='Come again?';
		4:
			tempst:='You what?';
		5:
			tempst:='I beg your pardon?';
		6:
			tempst:='Eh?';
		end;
	act(who,concat('says "',tempst,'".'),false,true);
	end;

procedure interr(who,error : integer);

	begin
	wrst(ob[who].connect,'The interpreter ');
	case rnd(6) of
		1:
			wrst(ob[who].connect,'is confused. ');
		2:
			wrst(ob[who].connect,'is baffled. ');
		3:
			wrst(ob[who].connect,'is perplexed. ');
		4:
			wrst(ob[who].connect,'doesn''t follow you. ');
		5:
			wrst(ob[who].connect,'is puzzled. ');
		6:
			wrst(ob[who].connect,'fails to understand. ');
		end;
	case error of
		0:
			wrtln(ob[who].connect,'You used the wrong kind of object in the command.');
		1:
			wrtln(ob[who].connect,'There were too many or too few words in the command.');
		2:
			wrtln(ob[who].connect,'You used the wrong kind of object or the wrong number of words.');
		3:
			wrtln(ob[who].connect,'The correct syntax is <verb> <object / group>.');
		4:
			wrtln(ob[who].connect,'The correct syntax is <verb> <single object>.');
		5:
			wrtln(ob[who].connect,'It expects a location name in quotes, a number, or a single object.');
		6:
			cr(ob[who].connect);
		7:
			wrtln(ob[who].connect,'The correct syntax is <verb> <number>.');
		8:
			wrtln(ob[who].connect,'The command expects to operate on a mobile.');
		end;
	if whosays<>0 then
		moberr(who);
	end;

procedure scenerr(who, what, response : integer; object : com_element);

	begin
	if object.which=8 then
		{ this is a virtual object }
		if (find_virtual(object.virtual,ob[who].location)=0) then
			err(who,7,true) { not here }
		else
			case response of
				1:
					wrtln(ob[who].connect,'That''s just scenery. Ignore it.');
				2:
					wrtln(ob[who].connect,'You can''t do that to that!');
				3:
					wrtln(ob[who].connect,'Ask yourself... what''s the point?');
				end
	else
		interr(who,what);
	end;

procedure init_categ(which : integer);

	begin
	curcat:=which;
	curcpos:=1;
	curcno:=0;
	curob:=categs[which].objects[1,1]-1;
	curstop:=false;
	end;

function doingcat : boolean;

	begin
	curob:=curob+1;
	repeat
		while (ob[curob].location=-1) and (curob<=(categs[curcat].objects[curcpos,2])) do
			curob:=curob+1;
		if curob>categs[curcat].objects[curcpos,2] then
			begin
			curcpos:=curcpos+1;
			curob:=categs[curcat].objects[curcpos,1];
			if curob=0 then
				begin
				curstop:=true;
				curob:=1;
				{ to stop value out of range error }
				end;
			end;
	until (ob[curob].location<>-1) or curstop;
	doingcat:=not(curstop);
	end;

procedure put_object(who,what,where : integer; errors : boolean);

var ccsize,
    lp		: integer;

	begin
	if ob[what].carries<>who then
		err(who,8,errors)
	else
		if (what=where) then
			err(who,6,errors)
		else
			begin
			ccsize:=0;
			for lp:=1 to no_ob do
				if ob[lp].carries=where then
					ccsize:=ccsize+fsize(lp);
			if (fsize(what)+ccsize)>ob[where].contsize then
				begin
				shortname(what,who,true,false,false);
				wrst(ob[who].connect,' won''t fit in ');
				shortname(where,who,false,false,false);
				wrtln(ob[who].connect,'.');
				end
			else
				begin
				lose(who,what,true,false);
				grab(where,what);
				if ob[who].location<>-1 then
					begin
					wrst(ob[who].connect,'Placed ');
					shortname(what,who,false,false,false);
					wrst(ob[who].connect,' in ');
					shortname(where,who,false,false,false);
					wrtln(ob[who].connect,'.');
					tripleact(who,what,where,'puts','in',true,false);
					curcno:=curcno+1;
					if ob[where].flammable and ob[what].burns then
						begin
						{ we have put something lit into a flammable container }
						act(where,'catches light and burns merrily!',true,false);
						if ob[where].carries=who then
							lose(who,where,true,false);
						remove_object(where);
						curstop:=true;
						end;
					end
				else
					curstop:=true;
				end;
			end;
	end;

procedure put_virt(who,what,where,which : integer; errors : boolean);

var lp	: integer;
    go	: boolean;

	begin
	if ob[what].carries<>who then
		err(who,8,errors)
	else
		case where of
			{ in which virtual are we putting the object }
			21:
				begin
				{ only coins can be put in - is this a coin (cat 13) }
				go:=false;
				for lp:=1 to 16 do
					if (what>=categs[13].objects[lp,1]) and (what<=categs[13].objects[lp,2]) then
						go:=true;
				if go then
					begin
					curcno:=curcno+1;
					act(who,'puts a coin in the slot.',true,false);
					wrst(ob[who].connect,'Placed ');
					shortname(what,who,false,false,false);
					wrtln(ob[who].connect,' in the slot.');
					if turnstile then
						begin
						tellall(870,0,'There is a loud ''CLUNK'' from the turnstile.',false,true);
						tellall(871,0,'There is a loud ''CLUNK'' from the turnstile.',false,true);
						turnstile:=false;
						end;
					lose(who,what,true,false);
					if ob[who].location=-1 then
						curstop:=true;
					ob[what].location:=872;
					act(what,'appears in mid-air and falls to the ground.',true,false);
					end
				else
					begin
					shortname(what,who,true,false,false);
					wrtln(ob[who].connect,' won''t fit in.');
					end;
				end;
			end;
	end;

procedure put_somet(who : integer);

var virtual, go	: boolean;
    virt	: integer;

	begin
	if (no_com<>4) or (commands[2].which=1) or (commands[2].which>3) or (commands[3].which<>1)
	or (commands[3].vb<>11) or ((commands[4].which<>2) and (commands[4].which<>8)) then
		scenerr(who,2,2,commands[2])
	else
		begin
		virtual:=commands[4].which=8;
		go:=true;
		if virtual then
			begin
			virt:=find_virtual(commands[4].virtual,ob[who].location);
			if virt=0 then
				begin
				wrtln(ob[who].connect,'Can''t see one of those at the moment.');
				go:=false;
				end
			else
				if commands[4].virtual<>21 then
					begin
					wrtln(ob[who].connect,'You can''t put anything in that!');
					go:=false;
					end;
			end
		else
			if ((ob[commands[4].object].carries<>who)
			   and (ob[commands[4].object].location<>ob[who].location))
			   or (ob[commands[4].object].mobile)
			   or (ob[commands[4].object].contdesc=0) then
				begin
				wrtln(ob[who].connect,'You can''t put anything in that!');
				go:=false;
				end;
		if go then
			if commands[2].which=2 then
				if virtual then
					put_virt(who,commands[2].object,commands[4].object,virt,true)
				else
					put_object(who,commands[2].object,commands[4].object,true)
			else
				begin
				init_categ(commands[2].category);
				while doingcat do
					if not(ob[curob].kept) then
						if virtual then
							put_virt(who,curob,commands[4].object,virt,false)
						else
							put_object(who,curob,commands[4].object,false);
				if curcno=0 then
					wrtln(ob[who].connect,'You couldn''t find anything to put in that.');
				end;
		end;
	end;

procedure mobile_move(mobile : integer);
	forward;

procedure give_object;
	
	begin
	if ob[what].carries<>who then
		err(who,8,errors)
	else
		if who=whom then
			err(who,6,errors)
		else
			if ob[whom].location<>ob[who].location then
				err(who,7,errors)
			else
				begin
				tripleact(who,what,whom,'gives','to',true,false);
				shortname(who,whom,true,false,true);
				wrst(ob[whom].connect,' gives you ');
				shortname(what,whom,false,false,false);
				wrtln(ob[whom].connect,'.');
				lose(who,what,true,false);
				get_object(whom,what,true,false,true);
				if (ob[what].location<>-1) then
					begin
					if (ob[what].carries=0) and (ob[whom].location<>-1) then
						doubleact(whom,what,'couldn''t take',true,false,true);
					if (ob[who].location<>-1) and (ob[what].carries=whom) then
						begin
						wrst(ob[who].connect,'Given ');
						shortname(what,who,false,false,false);
						wrtln(ob[who].connect,'.');
						curcno:=curcno+1;
						if (whom=198) and ((what=45) or (what=54)) and
						   (ob[177].carries=198) and (ob[what].carries=198) then
							begin
							wrtln(ob[who].connect,'The librarian is delighted with your gift.');
							give_object(198,177,who,false);
							end;
						if (whom=196) and (ob[whom].location<>-1) then
							if what=184 then
								begin
								if ob[186].location=123 then
									begin
									ob[186].location:=ob[196].location;
									act(196,'snatches the gold and deftly beats it into a horseshoe.',true,false);
									act(186,'is thrown to the ground.',true,false);
									lose(196,184,false,false);
									remove_object(184);
									end;
								end
							else
								begin
								act(196,'says "What do you expect me to do with this?" and throws it in the fire.',false,true);
								lose(196,what,false,false);
								remove_object(what);
								if what=74 then
									begin
									tellall(ob[196].location,0,'There is a tremendous explosion which sends you flying across the room...',false,false);
									half_dead(196,who);
									end;
								end;
						if (whom=106) and (ob[whom].location<>-1) then
							begin
							if ob[what].value>0 then
								begin
								if rnd(3)=1 then
									begin
									addlimit(ob[who].con,ob[who].max_con,20+rnd(30));
									act(106,'mutters the words of a spell.',false,true);
									stam_display(who);
									end
								else
									act(106,'grunts # thanks surlily.',false,true);
								end
							else
								act(106,'looks at you in faint disgust.',true,false);
							shortname(106,who,true,true,false);
							wrtln(ob[who].connect,' then wanders off to dispose of the booty.');
							mobile_move(106);
							if ob[what].location<>-1 then
								remove_object(what);
							end;
						if (whom=224) and (what=58) then
							if (ob[215].carries=224) and (ob[58].carries=224) then
								begin
								act(224,'bows solemnly, in complete silence.',true,false);
								give_object(224,215,who,false);
								ob[58].worn:=true;
								end;
						end;
					end
				else
					begin
					curcno:=curcno+1;
					wrtln(ob[who].connect,'Object given.');
					end;
				end;
	end;

procedure steal_object(who,what,whom : integer; errors : boolean);

var dexchek	: integer;

	begin
	if ob[what].carries<>whom then
		err(who,7,errors)
	else
		if (ob[whom].location<>ob[who].location) or (whom=who) then
			err(who,6,errors)
		else
			begin
			dexchek:=ob[who].dex-ob[whom].dex;
			dexchek:=dexchek+rnd(rnd(100));
			if blind_q(whom) or ob[whom].sleep then
				dexchek:=dexchek+30;
			if ob[who].class=2 then
				dexchek:=dexchek+20;
			if ob[whom].class=2 then
				dexchek:=dexchek-15;
			if (whom=149) then
				begin
				if ob[149].sleep and not(dragonwoken) then
					begin
					act(149,'stirs and wakes.',true,false);
					ob[149].sleep:=false;
					ob[149].dislike:=who;
					dragonwoken:=true;
					end;
				if not(ob[149].sleep and dragonwoken) then
					dexchek:=dexchek-999;
				end;
			if (whom=198) or (whom=224) then
				dexchek:=dexchek-999;
			if ((what=72) or (what=73)) and (places[ob[who].location].wet) then
				dexchek:=dexchek-400;
			if ob[what].worn then
				dexchek:=dexchek-20;
			if dexchek>=0 then
				begin
				tripleact(who,what,whom,'has stolen','from',true,true);
				if dexchek<30 then
					begin
					ob[whom].dislike:=who;
					shortname(who,whom,true,false,true);
					wrst(ob[whom].connect,' has stolen ');
					shortname(what,whom,false,false,false);
					wrtln(ob[whom].connect,' from you!');
					end;
				lose(whom,what,true,false);
				curcno:=curcno+1;
				get_object(who,what,true,true,false);
				if ob[what].location<>-1 then
					if (ob[what].carries=0) and (ob[who].location<>-1) then
						doubleact(who,what,'couldn''t take',true,false,true);
				end
			else
				begin
				tripleact(who,what,whom,'just tried to steal','from',true,true);
				wrst(ob[who].connect,'Failed to steal ');
				shortname(what,who,false,false,false);
				wrtln(ob[who].connect,'.');
				if (dexchek<-20) and not(ob[whom].sleep) then
					begin
					ob[whom].dislike:=who;
					shortname(who,whom,true,false,true);
					wrst(ob[whom].connect,' just tried to steal ');
					shortname(what,whom,false,false,false);
					wrtln(ob[whom].connect,' from you!');
					end;
				if (whom=198) or (whom=224) then
					begin
					tellall(ob[who].location,0,'ZAP! "Theft from government employees is an offence!"',false,false);
					act(who,'is struck dead for theft from a government employee!',true,false);
					dead(who);
					end;
				end;
			end;
	end;			

procedure dropall;

{ note that 'TELL' tells anyone around that the objects have been dropped.
  and MOVE is the LOSE parameter move (so that dying mobs don't drop eggs etc) }

var lp	: integer;
 
	begin
	for lp:=1 to no_ob do
		if ob[lp].carries=what then
			begin
			lose(what,lp,false,move);
			if tell and (ob[lp].location<>-1) then act(lp,'falls.',false,true);
			end;
	end;
	
procedure empty_object(who,what : integer; errors : boolean);

	begin
	if (ob[what].location<>ob[who].location) and (ob[what].carries<>who) then
		err(who,7,errors)
	else
		if ((ob[what].contdesc=0) and not(ob[what].c_liquid)) or ob[what].mobile then
			err(who,6,errors)
		else
			if ob[what].weight>ob[who].st then
				begin
				wrst(ob[who].connect,'You can''t lift ');
				shortname(what,who,false,false,false);
				wrtln(ob[who].connect,' to empty it.');
				end
			else
				begin
				doubleact(who,what,'empties',true,false,true);
				wrst(ob[who].connect,'Emptied ');
				shortname(what,who,false,false,false);
				wrtln(ob[who].connect,'.');
				curcno:=curcno+1;
				if ob[what].c_liquid then
					begin
					if (ob[what].liquid=7) and (ob[who].location=800) then
						if nastytree then
							begin
							nastytree:=false;
							tellall(ob[who].location,0,'The acid soaks into the ground and kills the tree.',true,false);
							end;
					ob[what].liquid:=0;
					end
				else
					dropall(what,true,true);
				end;
	end;

function c_spell(who,percent,cost,whom,whatclass,startlev,verbal : integer) : integer;

{ the short integer returned means :
    0 : the player failed to cast the spell
    1 : the spell worked perfectly
    2 : the player on whom the spell was cast resisted its effects
    	( spell could work on caster, etc. ) }

var perc,
    work,
    result,
    artifact	: integer;
    possd,
    resist,
    cansay	: boolean;
    	
	begin
	artifact:=0;
	if ob[114].carries=who then
		artifact:=114;
	if ob[248].carries=who then
		artifact:=248;
	possd:=ob[who].possessed;
	if possd then
		if f_level(who_possesses(who))>12 then
			possd:=false;
	result:=0;
	if possd then
		wrtln(ob[who].connect,'You can''t cast spells while possessing.')
	else
		if (ob[who].location=125) and (f_level(who)<12) then
			wrtln(ob[who].connect,'You can''t cast spells in the Wizard''s Dungeon.')
		else
			if (ob[who].class=whatclass) or ((whatclass=0) and (ob[who].class>2))
			   or (f_level(who)>12) or ((artifact<>0) and (((whatclass=3) or (whatclass=0)) and (ob[who].class<3))) then
				if f_level(who)<startlev then
					wrtln(ob[who].connect,'You are on too low a level to cast that particular spell.')
				else
					begin
					cansay:=true;
					if verbal<>0 then
						{ there are some words associated with the spell }
						if spellvb[verbal].spoken then
							if ob[who].dumb then
								begin
								cansay:=false;
								wrtln(ob[who].connect,'You are dumb, you cannot say the words of the spell!');
								end
							else
								act(who,spellvb[verbal].words,false,true)
						else
							act(who,spellvb[verbal].words,true,false);
					if cansay then
						begin
						perc:=percent*f_level(who)-ob[who].drunk;
						if f_level(who)>11 then perc:=101;
						if rnd(100)>perc then
							wrtln(ob[who].connect,tdata[65])
						else
							begin
							if (whom=0) or (whom=who) then
								result:=1
							else
								begin
								perc:=(f_level(who)*rnd(10))-(f_level(whom)*rnd(10));
								resist:=false;
								for work:=1 to 20 do
									resist:=resist or (resisting[work]=whom);
								if resist then perc:=perc-(15+rnd(5*f_level(whom)));
								if ob[whom].shield then
									if f_level(who)<f_level(whom) then
										perc:=-1
									else
										perc:=perc-20;
								if (f_level(who)>11) then
									if (f_level(whom)<f_level(who)) then
										result:=1
									else
										if f_level(who)=f_level(whom) then
											if perc<0 then
												result:=2
											else
												result:=1
										else
											result:=2
								else	
									if (perc<0) or (f_level(whom)>11) then
										{spell has been resisted  - above also checks 4 immortals & precedence }
										result:=2
									else
										result:=1;
								end;
							if artifact<>0 then
								begin
								ob[artifact].value:=ob[artifact].value-cost;
								if ob[artifact].value<=0 then
									begin
									act(artifact,'crumbles away to nothingness.',true,false);
									lose(who,artifact,false,false);
									ob[artifact].location:=123;
									result:=0;
									end;
								end
							else
								begin
								if f_level(who)<=11 then 
									begin
									work:=ob[who].magic-cost;
									change_st(who,-(cost DIV 10));
									if work<0 then
										begin
										dotext(ob[who].connect,79,80);
										ob[who].class:=1;
										ob[who].magic:=0;
										result:=0;
										end
									else
										ob[who].magic:=work;
									end;
								end;
							end;
						end;
					end
			else
				wrtln(ob[who].connect,tdata[64]);
	c_spell:=result;
	end;

procedure where_object(who,what : integer; errors : boolean);

var result : integer;

	begin
	result:=c_spell(who,18,2,0,0,0,0);
	if result=0 then
		curstop:=true
	else
		if (what=189) and (f_level(who)<12) then
			wrtln(ob[who].connect,'You can''t tell.')
		else
			if ob[what].location=-1 then
				err(who,7,errors)
			else
				begin
				curcno:=curcno+1;
				if ob[what].location<>0 then
					wrtln(ob[who].connect,concat(places[ob[what].location].name,'.'))
				else
					if ob[ob[what].carries].mobile then
						begin
						wrst(ob[who].connect,'One carried by ');
						if ob[what].carries=who then
							wrtln(ob[who].connect,'you.')
						else
							begin
							shortname(ob[what].carries,who,false,false,false);
							wrtln(ob[who].connect,'.');
							end;
						end
					else
						begin
						wrst(ob[who].connect,'One inside ');
						shortname(ob[what].carries,who,false,false,false);
						wrtln(ob[who].connect,'.');
						end;
				if ob[what].mobile then
					wrtln(ob[what].connect,'You feel a strange tingling sensation.');
				end;
	end;

function forbidden(who,where : integer) : boolean;
	external;

function newname(name : in_buffer; persona : boolean) : boolean;
	external;

procedure call_object(who,what : integer; errors : boolean);

var incont	: boolean;

	begin
	incont:=false;
	if not(ob[what].mobile) and (ob[what].carries<>0) then
		begin		
		if not(ob[ob[what].carries].mobile) then
			incont:=true;
		end;
	if ob[what].mobile then
		err(who,6,errors)
	else
		if c_spell(who,6,(10+(3*(ob[what].value) div 4)),0,3,2,0)=0 then
			curstop:=true
		else
			if (ob[what].carries>0) and not(incont) then
				begin
				if errors then
					wrtln(ob[who].connect,'Someone is holding that.')
				end
			else
				if forbidden(who,ob[what].location) then
					begin
					if errors then
						wrtln(ob[who].connect,tdata[189]);
					end
				else
					begin
					if incont then
						lose(ob[what].carries,what,false,false);
					tellall(ob[what].location,0,'There is a loud pop!',false,true);
					act(what,'vanishes.',true,false);
					ob[what].location:=ob[who].location;
					tellall(ob[what].location,0,'There is a faint pop!',false,true);
					act(what,'appears.',true,false);
					curcno:=curcno+1;
					end;
	end;

procedure wake(whom : integer);

	begin
	wrtln(ob[whom].connect,'You are rudely awakened!');
	ob[whom].sleep:=false;
	destroy_event(1,whom);
	act(whom,'is woken!',true,false);
	end;

procedure zap(who,whom : integer; error,lb,mb : boolean);

var danger,cost,perc,class,lp	: integer;

	begin
	if mb then
		class:=4
	else
		class:=3;
	if lb then
		begin
		perc:=8;
		cost:=25;
		end
	else
		begin
		perc:=10;
		cost:=15;
		end;
	if ob[who].location<>ob[whom].location then
		err(who,7,error)
	else
		if (who=whom) or not(ob[whom].mobile) then
			begin
			if error then
				wrtln(ob[who].connect,'What''s the point of that, you berk!');
			end
		else
			if c_spell(who,perc,cost,0,class,0,0)<>0 then
				begin
				if lb then
					wrst(ob[who].connect,'You throw a bolt of lightning at ')
				else
					if mb then
						wrst(ob[who].connect,'You throw a bolt of mental energy at ')
					else
						wrst(ob[who].connect,'You throw a bolt of fire at ');
				shortname(whom,who,false,false,false);
				wrtln(ob[who].connect,'.');
				curcno:=curcno+1;
				if ob[whom].sleep then
					wake(whom);
				shortname(who,whom,true,false,true);
				if lb then
					begin
					wrtln(ob[whom].connect,' hurls a bolt of lightning at you!');
					doubleact(who,whom,'throws a bolt of lightning at',true,false,true);
					end
				else
					if mb then
						begin
						wrtln(ob[whom].connect,' hurls a bolt of mental energy at you!');
						doubleact(who,whom,'throws a bolt of mental energy at',true,false,true);
						end
					else
						begin
						wrtln(ob[whom].connect,' hurls a bolt of fire at you!');
						doubleact(who,whom,'throws a bolt of fire at',true,false,true);
						end;
				ob[whom].dislike:=who;
				if (f_level(whom)>11) and (f_level(who)<12) then
					if ob[whom].sc>819199 then
						act(whom,'stands and sneers at the feeble power used.',true,false)
					else
						wrtln(ob[who].connect,'Best not do that to Immortals. It offends them...')
				else
					begin
					danger:=f_level(who)*2+rnd(10);
					if lb then
						danger:=danger*2;
					if ob[whom].shield then danger:=danger-20;
					if mb then
						for lp:=1 to 20 do
							if (resisting[lp]=whom) then danger:=danger-20;
					for lp:=30 to no_ob do
						if not(ob[lp].mobile) then
							if ob[lp].carries=whom then
								if ob[lp].worn then
									danger:=danger-(ob[lp].armour DIV 2);
					if danger<=0 then
						begin
						wrtln(ob[whom].connect,'You are unharmed.');
						wrtln(ob[who].connect,'Your enemy is protected in some way and is unhurt.');
						end
					else
						begin
						danger:=ob[whom].con-danger;
						if danger<0 then
							if (ob[who].fighting=whom) or (ob[whom].fighting=who) then
								dead_dead(whom,who)
							else
								half_dead(whom,who)
						else
							begin
							ob[whom].con:=danger;
							stam_display(whom);
							end;
						end;
					end;
				end;
	end;

procedure sap(who,what : integer; errors : boolean);

var result : integer;

	begin
	if (who=what) or not(ob[what].mobile) then
		err(who,6,errors)
	else
		if ob[who].location<>ob[what].location then
			err(who,7,errors)
		else
			begin
			result:=c_spell(who,10,20,what,4,2,28);
			curcno:=curcno+1;
			if result=1 then
				begin
				wrtln(ob[what].connect,'You feel suddenly weaker!');
				act(what,'is weakened by the spell.',true,false);
				change_st(what,-(rnd(3)*f_level(who)+rnd(6*f_level(who))));
				end;
			if result=2 then
				begin
				shortname(what,who,true,false,false);
				wrtln(ob[who].connect,' resists your spell.');
				end;
			end;
	end;

procedure sleep_object(who,what : integer; errors : boolean);

var result : integer;

	begin
	if (who=what) or not(ob[what].mobile) then
		err(who,6,errors)
	else
		if ob[who].location<>ob[what].location then
			err(who,7,errors)
		else
			begin
			result:=c_spell(who,12,15,what,0,2,2);
			if result=1 then
				begin
				act(what,'slumps to the ground, asleep.',true,false);
				wrtln(ob[what].connect,'You are sent to sleep.');
				curcno:=curcno+1;
				ob[what].sleep:=true;
				set_event(1,what,0,2000+rnd(3500));
				end;
			if result=2 then
				begin
				wrtln(ob[who].connect,'Your spell rebounds!');
				act(who,'falls asleep.',true,false);
				curcno:=curcno+1;
				ob[who].sleep:=true;
				set_event(1,who,0,2000+rnd(2000));
				end;
			end;
	end;

procedure summon_object(who,what : integer; errors : boolean);

var temp	: integer;

	begin
	if not(ob[what].mobile) or (what=who) then
		err(who,6,errors)
	else
		begin
		temp:=c_spell(who,7,20+f_level(what),what,3,3,1);
		if temp=1 then
			if forbidden(who,ob[what].location) or (what=197) then
				begin
				shortname(what,who,true,false,false);
				wrtln(ob[who].connect,' cannot be summoned at the moment.');
				end
			else
				begin
				curcno:=curcno+1;
				wrtln(ob[what].connect,'You are summoned magically!');
				act(what,'vanishes abruptly.',true,false);
				stop_fight(what);
				ob[what].location:=ob[who].location;
				act(what,'appears suddenly.',true,false);
				look(what,true);
				end;
		if temp=2 then
			begin
			wrtln(ob[what].connect,'You feel a brief tugging sensation.');
			if rnd(2)=1 then
				begin
				shortname(what,who,true,false,false);
				wrtln(ob[who].connect,' resists your spell.');
				end
			else
				begin
				act(who,'falls to the ground, unconscious.',true,false);
				wrtln(ob[who].connect,'You fall into a momentary sleep.');
				ob[who].sleep:=true;
				set_event(1,who,0,2000+rnd(2000));
				curstop:=true;
				end;
			end;
		if temp=0 then
			curstop:=true;
		end;
	end;

procedure move_object(who,what,where : integer; errors : boolean);

var temp	: integer;

	begin
	if who=what then
		err(who,6,errors)
	else
		if ob[what].mobile then
			begin
			temp:=c_spell(who,5,20+(f_level(what)*2),what,3,3,3);
			if temp=0 then
				curstop:=true
			else
				if forbidden(who,where) then
					begin
					curstop:=true;
					wrtln(ob[who].connect,tdata[189]);
					temp:=0;
					end
				else
					if forbidden(who,ob[what].location) or (what=197) then
						begin
						shortname(what,who,true,false,false);
						wrtln(ob[who].connect,' cannot be moved at the moment.');
						temp:=0;
						end;
			if temp=2 then
				begin
				shortname(what,who,true,false,false);
				wrtln(ob[who].connect,' resists your spell.');
				wrtln(ob[what].connect,'You feel something pulling at you.');
				end;
			if temp=1 then
				begin
				curcno:=curcno+1;
				act(what,'is whisked away.',true,false);
				if ob[what].sleep then
					begin
					ob[what].sleep:=false;
					wrtln(ob[what].connect,'You are suddenly woken!');
					end;
				wrtln(ob[what].connect,'You are transported to a new location...');
				stop_fight(what);
				ob[what].location:=where;
				act(what,'appears here in a flash!',true,false);
				look(what,true);
				end;
			end
		else
			begin
			temp:=c_spell(who,5,20+(ob[what].value DIV 2),0,3,3,3);
			if temp=0 then
				curstop:=true
			else
				if forbidden(who,where) then
					begin
					curstop:=true;
					wrtln(ob[who].connect,tdata[189]);
					temp:=0;
					end
				else
					if forbidden(who,ob[what].location) or (what=197) then
						begin
						shortname(what,who,true,false,false);
						wrtln(ob[who].connect,' cannot be moved at the moment.');
						temp:=0;
						end;
			if temp=1 then
				if ob[what].carries>0 then
					begin
					if errors then
						wrtln(ob[who].connect,'Someone or something is carrying that.')
					end
				else
					begin
					act(what,'is whisked away.',true,false);
					ob[what].location:=where;
					act(what,'appears here in a flash!',true,false);
					curcno:=curcno+1;
					end;
				end;
	end;

procedure eat_object(who,what : integer; errors: boolean);

var temp	: integer;

	begin
	if (ob[who].location<>ob[what].location) and (ob[what].carries<>who) then
		err(who,7,errors)
	else
		if what=172 then
			begin
			dotext(ob[who].connect,133,134);
			act(who,'yells "Death before dishonour!"',false,true);
			act(who,'swallows the poison capsule.',true,false);
			dead(who);
			remove_object(172);
			curstop:=true;
			curcno:=1;
			end
		else
			if what=78 then
				wrtln(ob[who].connect,'The egg''s shell is hard stone. You succeed only in chipping a few teeth.')
			else
				if ((what<26) or (what>31)) and (what<>237) and (what<>238) { adjust for different foods } then
					err(who,6,errors)
				else
					begin
					wrst(ob[who].connect,'You eat ');
					shortname(what,who,false,false,false);
					wrtln(ob[who].connect,'. Delicious!');
					doubleact(who,what,'eats',true,false,true);
					if what<>237 then
						begin
						ob[who].thirsty:=ob[who].thirsty-(10+rnd(5));
						if ob[who].thirsty<0 then
							ob[who].thirsty:=0;
						end;
					curcno:=curcno+1;
					addlimit(ob[who].con,ob[who].max_con,10+rnd(25));
					change_st(who,15+rnd(30));
					stam_display(who);
					if what=31 then
						begin
						wrtln(ob[who].connect,'You are cured of any disease you may have.');
						ob[who].blind:=false;
						ob[who].crippled:=false;
						ob[who].deaf:=false;
						ob[who].dumb:=false;
						de_drunk(who,ob[who].drunk);
						if pandora_per=who then
							pandora_per:=0;
						end;
					if ob[what].carries=who then
						lose(who,what,true,false);
					remove_object(what);
				end;
	end;

procedure weigh_object(who,what : integer; errors : boolean);

	begin
	if ob[who].location<>real_loc(what) then
		err(who,7,errors)
	else
		begin
		fullname(what,who);
		wrst(ob[who].connect,'Weight : ');
		wrtint(ob[who].connect,weigh(what));
		wrtln(ob[who].connect,'.');
		curcno:=curcno+1;
		end;
	end;

procedure value_object(who,what : integer; errors : boolean);

	begin
	if ob[who].location<>real_loc(what) then
		err(who,7,errors)
	else
		begin
		fullname(what,who);
		curcno:=curcno+1;
		if not(ob[what].mobile) and ob[what].vorpal then
			wrtln(ob[who].connect,'(Vorpal weapon.)');
		wrst(ob[who].connect,'Value : ');
		if ob[what].mobile then
			if ob[what].sc>203799 then
				wrtln(ob[who].connect,'none (cannot be killed).')
			else	
				begin
				wrtint(ob[who].connect,mobile_value(what));
				wrtln(ob[who].connect,' if killed.');
				end
		else
			begin
			wrtint(ob[who].connect,ob[what].value);
			wrtln(ob[who].connect,'.');
			if ob[what].hit<>0 then
				begin
				wrst(ob[who].connect,'Hit strength : ');
				wrtint(ob[who].connect,ob[what].hit);
				wrtln(ob[who].connect,'.');
				end;
			if ob[what].slash<>0 then
				begin
				wrst(ob[who].connect,'Slash strength : ');
				wrtint(ob[who].connect,ob[what].slash);
				wrtln(ob[who].connect,'.');
				end;
			if ob[what].stab<>0 then
				begin
				wrst(ob[who].connect,'Lunge strength : ');
				wrtint(ob[who].connect,ob[what].stab);
				wrtln(ob[who].connect,'.');
				end;
			if ob[what].parry<>0 then
				begin
				wrst(ob[who].connect,'Parry value : ');
				wrtint(ob[who].connect,ob[what].parry);
				wrtln(ob[who].connect,'.');
				end;
			if ob[what].throw<>0 then
				begin
				wrst(ob[who].connect,'Throwing damage : ');
				wrtint(ob[who].connect,ob[what].throw);
				wrtln(ob[who].connect,'.');
				end;
			if ob[what].armour<>0 then
				begin
				wrst(ob[who].connect,'Armour value : ');
				wrtint(ob[who].connect,ob[what].armour);
				wrtln(ob[who].connect,'.');
				end;
			end;
		if f_level(who)>11 then
			begin
			wrst(ob[who].connect,'Object number ');
			wrtint(ob[who].connect,what);
			wrst(ob[who].connect,', description #');
			wrtint(ob[who].connect,ob[what].descr);
			wrst(ob[who].connect,', contdesc #');
			wrtint(ob[who].connect,ob[what].contdesc);
			wrtln(ob[who].connect,'.');
			end;
		end;
	end;

procedure armed(tellwho,who : integer);

	begin
	if (ob[who].weapon1=0) and (ob[who].weapon2=0) then
		wrtln(ob[tellwho].connect,'unarmed.')
	else
		begin
		wrst(ob[tellwho].connect,'armed with ');
		with ob[who] do
			begin
			if (weapon1<>0) and (weapon2=0) then
				begin
				shortname(weapon1,tellwho,false,false,tellwho<>who);
				if ob[weapon1].two_hand then
					wrtln(ob[tellwho].connect,' (double-handed).')
				else
					wrtln(ob[tellwho].connect,'.');
				end;
			if (weapon1=0) and (weapon2<>0) then
				begin
				shortname(weapon2,tellwho,false,false,tellwho<>who);
				wrtln(ob[tellwho].connect,' (in the left hand).');
				end;
			if (weapon1<>0) and (weapon2<>0) then
				begin
				shortname(weapon1,tellwho,false,false,tellwho<>who);
				wrst(ob[tellwho].connect,' and ');
				shortname(weapon2,tellwho,false,false,tellwho<>who);
				wrtln(ob[tellwho].connect,'.');
				end;
			end;
		end;
	end;

procedure select_weapon(who,what,offset : integer; errors : boolean);

var er_found : boolean;

	begin
	er_found:=false;
	if ob[what].carries<>who then
		err(who,8,errors)
	else
		begin
		if offset=2 then
			begin
			if (ob[who].weapon1<>0) then
				if ob[ob[who].weapon1].two_hand then
					begin
					wrtln(ob[who].connect,'Your existing weapon is double-handed.');
					er_found:=true;
					end;
			end;
		if (offset=2) and (ob[what].two_hand) then
			begin
			wrtln(ob[who].connect,'You can''t use that as your secondary weapon - it''s double-handed.');
			er_found:=true;
			end;
		if not(er_found) then
			begin
			if offset=1 then
				ob[who].weapon1:=what
			else
				ob[who].weapon2:=what;
			if ob[who].weapon1=ob[who].weapon2 then
				ob[who].weapon2:=0;
			if ob[who].weapon1<>0 then
				if ob[ob[who].weapon1].two_hand then
					ob[who].weapon2:=0;
			wrst(ob[who].connect,'You are ');
			armed(who,who);
			end;
		end;
	end;

procedure stop_follow;

	procedure remove_fol(number : integer);
	
	var lp	: integer;
	
		begin
		shortname(follows[number,1],follows[number,2],true,false,false);
		wrtln(ob[follows[number,2]].connect,' is no longer following you.');
		wrst(ob[follows[number,1]].connect,'You can no longer follow ');
		shortname(follows[number,2],follows[number,1],false,false,false);
		wrtln(ob[follows[number,1]].connect,'.');
		for lp:=number to no_fol-1 do
			follows[lp]:=follows[lp+1];
		no_fol:=no_fol-1;
		end;

var lp		: integer;
    found	: boolean;

	begin
	if stop_me then
		begin
		lp:=1;
		found:=false;
		while (lp<=no_fol) and not(found) do
			begin
			if follows[lp,1]=who then
				begin
				found:=true;
				remove_fol(lp);
				end;
			lp:=lp+1;
			end;
		end;
	if stop_them then
		repeat
		lp:=1;
		found:=false;
		while (lp<=no_fol) and not(found) do
			begin
			if follows[lp,2]=who then
				begin
				found:=true;
				remove_fol(lp);
				end;
			lp:=lp+1;
			end;
		until not(found);
	end;

procedure stop_fight;

var lp	: integer;

	begin
	for lp:=87 to no_ob do
		if ob[lp].location>0 then
			if ob[lp].mobile then
				if ob[lp].fighting=who then
					begin
					ob[lp].fighting:=0;
					if not(ob[lp].sleep) then
						begin
						wrst(ob[lp].connect,'You can no longer fight ');
						shortname(who,lp,false,false,true);
						wrtln(ob[lp].connect,'.');
						end;
					if lp=152 then
						begin
						{ Riddlemaster }
						act(152,'vanishes in a flash!',true,false);
						ob[152].location:=317;
						end;
					end;
	if ob[who].fighting<>0 then
		begin
		wrst(ob[who].connect,'You are no longer fighting ');
		shortname(ob[who].fighting,who,false,false,true);
		wrtln(ob[who].connect,'.');
		if (who=152) then
			begin
			act(152,'vanishes in a flash!',true,false);
			ob[152].location:=317;
			end;
		ob[who].fighting:=0;
		end;
	end;

procedure flee(who : integer);

	begin
	if (being_fought(who)>0) then
		begin
		act(who,'flees in panic, dropping everything.',true,false);
		dropall(who,false,false);
		wrtln(ob[who].connect,'You drop everything as you run from the fight.');
		temp:=share_point(who,(mobile_value(who)) div 6,false);
		score_point(who,-((mobile_value(who)) div 3));
		stop_fight(who);
		stop_follow(who,true,true);
		{ the scores of fleeing mobiles are reduced }
		if (ob[who].connect=0) and (ob[who].control=0) then
			ob[who].sc:=(ob[who].sc*ob[who].con) DIV ob[who].max_con;
		end;
	ob[who].fighting:=0;
	end;

procedure mobile_fight(who : integer);
	forward;

procedure remove_blow(which : integer);

var lp	: integer;

	begin
	if event[cur_b[which,4]].flag=which then
		remove_event(cur_b[which,4]);
	if which=blow_no then
		blow_no:=blow_no-1
	else
		if which<blow_no then
			begin
			for lp:=which to blow_no do
				begin
				cur_b[lp]:=cur_b[lp+1];
				event[cur_b[lp,4]].flag:=lp;
				end;
			blow_no:=blow_no-1;
			end;
	end;
	
procedure start_fight(who,whom : integer);

var newfight : boolean;
    lp : integer;

	begin
	if ob[whom].obey=who then ob[whom].obey:=0;
	if ob[who].obey=whom then ob[who].obey:=0;
	if peace then
		wrtln(ob[who].connect,'Fighting isn''t allowed at the moment.')
	else
		if (whom=198) or (whom=224) then
			begin
			tellall(ob[who].location,0,'ZAP! "Attacking government employees is an offence!"',false,false);
			act(who,'is struck dead for attacking a government employee!',true,false);
			dead(who);
			end
		else
			begin
			if not(ob[whom].sleep) then
				begin
				shortname(who,whom,true,false,true);
				wrst(ob[whom].connect,' starts to fight you, ');
				armed(whom,who);
				end;
			wrst(ob[who].connect,'You are now fighting ');
			shortname(whom,who,false,false,false);
			wrtln(ob[who].connect,'.');
			doubleact(who,whom,'starts to fight',true,false,true);
			ob[who].fighting:=whom;
			for lp:=1 to blow_no do
				if (cur_b[lp,1]=who) then
					remove_blow(lp);
			newfight:=(ob[whom].fighting=0);
			if newfight then
				begin
				ob[whom].fighting:=who;
				wrst(ob[whom].connect,'You are now fighting ');
				shortname(who,whom,false,false,false);
				wrtln(ob[whom].connect,'.');
				end;
			if (ob[who].control<>0) and (ob[whom].control<>0) then
				tellwiz(concat(ob[who].name,' has started to fight ',ob[whom].name,'.'));
			if ob[who].weapon1=209 then
				begin
				wrtln(ob[whom].connect,'The Hellsword leaps from your attacker''s hand and runs you through!');
				act(whom,'is slain by the Hellsword''s magical powers!',true,false);
				dead_dead(whom,who);
				end;
			if (ob[who].connect=0) and (who<>152) and (ob[who].fighting<>0) then
				mobile_fight(who);
			if (ob[whom].location<>-1) then
				if (ob[whom].connect=0) and (ob[whom].fighting<>0) then
					begin
					if newfight then
						mobile_fight(whom);
					ob[whom].dislike:=who;
					end;
			end;
	end;

procedure init_blow(who,b_type,wht_weapon : integer; where : body_range);

var at		: pm_range;
    temp,
    temp2,
    time,
    lp,
    find	: integer;

	begin
	if wht_weapon=2 then
		if ob[who].weapon1<>0 then
			if ob[ob[who].weapon1].two_hand then
				begin
				wrtln(ob[who].connect,'Your weapon is 2 handed, so we''ll use that.');
				wht_weapon:=1;
				end;
	if b_type=6 then
		begin
		{ a parry! }
		{ now, we know that bloke in question CAN parry - his 
		  weapon will stand it. So we check to see what his 
		  opponent's blow is like - }
		if wht_weapon=1 then
			temp:=ob[who].weapon1
		else
			temp:=ob[who].weapon2;
		temp2:=ob[temp].parry+ob[who].dex+(ob[who].st DIV 4)+rnd(40);
		{ the arguments FOR the parry succeeding - }
		lp:=ob[who].fighting;
		temp2:=temp2-(ob[lp].dex+(ob[lp].st div 4)+rnd(50));
		{ note the advantages given to a parry. This is cos 
		  it's so unlikely you'll get one in in the time 
		  - unless you have clever function keys...         }
		if temp2>0 then
			begin
			{ parry succeeded, now we have to find a blow }
			find:=1;
			while ((cur_b[find,1]<>lp) or (cur_b[find,2]<>where)) and (find<=blow_no) do
				find:=find+1;
			if find>blow_no then
				wrtln(ob[who].connect,'There''s no blow to parry!')
			else
				begin
				wrtln(ob[who].connect,'Your parry succeeds!');
				remove_blow(find);
				{ tell the other fella about it }
				shortname(who,lp,true,false,true);
				wrst(ob[lp].connect,' has parried your blow, with ');
				shortname(temp,lp,false,false,true);
				wrtln(ob[lp].connect,'.');
				{ if the other guy is a mobile, make him try again }
				if ob[lp].connect=0 then
					mobile_fight(lp);
				end;
			end
		else
			begin
			wrtln(ob[who].connect,'Your parry failed!');
			wrtln(ob[lp].connect,'Your opponent just tried to parry, but failed.');
			end;
		end
	else
		if (ob[who].fighting=91) and (where<>3) then
			wrtln(ob[who].connect,'It hasn''t got one!')
			{ non - humanoid mobile }
		else
			begin
			if wht_weapon=1 then
				temp:=ob[who].weapon1
			else
				if wht_weapon=2 then
					temp:=ob[who].weapon2
				else
					temp:=0; { feet }
			if not(ob[ob[who].fighting].sleep) then
				begin
				at:=ob[ob[who].fighting].connect;
				temp2:=rnd(8);
				if (who>=91) and (who<=93) then
					temp2:=8;
				wrst(at,fight[temp2]);
				shortname(who,ob[who].fighting,(temp2=8),false,true);
				send(at,' ');
				wrst(at,fight[8+rnd(2)]);
				wrst(at,' a ');
				wrst(at,fight[10+rnd(12)]);
				send(at,' ');
				wrst(at,fight[19+3*b_type+rnd(3)]);
				wrst(at,' at your ');
				wrst(at,fight[41+where*2+rnd(2)]);
				if temp=0 then
					wrtln(at,'.')
				else
					begin
					wrst(at,' with ');
					shortname(temp,ob[who].fighting,false,false,true);
					wrtln(at,'.');
					end;
				end;
			for lp:=1 to blow_no do
				if (cur_b[lp,1]=who) and ((cur_b[lp,3]=wht_weapon) or
				   (cur_b[lp,3]=3) or (wht_weapon=3)) then
					remove_blow(lp);
			if blow_no=63 then
				begin
				wrtln(ob[who].connect,'[ System Error - contact Ryke! ]');
				log('System runs out of blow space!');
				end
			else
				begin
				blow_no:=blow_no+1;
				cur_b[blow_no,1]:=who;
				cur_b[blow_no,2]:=where;
				cur_b[blow_no,3]:=wht_weapon;
				cur_b[blow_no,5]:=b_type;
				cur_b[blow_no,6]:=temp;
				{ now the clever bit... }
				if (temp<>0) and (temp<=no_ob) then
					temp2:=((weigh(temp)*6) div 7)-(ob[who].st div 8)
				else
					temp2:=20;
				time:=rnd(180)+70+temp2-(ob[who].dex DIV 5);
				if time<0 then
					time:=rnd(130)+40
				else
					time:=time+rnd(200)+50;
				set_event(3,blow_no,0,time*4);
				cur_b[blow_no,4]:=no_events;
				{ and the blow's initialised }
				end;
			end;
	end;

procedure mobile_move;

var lp,
    xit,
    temp		: integer;
 
	begin
	if ((mobile<122) or (mobile>124)) and (mobile<>153) and (mobile<>152)
	   and not((mobile>=194) and (mobile<=198)) then
		{ stationary mobiles... }
		begin
		lp:=1;
		xit:=0;
		while (xit=0) and (lp<5) do
			begin
			xit:=rnd(12);
			temp:=places[ob[mobile].location].value[xit];
			if temp=0 then
				xit:=0
			else
				if (temp>no_place) and (temp<>32766) and not((temp=32767) and ((mobile<90) or (ob[mobile].control<>0))) then
					xit:=0;
			{ special checks }
			if (temp=187) or (temp=168) or (temp=522) then
				xit:=0;
			if (mobile=117) and (temp=700) then
				xit:=0;
			if ((mobile=103) or (mobile=105)) and ((temp<220) or (temp>241)) then
				xit:=0;
			if (mobile=199) and (temp<633) then
				xit:=0;
			if (mobile=226) then
				if ob[mobile].location<>317 then
					begin
					xit:=0;
					stop_fight(226);
					act(226,'vanishes in a puff of smoke!',true,false);
					ob[226].location:=317;
					act(226,'appears in a puff of smoke!',true,false);
					end;
			if (ob[220].carries=222) and (mobile=222) then
				xit:=0;
			if mobile=225 then
				if ob[mobile].location=824 then
					xit:=0;
			lp:=lp+1;
			end;
		if xit<>0 then
		move(mobile,xit);
		end;
	end;

procedure disable(who,what,spell : integer);

	begin
	case spell of
		1,2:
			lp:=c_spell(who,5,10,what,0,0,4);
		3:
			lp:=c_spell(who,9,7,what,0,0,4);
		4:
			lp:=c_spell(who,8,7,what,0,0,4);
		end;
	if (lp>0) and forbidden(who,ob[what].location) then
		begin
		wrtln(ob[who].connect,tdata[189]);
		lp:=0;
		end;
	if lp=1 then
		temp:=what;
	if lp=2 then
		if rnd(2)=1 then
			begin
			wrtln(ob[who].connect,'The power you''ve invoked sends you to sleep.');
			act(who,'slumps to the ground, asleep.',true,false);
			ob[who].sleep:=true;
			set_event(1,who,0,2000+rnd(1300));
			temp:=0;
			end
		else
			begin
			wrst(ob[who].connect,'Your spell rebounds. ');
			temp:=who;
			end;
	if (lp<>0) and (temp<>0) then
		case spell of
			1:
				begin
				ob[temp].crippled:=true;
				wrtln(ob[temp].connect,'You are crippled!');
				end;
			2:
				begin
				ob[temp].blind:=true;
				wrtln(ob[temp].connect,'You are struck blind!');
				end;
			3:
				begin
				ob[temp].dumb:=true;
				wrtln(ob[temp].connect,'You are struck dumb!');
				end;
			4:
				begin
				ob[temp].deaf:=true;
				wrtln(ob[temp].connect,'You can no longer hear!');
				end;
			end;
	end;

procedure disench(who,temp : integer);

	begin
	if temp<>who then
		lp:=c_spell(who,6,14,temp,0,2,5)
	else
		lp:=c_spell(who,8,12,0,0,1,5);
	if (lp>0) and forbidden(who,ob[temp].location) then
		begin
		wrtln(ob[who].connect,tdata[189]);
		lp:=0;
		end;
	if lp=1 then
		begin
		with ob[temp] do
			begin
			wrtln(connect,'All minor enchantments on you have been lifted.');
			glowing:=false;
			crippled:=false;
			blind:=false;
			dumb:=false;
			deaf:=false;
			if (ob[who].class=4) or (f_level(who)>12) then
				begin
				shield:=false;
				cursed:=false;
				blessed:=false;
				if (f_level(who)>10) and (ob[temp].control>0) then
					begin
					people[ob[temp].control]^.blessed:=false;
					people[ob[temp].control]^.cursed:=false;
					end;
				end;
			if (ob[who].class=3) or (f_level(who)>12) then
				if invisible then
					begin
					invisible:=false;
					act(temp,'reappears.',true,false);
					end;
			end;
		end;
	if lp=2 then
		wrtln(ob[who].connect,'Your spell is resisted.');
	end;

procedure mobile_fight;

var where,
    whom,
    yourtot,
    mytot	: integer;
    staff	: boolean;

	begin
	whom:=ob[who].fighting;
	yourtot:=ob[whom].max_con+ob[whom].st+ob[whom].dex;
	mytot:=ob[who].max_con+ob[who].dex+ob[who].st;
	if not(ob[who].sleep) then
		begin
		staff:=false;
		if ob[114].carries=who then
			staff:=true;
		if ob[248].carries=who then
			staff:=true;
		if ((ob[who].con<(ob[who].max_con div 12)) or ((mytot+200)<(yourtot-rnd(60))))
                   and (rnd(7)>4) and not(ob[who].crippled) and not(ob[who].sc>204799) and (who<>225) and
		   (((who<122) or (who>124)) and (who<>100) and (who<>149) and (who<>194) and (who<>153) and (who<>195)) then
			{ time to flee! }
			begin
			flee(who);
			mobile_move(who);
			end
		else
			begin
			{ can we use a bit of magic }
			if ((ob[who].class>2) and (ob[who].magic>20)) or (staff and (ob[who].class<4)) and (rnd(3)=1) then
				begin
				{ let's throw a spell }
				staff:=false; { use this as temp boolean }
				if (ob[who].sc>3200) and (rnd(3)=1) then
					begin
					{ we can throw a classy spell with some chance of success }
					if ob[who].blind or ob[who].crippled then
						begin
						staff:=true;
						disench(who,who);
						end;
					if not(staff) and not(ob[whom].crippled) and (ob[who].sc>ob[whom].sc) and (rnd(2)=1) then
						begin
						staff:=true;
						disable(who,whom,1);
						end;
					if not(staff) and not(ob[whom].blind) and (ob[who].sc>ob[whom].sc) and (rnd(2)=1) then
						begin
						staff:=true;
						disable(who,whom,2);
						end;
					end;
				if not(staff) then
					if (rnd(3)<>1) or ob[whom].sleep then
						zap(who,whom,false,false,(ob[who].class=4))
					else
						if (ob[who].class=4) and (rnd(3)=1) then
							sap(who,whom,false)
						else
							sleep_object(who,whom,false);
				end;
			{ now start a blow, if he's still alive }
			if (ob[whom].location<>-1) and not(ob[who].sleep) then
				begin
				if (rnd(80)>ob[who].dex) or (whom=91) then
					where:=3 { clumsy mobiles do best to aim at middle }
				else
					where:=rnd(4);
				if ob[who].weapon1=0 then
					{ weaponless mobiles }
					if (who=92) or (who=93) then
						init_blow(who,5,1,where)
					else
						if ob[who].class=2 then
							if rnd(5)<3 then
								init_blow(who,7,3,where)
							else
								init_blow(who,1,1,where)
						else
							if rnd(3)=1 then
								init_blow(who,4,1,where)
							else
								init_blow(who,1,1,where)
				else
					with ob[ob[who].weapon1] do
						begin
						if (hit>slash) and (hit>stab) or (ob[who].class=4) then
							init_blow(who,1,1,where)
						else
							if slash>stab then
								init_blow(who,2,1,where)
							else
								init_blow(who,3,1,where);
						end;
				end
			else
				if (ob[whom].location=-1) and not(ob[who].sleep) then
					begin
					{ is there anyone else we should be fighting }
					mytot:=0;
					for whom:=87 to no_ob do
						if ob[whom].location<>-1 then
							if ob[whom].mobile then
								if (ob[whom].fighting=who) then
									mytot:=whom;
					if mytot<>0 then
						start_fight(who,mytot);
					end;
			end;
		end;
	end;

procedure do_blow(which : integer);

var who,
    enemy,
    temp,
    danger	: integer;
    cango,
    tryagain,
    passive	: boolean;
    gramst	: string[3];

	procedure desc_blow(who,enemy,damage,b_type,where : integer; caps,already : boolean);
	
	var adjective	: string[255];
	    temp	: integer;
	
		begin
		temp:=52+((damage*10) div 25);
		if temp<52 then temp:=52;
		if temp>87 then temp:=87;
		adjective:=concat(fight[temp],' ',fight[19+3*b_type+rnd(3)],' ');
		if rnd(2)=1 then
			begin
			{ decides whether it's "your X blow" or
			  "an X blow from you" }
			if caps then
				wrst(ob[who].connect,'Your ')
			else
				wrst(ob[who].connect,'your ');
			shortname(who,enemy,caps,false,true);
			wrst(ob[enemy].connect,'''s ');
			wrst(ob[enemy].connect,adjective);
			wrst(ob[who].connect,adjective);
			end
		else
			begin
			if caps then
				begin
				send(ob[who].connect,'A');
				send(ob[enemy].connect,'A');
				end
			else
				begin
				send(ob[who].connect,'a');
				send(ob[enemy].connect,'a');
				end;
			if adjective[1] IN ['a','e','i','o','u'] then
				begin
				wrst(ob[who].connect,'n ');
				wrst(ob[enemy].connect,'n ');
				end
			else
				begin
				send(ob[who].connect,' ');
				send(ob[enemy].connect,' ');
				end;
			wrst(ob[enemy].connect,adjective);
			wrst(ob[who].connect,adjective);
			wrst(ob[who].connect,'from you ');
			wrst(ob[enemy].connect,'from ');
			shortname(who,enemy,false,false,true);
			send(ob[enemy].connect,' ');
			end;
		wrst(ob[enemy].connect,'at your ');
		wrst(ob[who].connect,'at ');
		if already then
			if cant_see_obj(who,enemy) then
				wrst(ob[who].connect,'its ')
			else
				if ob[enemy].male then
					wrst(ob[who].connect,'his ')
				else
					wrst(ob[who].connect,'her ')
		else
			begin
			shortname(enemy,who,false,false,true);
			wrst(ob[who].connect,'''s ');
			end;
		wrst(ob[who].connect,fight[41+where*2+rnd(2)]);
		wrst(ob[enemy].connect,fight[41+where*2+rnd(2)]);
		end;

	begin
	{ first we check to see that everything's still the same }
	cango:=true;
	tryagain:=false;
	who:=cur_b[which,1];
	if ob[who].location<0 then
		cango:=false
	else
		begin
		enemy:=ob[who].fighting;
		if enemy=0 then
			cango:=false;
		if cur_b[which,3]=1 then
			begin
			if ob[who].weapon1<>cur_b[which,6] then
				begin
				cango:=false;
				tryagain:=true;
				end;
			end
		else
			if cur_b[which,3]=2 then
				if ob[who].weapon2<>cur_b[which,6] then
					begin
					cango:=false;
					tryagain:=true;
					end;
		if ob[who].sleep then cango:=false;
		end;
	if cango then
		begin
		{ all is still as it was... ok... }
		{ first we find out if the blow's missed & assign some
		  bonuses for hitting the head, etc }
		case cur_b[which,2] of
			1:
				begin
				{ the head }
				danger:=40;
				temp:=35;
				end;
			2:
				begin
				{ the chest }
				danger:=25;
				temp:=10;
				end;
			3:
				begin
				{ the middle }
				danger:=20;
				temp:=0;
				end;
			4:
				begin
				{ the legs }
				danger:=5;
				temp:=20;
				end;
			end;
		temp:=temp+ob[enemy].dex-(ob[who].dex+rnd(rnd(255)));
		if ob[enemy].invisible then temp:=temp+30;
		if ob[enemy].sleep then temp:=temp-50;
		if ob[enemy].crippled then temp:=temp-10;
		if ob[who].invisible then temp:=temp-20;
		if dark(ob[who].location,who) or blind_q(who) then temp:=temp+25;
		if blind_q(enemy) or dark(ob[enemy].location,enemy) then temp:=temp-20;
		if temp>10+rnd(35) then
			{ the blow missed ! }
			begin
			wrtln(ob[who].connect,'Your blow missed!');
			danger:=0;
			end
		else
			begin
			danger:=danger+(abs(temp) div 2)+ob[who].st+(ob[who].st div 15);
			if cur_b[which,6]<>0 then
				begin
				case cur_b[which,5] of
					 1:
					 	danger:=danger+ob[cur_b[which,6]].hit;
					 2:
					 	danger:=danger+ob[cur_b[which,6]].slash;
					 3:
					 	danger:=danger+ob[cur_b[which,6]].stab;
					 end;
				if ob[cur_b[which,6]].vorpal then
					danger:=danger+15+rnd(15);
				if ob[cur_b[which,6]].burns then
					danger:=danger+10+rnd(10);
				end;
			danger:=danger+rnd(40);
			if cur_b[which,3]=3 then danger:=danger+20;
			danger:=danger-(ob[enemy].st+rnd(60));
			if danger<0 then danger:=0;
			danger:=danger div 3;
			for temp:=30 to no_ob do
				if not(ob[temp].mobile) then
					if ob[temp].carries=enemy then
						if ob[temp].worn then
							danger:=danger-ob[temp].armour;
			if ob[enemy].shield then
				danger:=danger-30;
			if ob[enemy].weapon1>0 then
				danger:=danger-(ob[ob[enemy].weapon1].parry div 2);
			if ob[enemy].weapon2>0 then
				danger:=danger-(ob[ob[enemy].weapon2].parry div 2);
			if danger<0 then danger:=0;
			end;
		temp:=ob[enemy].con;
		if temp<2 then temp:=2;
		temp:=((danger * 17) div ((temp*4) div 3))+rnd(3);
		if temp>18 then
			temp:=18;
		if ob[enemy].sleep then
			wake(enemy);
		{ temp is now the blow to display. }
		passive:=(rnd(2)=1);
		if blows[temp].blow_sub then
			{ the blow is the subject. }
			if passive then
				begin
				wrst(ob[enemy].connect,'You are ');
				shortname(enemy,who,true,false,true);
				wrst(ob[who].connect,' is ');
				multiwrite(ob[who].connect,blows[temp].passive);
				multiwrite(ob[enemy].connect,blows[temp].passive);
				send(ob[who].connect,' ');
				send(ob[enemy].connect,' ');
				multiwrite(ob[who].connect,blows[temp].invariant);
				multiwrite(ob[enemy].connect,blows[temp].invariant);
				if blows[temp].invariant<>'' then
					begin
					send(ob[enemy].connect,' ');
					send(ob[who].connect,' ');
					end;
				wrst(ob[enemy].connect,'by ');
				wrst(ob[who].connect,'by ');
				desc_blow(who,enemy,danger,cur_b[which,5],cur_b[which,2],false,true);
				wrtln(ob[who].connect,'.');
				wrtln(ob[enemy].connect,'.');
				end
			else
				begin
				desc_blow(who,enemy,danger,cur_b[which,5],cur_b[which,2],true,false);
				send(ob[enemy].connect,' ');
				send(ob[who].connect,' ');
				multiwrite(ob[who].connect,blows[temp].active);
				if cant_see_obj(who,enemy) then
					wrst(ob[who].connect,'s it')
				else
					if ob[enemy].male then
						wrst(ob[who].connect,'s him')
					else
						wrst(ob[who].connect,'s her');
				multiwrite(ob[enemy].connect,blows[temp].active);
				wrst(ob[enemy].connect,'s you');
				if blows[temp].invariant<>'' then
					begin
					send(ob[enemy].connect,' ');
					send(ob[who].connect,' ');
					end;
				multiwrite(ob[who].connect,blows[temp].invariant);
				multiwrite(ob[enemy].connect,blows[temp].invariant);
				wrtln(ob[who].connect,'.');
				wrtln(ob[enemy].connect,'.');
				end
		else
			{ the bloke receiving is the subject }
			if passive then
				begin
				desc_blow(who,enemy,danger,cur_b[which,5],cur_b[which,2],true,false);
				wrst(ob[who].connect,' is ');
				wrst(ob[enemy].connect,' is ');
				multiwrite(ob[enemy].connect,blows[temp].passive);
				multiwrite(ob[who].connect,blows[temp].passive);
				if blows[temp].invariant<>'' then
					begin
					send(ob[enemy].connect,' ');
					send(ob[who].connect,' ');
					end;
				multiwrite(ob[who].connect,blows[temp].invariant);
				multiwrite(ob[enemy].connect,blows[temp].invariant);
				wrtln(ob[who].connect,'.');
				wrtln(ob[enemy].connect,' by you.');
				end
			else
				begin
				shortname(enemy,who,true,false,true);
				wrst(ob[enemy].connect,'You ');
				send(ob[who].connect,' ');
				multiwrite(ob[enemy].connect,blows[temp].active);
				multiwrite(ob[who].connect,blows[temp].active);
				wrst(ob[who].connect,'s');
				if blows[temp].invariant<>'' then
					begin
					send(ob[enemy].connect,' ');
					send(ob[who].connect,' ');
					end;
				multiwrite(ob[who].connect,blows[temp].invariant);
				multiwrite(ob[enemy].connect,blows[temp].invariant);
				send(ob[who].connect,' ');
				send(ob[enemy].connect,' ');
				desc_blow(who,enemy,danger,cur_b[which,5],cur_b[which,2],false,true);
				wrtln(ob[who].connect,'.');
				wrtln(ob[enemy].connect,'.');
				end;
		temp:=52+((danger*10) div 25);
		if temp<52 then temp:=52;
		if temp>87 then temp:=87;
		lp:=87+((25*danger) DIV ob[enemy].max_con)+rnd(2);
		if lp<88 then lp:=88;
		if lp>97 then lp:=97;
		if fight[temp,1] IN ['a','e','i','o','u'] then
			gramst:='n'
		else
			gramst:='';
		junk:=concat('is ',fight[lp],' by a',gramst,' ',fight[temp],' ',fight[19+3*cur_b[which,5]+rnd(3)],' from');
		doubleact(enemy,who,junk,true,false,true);
		if f_level(enemy)>11 then
			begin
			wrst(ob[who].connect,'Your blow goes straight through your opponent as if ');
			shortname(enemy,who,false,true,true);
			wrst(ob[who].connect,' wasn''t there! ');
			shortname(enemy,who,true,true,true);
			wrtln(ob[who].connect,' can''t be killed!');
			end
		else
			begin
			danger:=ob[enemy].con-danger;
			if danger<0 then
				dead_dead(enemy,who)
			else
				begin
				ob[enemy].con:=danger;
				stam_display(enemy);
				end;
			end;
		{ we knock off some strength from the attacker for his weapon }
		temp:=rnd(2)-1;
		if cur_b[which,6]<>0 then
			temp:=temp+(ob[cur_b[which,6]].weight DIV 30);
		change_st(who,-temp);
		end;
	{ and remove the blow from the lists }
	remove_blow(which);
	if ob[who].location<>-1 then
		begin
		danger:=10000;
		temp:=0;
		if (ob[who].connect=0) and not(ob[who].sleep) then
			begin
			{ we now need to check who next to attack }
			for enemy:=87 to no_ob do
				if ob[enemy].location<>-1 then
					if ob[enemy].mobile then
						if (ob[enemy].fighting=who) or (ob[who].fighting=enemy) then
							if ((ob[enemy].con+ob[enemy].dex+ob[enemy].st)<danger) then
								begin
								temp:=enemy;
								danger:=ob[enemy].con+ob[enemy].dex+ob[enemy].st;
								end;
			if temp<>0 then
				if ob[who].fighting=temp then
					mobile_fight(who)
				else
					start_fight(who,temp);
			end;
		end;
	end;

function extract_loc(from : com_element) : integer;

var room	: integer;
    str		: str255;

	begin
	case from.which of
		2:
			extract_loc:=real_loc(from.object);
		4:
			if from.number<=no_place then
				extract_loc:=from.number
			else
				extract_loc:=0;
		5:
			begin
			str:=from.quoted;
			lower(str);
			room:=1;
			while (not lcompare(places[room].name,str)) and (room<=no_place) do
				room:=room+1;
			if room>no_place then room:=0;
			extract_loc:=room;
			end;
		8:
			if (virtuals[from.virtual].howmany=1) and (virtuals[from.virtual].rooms[1,2]=1) then
				extract_loc:=vlocs[virtuals[from.virtual].rooms[1,1]]
			else
				extract_loc:=0;
		otherwise
			extract_loc:=0;
		end;
	end;

function cant_extract(who : integer; var from : com_element) : boolean;

{ converts a category into a single object, the first one fitting the
  name in the location. }

var found	: integer;
  
	begin
	if from.which=3 then
		begin
		init_categ(from.category);
		found:=-1;
		while doingcat do
			if (ob[curob].location=ob[who].location) or (ob[curob].carries=who) then
				begin
				found:=curob;
				curstop:=true;
				end;
		if found<>-1 then
			begin
			from.which:=2;
			from.object:=found;
			end;
		end;
	cant_extract:=from.which<>2;
	end;

procedure hit_object(who,what,vrb : integer; error : boolean);

var danger	: integer;

	begin
	with ob[who] do
		begin
		if ((what=32) or (what=203)) and ((location=591) or (location=592)) and mirror then
			begin
			wrtln(connect,'You strike the mirror sharply and it shatters. Oops - 7 years bad luck!');
			cursed:=true;
			mirror:=false;
			curcno:=curcno+1;
			end
		else
			if ob[what].location<>location then
				err(who,7,error)
			else
				if (ob[what].mobile) and (what<>who) then
					begin
					wrst(connect,'You ');
					wrst(connect,verb[vrb]);
					send(connect,' ');
					curcno:=curcno+1;
					shortname(what,who,false,false,false);
					wrtln(connect,'.');
					if ((fighting=what) or (ob[what].fighting=who)) and not(ob[what].sleep) then
						begin
						doubleact(who,what,concat('tries to ',verb[vrb]),true,false,true);
						shortname(what,who,true,false,false);
						wrtln(connect,' dodges your clumsy blow!');
						shortname(who,what,true,false,true);
						wrtln(ob[what].connect,concat(' tries to ',verb[vrb],' you, but you dodge.'));
						end
					else
						begin
						if vrb=161 then
							doubleact(who,what,'punches',true,false,true)
						else
							doubleact(who,what,concat(verb[vrb],'s'),true,false,true);
						if ob[what].sleep then
							wake(what);
						shortname(who,what,true,false,true);
						if vrb=161 then
							wrtln(ob[what].connect,' punches you painfully!')
						else
							wrtln(ob[what].connect,concat(' ',verb[vrb],'s you painfully!'));
						ob[what].dislike:=who;
						if (f_level(what)>11) and (f_level(who)<12) then
							wrtln(connect,'Don''t hit Immortals - it shortens your life expectancy!')
						else
							begin
							danger:=(st div 128)+rnd(2);
							danger:=ob[what].con-danger;
							if danger<0 then
								half_dead(what,who)
							else
								begin
								ob[what].con:=danger;
								stam_display(what);
								end;
							end;
						end;
					end
				else
					err(who,6,error);
		end;
	end;

procedure tell_res_time(whom : player_range);

	begin
	wrst(whom,'Next auto reset at ');
	wrtint(whom,r_h);
	send(whom,':');
	wrtint(whom,r_m);
	wrtln(whom,'.');
	end;

procedure slashed(who,no_com : integer; txt : str255; parameter : com_element);

var ofwhom : integer;

	begin
	with ob[who] do
		begin
		txt[1]:=tolower(txt[1]);
		case txt[1] of
			'w':
				if no_com=1 then
					begin
					wrst(connect,'Current width is ');
					wrtint(connect,people[position[connect,5]]^.width);
					wrtln(connect,'.');
					end
				else
					if (no_com<>2) or (parameter.which<>4) or (parameter.number<20) or (parameter.number>200) then
						wrtln(connect,'Invalid.')
					else
						people[position[connect,5]]^.width:=parameter.number;
			't':
				begin
				show_time(connect,gettime);
				cr(connect);
				end;
			'd':
				begin
				show_date(connect,gettime);
				cr(connect);
				end;
			'r':
				tell_res_time(connect);
			'p':
				if (no_com<>2) or (parameter.which<>5) then
					wrtln(connect,'Invalid.')
				else begin
					password_crypt(parameter.quoted);
					people[position[connect,5]]^.passw:=parameter.quoted;
				end;
			'h':
				begin
				wrtln(connect,'Low level system commands are:');
				cr(connect);
				wrtln(connect,'/a       - display account details.');
				wrtln(connect,'/d       - show system date.');
				wrtln(connect,'/e       - toggle host/program echo.');
				wrtln(connect,'/h       - get this message.');
				wrtln(connect,'/p "str" - change password.');
				wrtln(connect,'/r       - show reset time.');
				wrtln(connect,'/t       - show current system time.');
				wrtln(connect,'/w (<w>) - change/show screen width.');
				wrtln(connect,'CTRL - S - pause text output.');
				wrtln(connect,'CTRL - Q - resume text output.');
				wrtln(connect,'CTRL - R - reprint typed text.');
				wrtln(connect,'CTRL - U - delete typed line.');
				wrtln(connect,'(Control codes only work on a TTY-type connection.)');
				end;
			'a':
				begin
				if (no_com=1) or (parameter.which<>2) then
					ofwhom:=position[connect,5]
				else
					if f_level(who)>11 then
						if ob[parameter.object].mobile and (ob[parameter.object].control<>0) then
							ofwhom:=ob[parameter.object].control
						else
							begin
							ofwhom:=-1;
							wrtln(connect,'That object hasn''t got an account.');
							end
					else
						begin
						ofwhom:=-1;
						err(who,9,true);
						end;
				if ofwhom>0 then
					begin
					wrtln(connect,people[ofwhom]^.name);
					if people[ofwhom]^.compunet then
						wrtln(connect,'Created on a current Realm version.')
					else
						begin
						if not(people[ofwhom]^.registered) then
							wrst(connect,'Non-');
						wrtln(connect,'Registered user.');
						if (people[ofwhom]^.expire=0) then
							wrtln(connect,'Permanent account.')
						else
							begin
							wrst(connect,'Account expires on ');
							show_date(connect,people[ofwhom]^.expire);
							wrtln(connect,'.');
							end;
						end;
					wrst(connect,'Logged on at ');
					show_time(connect,people[ofwhom]^.last_on);
					wrst(connect,' on ');
					show_date(connect,people[ofwhom]^.last_on);
					wrtln(connect,'.');
					wrst(connect,'Has played ');
					wrtint(connect,people[ofwhom]^.times);
					wrst(connect,' times before and has spent ');
					wrtint(connect,people[ofwhom]^.minutes);
					wrtln(connect,' minutes on the system.');
					if people[ofwhom]^.voted>0 then
						begin
						wrst(connect,'May next vote on ');
						show_date(connect,people[ofwhom]^.voted);
						wrtln(connect,'.');
						end;
					end;
				end;
			'e':
				{ toggle echo method }
				if position[connect,15]=1 then
					begin
					wrtln(connect,'Using program echo.');
					position[connect,15]:=0;
					end
				else
					begin
					position[connect,15]:=1;
					wrtln(connect,'Using host echo.');
					end;
			otherwise
				wrtln(connect,'Interpreter doesn''t know this slash command.');
			end;
		end;
	end;

procedure strike_a_blow(who : integer);

	begin
	with ob[who] do
		begin
		if no_com=2 then
			if (commands[2].which<>1) or (commands[2].vb<22) or (commands[2].vb>25) then
				begin
				temp:=0;
				interr(who,0);
				end
			else
				begin
				temp:=commands[2].vb;
				lp:=1;
				end;
		if no_com=3 then
			if ((commands[3].which<>1) or 
			   (commands[3].vb<22) or (commands[3].vb>25) or 
			   (commands[2].which<>4) or 
			   ((commands[2].number<>2) and (commands[2].number<>3))) then
				begin
				temp:=0;
				interr(who,0);
				end
			else
				begin
				temp:=commands[3].vb;
				lp:=commands[2].number;
				end;
		if (no_com<>2) and (no_com<>3) then
			begin
			temp:=0;
			interr(who,1);
			end;
		if temp<>0 then
			if fighting=0 then
				wrtln(connect,'You''re not fighting anyone!')
			else
				case commands[1].vb of
					19:
						if lp=3 then
							if class<>2 then
								wrtln(connect,'Only Rangers can use ST 3.')
							else
								init_blow(who,7,3,temp-21)
						else
							init_blow(who,1,lp,temp-21);
					18:
						begin
						if lp=1 then
							if weapon1=0 then
								begin
								wrtln(connect,'You''re not armed!');
								temp:=0;
								end
							else
								if ob[weapon1].slash=0 then
									begin
									wrtln(connect,'Not with that you can''t.');
									temp:=0;
									end;
						if lp=2 then
							if weapon2=0 then
								begin
								wrtln(connect,'You''re not armed!');
								temp:=0;
								end
							else
								if ob[weapon2].slash=0 then
									begin
									wrtln(connect,'Not with that you can''t.');
									temp:=0;
									end;
						if class=4 then
							begin
							wrtln(ob[who].connect,'You can''t use an edged weapon, being a priest.');
							temp:=0;
							end;
						if lp=3 then
							begin
							wrtln(ob[who].connect,'Only ST(rike) allowed with feet.');
							temp:=0;
							end;
						if temp<>0 then
							init_blow(who,2,lp,temp-21);
						end;
					20:
						begin
						if lp=1 then
							if weapon1=0 then
								begin
								wrtln(connect,'You''re not armed!');
								temp:=0;
								end
							else
								if ob[weapon1].stab=0 then
									begin
									wrtln(connect,'Not with that you can''t.');
									temp:=0;
									end;
						if lp=2 then
							if weapon2=0 then
								begin
								wrtln(connect,'You''re not armed!');
								temp:=0;
								end
							else
								if ob[weapon2].stab=0 then
									begin
									wrtln(connect,'Not with that you can''t.');
									temp:=0;
									end;
						if class=4 then
							begin
							wrtln(ob[who].connect,'You can''t use an edged weapon, being a priest.');
							temp:=0;
							end;
						if lp=3 then
							begin
							wrtln(ob[who].connect,'Only ST(rike) allowed with feet.');
							temp:=0;
							end;
						if temp<>0 then
							init_blow(who,3,lp,temp-21);
						END;
					21:
						begin
						if lp=1 then
							if weapon1=0 then
								begin
								wrtln(connect,'You''re not armed!');
								temp:=0;
								end
							else
								if ob[weapon1].parry=0 then
									begin
									wrtln(connect,'Not with that you can''t.');
									temp:=0;
									end;
						if lp=2 then
							if weapon2=0 then
								begin
								wrtln(connect,'You''re not armed!');
								temp:=0;
								end
							else
								if ob[weapon2].parry=0 then
									begin
									wrtln(connect,'Not with that you can''t.');
									temp:=0;
									end;
						if lp=3 then
							begin
							wrtln(ob[who].connect,'Only ST(rike) allowed with feet.');
							temp:=0;
							end;
						if temp<>0 then
							init_blow(who,6,lp,temp-21);
						end;
					end;
		end;
	end;

procedure plant_something(who : integer);

	begin
	if (no_com<>2) or (commands[2].which<>2) then
		interr(who,4)
	else
		if ob[commands[2].object].carries<>who then
			err(who,8,true)
		else
			if ob[who].location<>78 then
				wrtln(ob[who].connect,'Nothing will grow here.')
			else
				if (commands[2].object<16) or (commands[2].object>30) or ((commands[2].object>19) and (commands[2].object<26)) then
					wrtln(ob[who].connect,'Be serious!')
				else
					begin
					doubleact(who,commands[2].object,'plants',true,false,false);
					if commands[2].object<>19 then
						begin
						dotext(ob[who].connect,66,67);
						lose(who,commands[2].object,false,false);
						remove_object(commands[2].object);
						end
					else
						begin
						dotext(ob[who].connect,40,42);
						lose(who,19,false,false);
						remove_object(19);
						if ob[20].location=123 then
							ob[20].location:=78;
						if ob[21].location=123 then
							ob[21].location:=78;
						end;
					end;
	end;

procedure poss_spell(who : integer);

var lp : integer;

	begin
	if (no_com<>2) or cant_extract(who,commands[2]) then
		interr(who,3)
	else
		if ob[commands[2].object].mobile and (commands[2].object<>who) and
		   ((being_fought(commands[2].object)=0) or (f_level(who)>12)) then
			begin
			temp:=c_spell(who,1,60,commands[2].object,0,5,6);
			if (temp=2) or ob[commands[2].object].possessed or (ob[commands[2].object].control=1)
			   or ob[who].possessed or ob[commands[2].object].sleep or (ob[who].connect=0) or 
			   forbidden(who,ob[commands[2].object].location) then
				begin
				wrtln(ob[who].connect,'You are thrown into a deep sleep.');
				act(who,'falls asleep!',true,false);
				wrtln(ob[commands[2].object].connect,'Something is groping in your mind!');
				ob[who].sleep:=true;
				set_event(1,who,0,3000+rnd(4000));
				end
			else
				if temp<>0 then
					begin
					for lp:=1 to top do
						if position[lp,9]=ob[who].connect then
							position[lp,9]:=0;
					act(who,'goes into a trance.',true,false);
					if ob[commands[2].object].connect<>0 then
						if position[ob[commands[2].object].connect,8]<>0 then
							dispossess(ob[commands[2].object].connect);
					ob[commands[2].object].possessed:=true;
					stop_follow(who,true,false);
					position[ob[who].connect,8]:=commands[2].object;
					position[ob[who].connect,7]:=ob[commands[2].object].connect;
					wrtln(ob[commands[2].object].connect,'You are possessed!');
					ob[commands[2].object].connect:=ob[who].connect;
					end;
			end
		else
			wrtln(ob[who].connect,'You cannot Possess that!');
	end;

procedure explode_sp(who : integer);

	begin
	if (no_com<>2) or cant_extract(who,commands[2]) then
		interr(who,3)
	else
		if ob[commands[2].object].mobile then
			if ob[commands[2].object].location=ob[who].location then
				begin
				temp:=c_spell(who,2,40,commands[2].object,3,4,7);
				if temp=1 then
					lp:=commands[2].object;
				if (temp=2) then
					lp:=who;
				if temp<>0 then
					begin
					act(lp,'explodes in a burst of purple flames.',true,false);
					wrtln(ob[lp].connect,'You are enveloped in a fireball of magical purple flames...');
					dead(lp);
					end;
				end
			else
				err(who,7,true)
		else
			interr(who,8);
	end;

procedure prison_sp(who : integer);

	begin
	if (no_com<>2) or cant_extract(who,commands[2]) then
		interr(who,3)
	else
		if ob[commands[2].object].mobile then
			begin
			temp:=c_spell(who,1,50,commands[2].object,0,5,8);
			if (temp>0) and forbidden(who,ob[commands[2].object].location) then
				begin
				wrtln(ob[who].connect,tdata[189]);
				temp:=0;
				end;
			if temp=1 then
				lp:=commands[2].object;
			if temp=2 then
				lp:=who;
			if temp<>0 then
				begin
				act(lp,'is snatched away.',true,false);
				wrtln(ob[lp].connect,'You are dragged off to the Wizard''s Dungeon for your sins.');
				stop_fight(lp);
				ob[lp].location:=125;
				log(concat(ob[who].name,' throws ',ob[lp].name,' into prison.'));
				look(lp,true);
				end;
			end
		else
			interr(who,8);
	end;

procedure move_sp(who : integer);

var lp	: integer;

	begin
	if (no_com<>3) or ((commands[2].which<>2) and (commands[2].which<>3)) then
		interr(who,2)
	else
		begin
		lp:=extract_loc(commands[3]);
		if lp=0 then
			interr(who,5)
		else
			if commands[2].which=2 then
				move_object(who,commands[2].object,lp,true)
			else
				begin
				init_categ(commands[2].category);
				while doingcat do
					move_object(who,curob,lp,false);
				wrtint(ob[who].connect,curcno);
				wrtln(ob[who].connect,' object(s) were affected by your spell.');
				end;
		end;
	end;

procedure select_sb(who : integer);

var lp,temp : integer;

	begin
	temp:=0;
	if no_com=3 then
		if (commands[2].which<>4) or (commands[2].number<>2) or cant_extract(who,commands[3]) then
			interr(who,0)
		else
			begin
			temp:=commands[3].object;
			lp:=2;
			end
	else
		if no_com=2 then
			if cant_extract(who,commands[2]) then
				interr(who,0)
			else
				begin
				temp:=commands[2].object;
				lp:=1;
				end
		else
			begin
			wrst(ob[who].connect,'You are ');
			armed(who,who);
			end;
	if temp<>0 then
		select_weapon(who,temp,lp,true);
	end;

procedure kill_somet(who : integer);

	begin
	if (no_com<>2) or cant_extract(who,commands[2]) then
		interr(who,3)
	else
		if ob[commands[2].object].location<>ob[who].location then
			err(who,7,true)
		else
			if not(ob[commands[2].object].mobile) then
				err(who,6,true)
			else
				if commands[2].object=who then
					wrtln(ob[who].connect,'If you want to leave the game, try QUIT.')
				else
					if ob[who].possessed then
						if f_level(who_possesses(who))<13 then
							wrtln(ob[who].connect,'You can''t start a fight while possessing.')
						else
							start_fight(who,commands[2].object)
					else
						start_fight(who,commands[2].object);
	end;

procedure flee_sw(who : integer);

	begin
	if (no_com<>2) or (commands[2].which<>1) or (commands[2].vb>12) then
		interr(who,2)
	else
		begin
		if (being_fought(who)=0) then
			wrtln(ob[who].connect,'Nobody''s fighting you!')
		else
			if ob[who].crippled then
				wrtln(ob[who].connect,'You can''t move!')
			else
				begin
				flee(who);
				move(who,commands[2].vb);
				end;
		end;
	end;

procedure eat_something(who : integer);

	begin
	if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
		scenerr(who,3,2,commands[2])
	else
		if commands[2].which=2 then
			eat_object(who,commands[2].object,true)
		else
			begin
			init_categ(commands[2].category);
			while doingcat do
				eat_object(who,curob,false);
			if curcno=0 then
				wrtln(ob[who].connect,'Nothing eaten.');
			end;
	end;

procedure pull_something(who : integer);

var moved	: boolean;
    lp		: integer;

	begin
	{ ignore all parameters }
	moved:=false;
	if ob[who].location=170 then
		if lever1 then
			wrtln(ob[who].connect,'It won''t budge any further.')
		else
			begin
			wrtln(ob[who].connect,'Creaaak!');
			lever1:=true;
			leverp1:=who;
			moved:=true;
			end;
	if ob[who].location=197 then
		if lever2 then
			wrtln(ob[who].connect,'It won''t budge any further.')
		else
			begin
			wrtln(ob[who].connect,'Creaaak!');
			lever2:=true;
			leverp2:=who;
			moved:=true;
			end;
	if (ob[who].location=170) or (ob[who].location=197) then
		begin
		if moved then
			begin
			wrtln(ob[who].connect,tdata[43]);
			act(who,'pulls the lever.',true,false);
			if lever1 and lever2 then
				begin
				if doors[6].open then
					tellall(ob[who].location,0,'Nothing happens.',false,false)
				else
					begin
					doors[6].open:=true;
					dsall(6);
					tellall(170,0,'There is a distant clash of metal. You can move again!',false,true);
					tellall(197,0,'There is a distant clash of metal. You are free!',false,true);
					end;
				leverp1:=0;
				leverp2:=0;
				end;
			end;
		end
	else
		if ob[who].location<>509 then
			wrtln(ob[who].connect,'There''s nothing to pull here.')
		else
			begin
			act(who,'pulls the rope.',true,false);
			for lp:=87 to no_ob do
				if ob[lp].mobile and not(ob[lp].deaf) and not(ob[lp].sleep) then
					if (ob[lp].location>500) and (ob[lp].location<547) then
						wrtln(ob[lp].connect,'A bell tolls, not far away.'); 
			if kobolds_bl then
				begin
				kobolds_bl:=false;
				score_point(who,25);
				end;
			end;
	end;

procedure ring_something(who : integer);

	begin
	if (no_com<>2) or (commands[2].which<>2) then
		interr(who,4)
	else
		if ob[commands[2].object].carries<>who then
			err(who,8,true)
		else
			if commands[2].object<>113 then
				wrtln(ob[who].connect,'You can''t get that to ring.')
			else
				begin
				act(who,'rings the bell.',false,true);
				act(113,'gives off a low, reverberating, mournful tone.',false,true);
				{ the ghost }
				if ob[105].location=ob[who].location then
					if ((ob[54].carries=who) or (ob[45].carries=who)) and (ob[116].carries=who) then
						begin
						wrtln(ob[who].connect,'With bell, book and candle you exorcise the ghost, which vanishes.');
						score_point(who,300);
						act(who,'exorcises the ghost with bell, book and candle.',true,false);
						remove_object(105);
						end;
				{ the splinter }
				if (ob[who].location=141) and (ob[38].location=123) then
					begin
					tellall(ob[who].location,0,tdata[62],true,false);
					ob[38].location:=141;
					end;
				end;
	end;

function burn_with(who,wherewith : integer) : integer;

var find,
    mit		: integer;

	begin
	mit:=0;
	for find:=1 to no_ob do
		if not(ob[find].mobile) then
			if find<>wherewith then
				if ob[find].carries=who then
					if ob[find].burns then
						{ Eureka ! }
						mit:=find;
	burn_with:=mit;
	end;

procedure burn_object(who,what : integer; errors : boolean);

var find,
    mit,
    emerge,
    danger	: integer;
    heldit,
    toldthem	: boolean;

	begin
	mit:=burn_with(who,what);
	if (mit<>0) or (ob[who].location=624) or (ob[who].location=566) or (ob[who].location=840) then
		if (ob[what].flammable or ob[what].mobile or ob[what].extinguish) and (what<>who) then
			if (ob[what].location=ob[who].location) or (ob[what].carries=who) then
				begin
				curcno:=curcno+1;
				{ we can burn it }
				if ob[what].mobile then
					begin
					doubleact(who,what,'burns',true,false,true);
					if (ob[who].fighting=what) or (ob[what].fighting=who) then
						begin
						shortname(what,who,true,false,false);
						wrtln(ob[who].connect,' dodges your foolish attempt at pyromania!');
						shortname(who,what,true,false,true);
						wrtln(ob[what].connect,' tries to burn you, but fails miserably.');
						end
					else
						begin
						wrst(ob[who].connect,'You burn ');
						shortname(what,who,false,false,false);
						wrtln(ob[who].connect,'.');
						shortname(who,what,true,false,true);
						if mit<>0 then
							begin
							wrst(ob[what].connect,' gives you a nasty burn with ');
							shortname(mit,what,false,false,true);
							wrtln(ob[what].connect,'!');
							end
						else
							wrst(ob[what].connect,'gives you a nasty burn by pushing you on the fire.');
						ob[what].dislike:=who;
						if ob[what].sc>204799 then
							wrtln(ob[who].connect,'Don''t burn Immortals - it shortens your life expectancy!')
						else
							begin
							danger:=2+rnd(3);
							danger:=ob[what].con-danger;
							if danger<0 then
								half_dead(what,who)
							else
								begin
								ob[what].con:=danger;
								stam_display(what);
								end;
							end;
						end;
					end
				else
					begin
					doubleact(who,what,'sets light to',true,false,true);
					if ob[what].extinguish then
						begin
						ob[what].light:=true;
						ob[what].burns:=true;
						wrst(ob[who].connect,'You light ');
						shortname(what,who,false,false,false);
						wrtln(ob[who].connect,'.');
						end
					else
						begin
						toldthem:=false;
						heldit:=false;
						if ob[what].carries=who then
							begin
							lose(who,what,true,false);
							heldit:=true;
							end;
						if (what=77) and (ob[36].location=123) then
							begin
							act(77,'burns well, giving off much heat.',true,false);
							toldthem:=true;
							ob[36].location:=ob[who].location;
							if ob[who].location=138 then
								begin
								tellall(138,0,'A huge hole has been melted in the ice. SOMETHING is emerging...',true,false);
								if (ob[100].location=123) and not(peace) then
									begin
									stop_fight(100);
									ob[100].location:=138;
									start_fight(100,who);
									ice_melt:=true;
									end;
								end;
							if ob[who].location=134 then
								begin
								emerge:=41;
								if rnd(2)=1 then emerge:=39;
								if ob[59].carries=who then
									emerge:=39;
								if ob[emerge].location=123 then
									begin
									ob[emerge].location:=134;
									act(emerge,'is freed from the ice!',true,false);
									end;
								water_f:=true;
								end;
							end;
						if (what=74) then
							begin
							tellall(ob[who].location,0,'BOOM! There is a trememdous explosion!',false,false);
							toldthem:=true;
							if (ob[who].location=358) then
								begin
								tellall(358,0,'As the smoke clears you see a hole has been blown in the tower wall.',true,false);
								wall_hole:=true;
								end;
							if heldit then
								begin
								wrtln(ob[who].connect,'Unfortunately you were holding the gunpower; you were blown to Kingdom Come!');
								act(who,'has blown himself to bits with the gunpowder!',true,false);
								dead(who);
								curstop:=true;
								end;
							end;
						if (what=215) then
							begin
							act(what,'gives off a heavy sweet perfume as it burns.',true,false);
							toldthem:=true;
							if (ob[who].location>=787) and (ob[who].location<=790) then
								begin
								tellall(ob[who].location,0,'The fumes of the acid lake are dispelled.',true,false);
								acidlake:=0;
								end;
							end;
						if not(toldthem) then
							act(what,'burns quickly to ashes.',true,false);
						remove_object(what);
						if (ob[who].location=-1) or (ob[mit].location=-1) then
							curstop:=true;
						end;
					end;
				end
			else
				err(who,7,errors)
		else
			err(who,6,errors)
	else
		err(who,10,errors);
	end;

procedure burn_something(who : integer);

var virt	: integer;

	begin
	if (no_com=2) and (commands[2].which=8) then
		if burn_with(who,0)=0 then
			err(who,10,true)
		else
			begin
			virt:=find_virtual(commands[2].virtual,ob[who].location);
			if virt=0 then
				err(who,7,true)
			else
				case commands[2].virtual of
					6:
						if virt=2 then
							begin
							act(who,'sets light to the oily grass.',true,false);
							tellall(794,0,'The oily grass burns away with a foul black smoke.',true,false);
							if not(grassburn) and (ob[204].location=123) then
								begin
								ob[204].location:=794;
								tellall(794,0,'A large steel helm can be seen lying in the grass where it was hidden.',true,false);
								grassburn:=true;
								end;
							end
						else
							wrtln(ob[who].connect,'The grass is wet and won''t burn.');
					2:
						case virt of
							1,3:
								wrtln(ob[who].connect,'The bridge resists your attempts at vandalism.');
							2:
								begin
								wrtln(ob[who].connect,'Angry kobolds rush in. They grab you and drag you off to prison.');
								act(who,'is dragged away.',true,false);
								stop_fight(100);
								ob[who].location:=517;
								doors[17].open:=false;
								act(who,'is thrown in by angry kobolds.',true,false);
								look(who,true);
								end;
							end;
					12,13,1:
						wrtln(ob[who].connect,'Vandal! Do you think I''m going to let you burn everything in sight?');
					otherwise
						if virtuals[commands[2].virtual].door_f[virt] then
							{ he's having a go at a door }
						begin
							lp:=find_door(ob[who].location);
							if doors[lp].break and not(doors[lp].broken) and (lp<>20) then
								begin
								wrtln(ob[who].connect,'You burn it to a state of uselessness.');
								act(who,concat('burns the ',doors[lp].name,' away.'),true,false);
								doors[lp].broken:=true;
								end
							else
								wrtln(ob[who].connect,'You fail to make much of an impression on it.');
							end
						else
							wrtln(ob[who].connect,'You fail to get it to light.');
					end;
			end
	else
		if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
			interr(who,3)
		else
			if commands[2].which=2 then
				burn_object(who,commands[2].object,true)
			else
				begin
				init_categ(commands[2].category);
				while doingcat do
					burn_object(who,curob,false);
				if curcno=0 then
					wrtln(ob[who].connect,'There was nothing around that you could set light to.');
				end;
	end;

procedure sweep(who : integer);

	begin
	if ob[76].carries<>who then
		err(who,10,true)
	else
		begin
		act(who,'sweeps for a little while.',true,false);
		if (ob[who].location=130) and (ob[40].location=123) then
			begin
			wrtln(ob[who].connect,tdata[68]);
			ob[40].location:=130;
			end
		else
			if ob[who].location=872 then
				wrtln(ob[who].connect,'The dust is too deep to sweep away - you''d be better digging.')
			else
				wrtln(ob[who].connect,tdata[69]);
		end;
	end;

procedure wave_something(who : integer);

var lp	: integer;

	begin
	if no_com=1 then
		act(who,'waves.',true,false)
	else
		if (no_com=2) and not(cant_extract(who,commands[2])) then
			if ob[commands[2].object].carries=who then
				begin
				doubleact(who,commands[2].object,'waves',true,false,true);
				if commands[2].object=139 then
					begin
					lose(who,139,false,false);
					act(139,'crumbles to dust.',true,false);
					remove_object(139);
					for lp:=87 to no_ob do
						if ob[lp].location=ob[who].location then
							if ob[lp].mobile then
								if f_level(lp)<14 then
									if lp<>who then
										begin
										wrtln(ob[lp].connect,'The magic of the rod sends you into a deep sleep.');
										if ob[lp].sleep then
											act(lp,'sinks into a deeper sleep.',true,false)
										else
											act(lp,'falls fast asleep.',true,false);
										ob[lp].sleep:=true;
										if lp=149 then
											dragonwoken:=true
										else
											begin
											destroy_event(1,lp);
											set_event(1,lp,0,5000+rnd(3000));
											end;
										end;
					end;
				if commands[2].object=202 then
					for lp:=87 to no_ob do
						if ob[lp].location=ob[who].location then
							if ob[lp].mobile then
								if f_level(lp)<14 then
									if lp<>who then
										begin
										wrtln(ob[lp].connect,'The wand emits a bolt of fire sending you sprawling!');
										act(lp,'is sent sprawling by a bolt of fire.',true,false);
						   				if (ob[lp].con>20) then
								   			begin
									   		ob[lp].con:=ob[lp].con-20;
											stam_display(lp);
									   		end
							   			else
							   				begin
							   				act(lp,'is burnt away completely by the fire''s heat.',true,false);
									   		wrtln(ob[lp].connect,'The fire''s heat is too much for you and you collapse.');
									   		dead(lp);
									   		end;
										end;
				if commands[2].object=248 then
					act(248,'leaves a trail of coloured stars behind it as it moves. Very pretty.',true,false);
				end
			else
				wrtln(ob[who].connect,'You don''t have that.')
		else
			interr(who,2);
	end;

procedure chuckoff(whom : player_range);

var tempst : str255;

	begin
	if position[whom,1]=100 then
		logoff(position[whom,6]);
	wrst(whom,'Logged off at ');
	show_time(whom,gettime);
	if position[whom,5]<>0 then
		begin
		writev(tempst,people[position[whom,5]]^.name,' has left the system with score ',people[position[whom,5]]^.sc,'.');
		log(tempst);
		people[position[whom,5]]^.tempflag:=0;
		end;
	cr(whom);
	{ modem control codes }
	if not(cnet) then
		begin
		wrst(whom,'+++');
		wrtln(whom,'ATH');
		end
	else
		send(whom,#3);
	position[whom,1]:=1;
	position[whom,5]:=0;
	end;

function not_imm(who, level : integer) : boolean;

	begin
	{ returns a boolean - whether the mobile is a valid immortal }
	not_imm:=(ob[who].control=0) or (ob[who].connect=0)
          or ob[who].possessed or (f_level(who)<level);
	end;

procedure bye_something(who : integer);

	begin
	if (no_com<>2) or (commands[2].which<>2) then
		interr(who,4)
	else
		if not_imm(who,12) then
			err(who,9,true)
		else
			if (ob[commands[2].object].control=0) or (ob[commands[2].object].connect=0) or (ob[commands[2].object].location=-1) then
				wrtln(ob[who].connect,'Not on that.')
			else
				begin
				log(concat(ob[who].name,' threw ',ob[commands[2].object].name,' off the game.'));
				wrtln(ob[commands[2].object].connect,'You are thrown off the game!');
				chuckoff(ob[commands[2].object].connect);
				end;
	end;

procedure removepersona(which : integer);

var filpos	: integer;

	begin
	if which<>1 then
		begin
		{ a safety-net to protect me }
		dispose(people[which]);
		people[which]:=NIL;
		filpos:=0;
{Include F:\REALM\COMPILER\REALMCM3.PAS}
		if pers_edit=which then
			pers_edit:=1;
		end;
	end;

procedure blot_something(who : integer);

var temp,
    temp2	: integer;

	begin
	if (no_com<>2) or (commands[2].which<>2) then
		interr(who,4)
	else
		if not_imm(who,13) then
			wrtln(ob[who].connect,'Can''t do that - not a valid God or Demigod!')
		else
			if (ob[commands[2].object].control=0) or (ob[commands[2].object].connect=0) or (ob[commands[2].object].location=-1) then
				wrtln(ob[who].connect,'Can''t blot that.')
			else
				if f_level(commands[2].object)>12 then
					wrtln(ob[who].connect,'You may not blot Gods or Demigods.')
				else
					begin
					temp:=ob[commands[2].object].connect;
					log(concat(ob[who].name,' blotted ',ob[commands[2].object].name,'.'));
					wrtln(temp,'You are banished from the game forever. Your persona is destroyed.');
					temp2:=position[temp,5];
					chuckoff(temp);
					removepersona(temp2);
					end;
	end;

procedure ban_something(who : integer);

	begin
	if (no_com<>3) or (commands[2].which<>2) or (commands[3].which<>4) then
		interr(who,2)
	else
		if not_imm(who,12) then
			err(who,9,true)
		else
			if (ob[commands[2].object].control=0) or (ob[commands[2].object].connect=0) or (ob[commands[2].object].location=-1) then
				wrtln(ob[who].connect,'Can''t ban that.')
			else
				if f_level(commands[2].object)=14 then
					wrtln(ob[who].connect,'Gods may not be banned.')
				else
					begin
					temp:=ob[commands[2].object].connect;
					log(concat(ob[who].name,' banned ',ob[commands[2].object].name,'.'));
					wrst(temp,'You are banned from the game! ');
					if commands[3].number>1000 then
						commands[3].number:=1000;
					ban(ob[commands[2].object].control,temp,commands[3].number);
					logoff(commands[2].object);
					show_main_menu(temp,false);
					end;
	end;

procedure doln(whom : integer; tempst : line);

var lp		: integer;
    carriager	: boolean;

	begin
	carriager:=false;
	if tempst[1]='_' then
		begin
		position[whom,10]:=4;
		delete(tempst,1,1);
		end;
	if tempst[length(tempst)]='_' then
		begin
		carriager:=true;
		delete(tempst,length(tempst),1);
		end;
	temp:=pos('_',tempst);
	if temp<>0 then
		begin
		for lp:=1 to temp-1 do
			send(whom,tempst[lp]);
		if findwidth(whom)<(ord(tempst[temp+1])+length(tempst)-temp+1) then
			cr(whom)
		else
			tab(whom,ord(tempst[temp+1]));
		for lp:=temp+2 to length(tempst) do
			send(whom,tempst[lp]);
		cr(whom);
		end
	else
		begin
		wrst(whom,tempst);
		if not(carriager) and (position[whom,2]>position[whom,10]) then send(whom,' ');
		end;
	if carriager then
		begin
		position[whom,10]:=0;
		if temp=0 then
			cr(whom);
		end;
	end;

procedure get_help(who : integer);

var which,
    lp		: integer;

	begin
	which:=1;
	if (no_com=2) and (commands[2].which=6) then
		begin
		commands[2].slashed[1]:=toupper(commands[2].slashed[1]);
		for lp:=1 to no_help do
			if help_item[lp].name[1]=commands[2].slashed[1] then
				which:=lp;
		end;
	if help_item[which].immortal and (f_level(who)<12) then
		wrtln(ob[who].connect,'That isn''t available to you.')
	else
		for lp:=help_item[which].startline to help_item[which].endline do
			doln(ob[who].connect,help_txt[lp]);
	if which=1 then
		begin
		cr(ob[who].connect);
		wrtln(ob[who].connect,'Options available are:');
		for lp:=1 to no_help do
			begin
			send(ob[who].connect,'/');
			send(ob[who].connect,help_item[lp].name[1]);
			send(ob[who].connect,' ');
			wrst(ob[who].connect,help_item[lp].name);
			tab(ob[who].connect,45);
			wrtint(ob[who].connect,(help_item[lp].endline-help_item[lp].startline)+1);
			wrst(ob[who].connect,' line(s)');
			if help_item[lp].immortal then
				wrst(ob[who].connect,' (Immortals only)');
			cr(ob[who].connect);
			end;
		end;
	end;

procedure wind_something(who : integer);

var gotkey	: boolean;

	begin
	if ob[who].location<>568 then
		wrtln(ob[who].connect,'There''s nothing here to wind.')
	else
		if clockwnd then
			wrtln(ob[who].connect,'The clock''s broken, you can''t wind it.')
		else
			begin
			if ob[170].carries=who then
				begin
				clockwnd:=true;
				act(who,'winds the clock, which breaks, shooting something out of its works.',true,false);
				wrst(ob[who].connect,'You wind the clock. It ticks happily for a few seconds, then springs, ');
				wrst(ob[who].connect,'cogs and wheels burst out of it and with a loud SPLANG! and a despairing ');
				wrtln(ob[who].connect,'CUCKOO! it shoots something out of its works and subsides.');
				if ob[169].location=123 then
					ob[169].location:=ob[who].location;
				end
			else
				wrtln(ob[who].connect,'You really need something to wind it with.');
			end;
	end;

procedure blow_something(who : integer);

var object,
    method	: integer;
    doneit	: boolean;

	begin
	{ 3 syntaxes, BLOW X, BLOW (OUT/UP) X and BLOW X (UP/OUT) }
	method:=0;
	if no_com=3 then
		if (commands[2].which=1) and (commands[3].which=2) then
			{ second word verb, should be out or up }
			if (commands[2].vb<>12) and (commands[2].vb<>9) then
				begin
				interr(who,1);
				method:=-1;
				end
			else
				begin
				method:=commands[2].vb;
				object:=commands[3].object;
				end
		else
			if (commands[3].which=1) and (commands[2].which=2) then
				{ third word verb }
				if (commands[3].vb<>12) and (commands[3].vb<>9) then
					begin
					interr(who,1);
					method:=-1;
					end
				else
					begin
					method:=commands[3].vb;
					object:=commands[2].object;
					end;
	if method=0 then
		if (no_com=2) and (commands[2].which=2) then
			object:=commands[2].object
		else
			begin
			interr(who,4);
			method:=-1;
			end;
	if method>=0 then
		if ob[object].carries<>who then
			err(who,8,true)
		else
			begin
			doneit:=false;
			if (object=168) and (method=0) then
				begin
				doneit:=true;
				act(who,'blows the whistle.',false,true);
				act(168,'gives off a shrill clear note, thin but piercing.',false,true);
				if ((ob[who].location=596) or (ob[who].location=597)) and glass_sh then
					begin
					tellall(ob[who].location,0,'The glass shatters into millions of fragments!',true,false);
					score_point(who,25);
					glass_sh:=false;
					end;
				end;
			if (object=116) and ((method=12) or (method=0)) then
				begin
				doneit:=true;
				{ blow out candle }
				if ob[116].burns then
					begin
					doubleact(who,116,'blows out',true,false,true);
					ob[116].burns:=false;
					ob[116].light:=false;
					end
				else
					wrtln(ob[who].connect,'It''s not lit!');
				end;
			if (object=244) and ((method=9) or (method=0)) then
				begin
				doneit:=true;
				{ blow up balloon }
				if balloon=1 then
					wrtln(ob[who].connect,'The balloon''s already blown up!')
				else
					begin
					doubleact(who,244,'blows up',true,false,true);
					if balloon=2 then
						begin
						tellall(ob[who].location,0,'There is a loud bang!',false,true);
						act(244,'has burst!',true,false);
						lose(who,244,false,false);
						remove_object(244);
						end
					else
						begin
						wrtln(ob[who].connect,'You inflate the balloon to its maximum size.');
						balloon:=1;
						end;
					end;
				end;
		if not(doneit) then err(who,6,true);
		end;
	end;

procedure fly_something(who : integer);

	begin
	if (no_com<>2) or (commands[2].which<>2) or (commands[2].object<>187) then
		begin
		act(who,'flaps # arms and tries to fly.',true,false);
		wrtln(ob[who].connect,'Fly? You can''t fly! Be serious!');
		if (who=92) or (who=93) or (who=149) then
			wrtln(ob[who].connect,'(Well, you can really, but I''m damned if I''m going to let you.)');
		end
	else
		if ob[187].carries<>who then
			err(who,8,true)
		else
			case ob[who].location of
				688:
					wrtln(ob[who].connect,'Can''t you see the flagpole''s broken!');
				697:
					begin
					wrst(ob[who].connect,'To the accompaniment of patriotic music you hoist the flag,');
					wrtln(ob[who].connect,' which promptly blows away. But at least you tried.');
					score_point(who,150);
					lose(who,187,false,false);
					remove_object(187);
					act(who,'flies the standard from the flagpole.',true,false);
					end;
				otherwise
					wrtln(ob[who].connect,'There''s nothing to fly the standard from here.');
				end;
	end;

procedure cut_something(who : integer);

var lp,
    object,
    gotchop	: integer;
    dn,
    break	: boolean;

	begin
	gotchop:=0;
	break:=commands[1].vb<>100;
	for lp:=1 to no_ob do
		if not(ob[lp].mobile) then
			if ob[lp].slash>=50 then
				if ob[lp].carries=who then
					gotchop:=lp;
	if (no_com<>2) or ((commands[2].which<>8) and cant_extract(who,commands[2])) then
		interr(who,3)
	else
		if commands[2].which=8 then
			begin
			object:=find_virtual(commands[2].virtual,ob[who].location);
			if object=0 then
				wrtln(ob[who].connect,'There''s not one of those around that I can see.')
			else
				case commands[2].virtual of
					1:
						if break then
							wrtln(ob[who].connect,'You can''t do that to a tree!')
						else
							if gotchop=0 then
								wrtln(ob[who].connect,'You really need a decent cutting weapon.')
							else
								case object of
									4:
										if tree then
											begin
											act(who,'chops down the tree.',true,false);
											tellall(618,0,'Timber! With a creak the tree begins to fall.',false,true);
											set_event(12,0,0,750);
											end
										else
											wrtln(ob[who].connect,'The tree is already down.');
									1:
										wrtln(ob[who].connect,'The tree is much too big and sturdy for you to be able to do that.');
									3:
										wrtln(ob[who].connect,'You make absolutely no impression.');
									2:
										wrtln(ob[who].connect,'"Oi! Stop mucking about with the scenery!"');
									end;
					2:
						case object of
							1,3:
								wrtln(ob[who].connect,'The bridge resists your attempts at vandalism.');
							2:
								begin
								wrtln(ob[who].connect,'Angry kobolds rush in. They grab you and drag you off to prison.');
								act(who,'is dragged away.',true,false);
								stop_fight(who);
								ob[who].location:=517;
								doors[17].open:=false;
								act(who,'is thrown in by angry kobolds.',true,false);
								look(who,true);
								end;
							end;
					6:
						if break then
							wrtln(ob[who].connect,'Clever trick, if you can do it...')
						else
							wrtln(ob[who].connect,'Well, if it gives you any satisfaction...');
					13:
						if object=1 then
							wrtln(ob[who].connect,'You can''t get a good enough grip on the rope.')
						else
							if break then
								wrtln(ob[who].connect,'The rope''s much too thick and sturdy for you to break it.')
							else
								if gotchop=0 then
									wrtln(ob[who].connect,'You need a good cutting weapon.')
								else
									begin
									wrtln(ob[who].connect,'"Saboteur!" Invisible hands grasp your weapon and hurl it far away!');
									lose(who,gotchop,false,false);
									ob[gotchop].location:=876;
									act(gotchop,'crashes down from above.',true,false);
									end;
					otherwise
						if virtuals[commands[2].virtual].door_f[object] then
							{ he's having a go at a door }
							if gotchop<>0 then
								begin
								lp:=find_door(ob[who].location);
								if doors[lp].break and not(doors[lp].broken) and not(doors[lp].s_hole) then
									if lp=20 then
										begin
										wrtln(ob[who].connect,'You only succeed in making a small hole in the door.');
										act(who,'hacks at the door, knocking a chunk out.',true,false);
										doors[lp].s_hole:=true;
										end
									else
										begin
										wrtln(ob[who].connect,'You comprehensively do it over.');
										act(who,concat('breaks the ',doors[lp].name,' down.'),true,false);
										doors[lp].broken:=true;
										end
								else
									begin
									wrtln(ob[who].connect,'You fail to make much of an impression on it.');
									act(who,concat('tries to break the ',doors[lp].name,' down.'),true,false);
									end;
								end
							else
								wrtln(ob[who].connect,'You really need a decent cutting weapon.')
						else
							wrtln(ob[who].connect,'You don''t seem to be able to damage that!');
					end;	
			end
		else
			{ trying to break or cut an object }
			if (commands[2].object=32) and break and
			   ((ob[who].location=591) or (ob[who].location=592)) and mirror then
				begin
				wrtln(ob[who].connect,'You strike the mirror sharply and it shatters. Oops - 7 years bad luck!');
				ob[who].cursed:=true;
				mirror:=false;
				end
			else
				wrtln(ob[who].connect,'Come on, be civilised...');
	end;

procedure wear_object(who,what : integer; errors : boolean);

	begin
	if ob[what].carries<>who then
		err(who,8,errors)
	else
		if not(ob[what].wearable) then
			err(who,6,errors)
		else
			begin
			ob[what].worn:=true;
			wrst(ob[who].connect,'You''re now wearing ');
			shortname(what,who,false,false,false);
			wrtln(ob[who].connect,'.');
			curcno:=curcno+1;
			doubleact(who,what,'wears',true,false,true);
			if what=247 then
				begin
				act(who,'has turned into a rabbit!',true,false);
				lose(who,247,false,false);
				with ob[247] do
					begin
					name:='rabbit';
					location:=ob[who].location;
					descr:=8;
					contdesc:=0;
					size:=50;
					weight:=70;
					carries:=0;
					mobile:=true;
					movem:='scampers';
					st:=30;
					con:=30;
					dex:=200;
					magic:=0;
					max_st:=30;
					max_con:=30;
					max_dex:=30;
					max_magic:=30;
					control:=0;
					weapon1:=0;
					weapon2:=0;
					connect:=0;
					fighting:=0;
					thirsty:=0;
					dislike:=0;
					drunk:=0;
					race:=12;
					class:=1;
					obey:=-1;
					possessed:=false;
					male:=ob[who].male;
					blind:=false;
					deaf:=false;
					dumb:=false;
					crippled:=false;
					invisible:=false;
					glowing:=false;
					cursed:=false;
					blessed:=false;
					sleep:=false;
					shield:=false;
					sc:=600;
					end;
				ob[who].location:=123;
				dotext(ob[who].connect,175,178);
				dead(who);
				curstop:=true;
				end;
			end;
	end;

procedure toff_object(who,what : integer; errors : boolean);

	begin
	if (ob[what].carries<>who) or not(ob[what].worn) then
		err(who,6,errors)
	else
		begin
		ob[what].worn:=false;
		wrst(ob[who].connect,'You take off ');
		shortname(what,who,false,false,false);
		wrtln(ob[who].connect,'.');
		curcno:=curcno+1;
		doubleact(who,what,'takes off',true,false,true);
		end;
	end;

procedure wear_something(who : integer);

	begin
	if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
		scenerr(who,3,2,commands[2])
	else
		if commands[2].which=2 then
			wear_object(who,commands[2].object,true)
		else
			begin
			init_categ(commands[2].category);
			while doingcat do
				wear_object(who,curob,false);
			if curcno=0 then
				wrtln(ob[who].connect,'There''s nothing around that you can wear.');
			end;
	end;

procedure take_off(who : integer);

var which : integer;

	begin
	which:=0;
	if (commands[3].which=1) and (commands[3].vb=201) then
		which:=2
	else
		if (commands[2].which=1) and (commands[2].vb=201) then
			which:=3;
	if which=0 then
		interr(who,2)
	else
		if (commands[which].which<>2) and (commands[which].which<>3) then
			scenerr(who,3,2,commands[which])
		else
			if commands[which].which=2 then
				toff_object(who,commands[which].object,true)
			else
				begin
				init_categ(commands[which].category);
				while doingcat do
					toff_object(who,curob,false);
				if curcno=0 then
					wrtln(ob[who].connect,'There''s nothing around that you can take off.');
				end;
	end;			

procedure like_someone(who : integer);

var lp,
    fd	: integer;

	begin
	if (ob[who].control=0) or (ob[who].possessed) then
		wrtln(ob[who].connect,'Sorry - mobiles or possessed players don''t have the right to vote.')
	else
		if (no_com<>2) or (commands[2].which<>5) then
			wrtln(ob[who].connect,'Syntax is LIKE "person" e.g. LIKE "RYKE".')
		else
			if people[ob[who].control]^.voted>0 then
				wrtln(ob[who].connect,'You''ve already voted once this session!')
			else
				begin
				fd:=0;
				for lp:=1 to no_people do
					if people[lp]<>NIL then
						if compare(commands[2].quoted,people[lp]^.name) then
							fd:=lp;
				if fd=0 then
					wrtln(ob[who].connect,'Sorry - that persona doesn''t exist.')
				else
					if fd=ob[who].control then
						wrtln(ob[who].connect,'Voting for yourself is illegal!')
					else
						begin
						people[fd]^.charisma:=people[fd]^.charisma+1;
						people[ob[who].control]^.voted:=add_days(gettime,7);
						end;
				end;
	end;

procedure hate_someone(who : integer);

var lp,
    fd	: integer;

	begin
	if (ob[who].control=0) or (ob[who].possessed) then
		wrtln(ob[who].connect,'Sorry - mobiles or possessed players don''t have the right to vote.')
	else
		if (no_com<>2) or (commands[2].which<>5) then
			wrtln(ob[who].connect,'Syntax is HATE "person" e.g. HATE "CHRYSOPHLAX".')
		else
			if people[ob[who].control]^.voted>0 then
				wrtln(ob[who].connect,'You''ve already voted recently!')
			else
				begin
				fd:=0;
				for lp:=1 to no_people do
					if people[lp]<>NIL then
						if compare(commands[2].quoted,people[lp]^.name) then
							fd:=lp;
				if fd=0 then
					wrtln(ob[who].connect,'Sorry - that persona doesn''t exist.')
				else
					if fd=ob[who].control then
						wrtln(ob[who].connect,'Voting for yourself is illegal!')
					else
						begin
						people[fd]^.charisma:=people[fd]^.charisma-1;
						people[ob[who].control]^.voted:=add_days(gettime,7);;
						end;
				end;
	end;

procedure supersnoop(who : integer);

	begin
	if not_imm(who,13) then
		wrtln(ob[who].connect,'You must be a Demigod or God to use this spell.')
	else
		if no_com=2 then
			remove_ssn(who)
		else
			add_ssn(who);
	end;

procedure snoop(who : integer);

var lp	: integer;

	begin
	if not_imm(who,12) then
		err(who,9,true)
	else
		if (no_com<>2) or (commands[2].which<>2) then
			begin
			for lp:=1 to top do
				if position[lp,9]=ob[who].connect then
					position[lp,9]:=0;
			end
		else
			if not(ob[commands[2].object].mobile) or (ob[commands[2].object].control=0) or
			(ob[commands[2].object].connect=0) or (commands[2].object=who) or forbidden(who,ob[commands[2].object].location)then
				wrtln(ob[who].connect,'You''re unable to snoop on that.')
			else
				if position[ob[who].connect,9]=0 then
					position[ob[commands[2].object].connect,9]:=ob[who].connect
				else
					wrtln(ob[who].connect,'Sorry - someone is already snooping on you.');
	end;

procedure remove_something(who : integer);

	begin
	if (commands[2].which<>2) or (no_com<>2) then
		interr(who,4)
	else
		if not_imm(who,12) or ((commands[2].object=209) and (ob[who].sc<819200)) then
			wrtln(ob[who].connect,'You have insufficient power to use this spell.')
		else
			if ob[commands[2].object].mobile then
				wrtln(ob[who].connect,'Only inanimate objects.')
			else
				begin
				act(who,'speaks a spell of Destruction.',false,true);
				if forbidden(who,real_loc(commands[2].object)) then
					wrtln(ob[who].connect,'You are not allowed to remove that.')
				else
					begin
					act(commands[2].object,'crumbles away into dust which is blown away by the wind.',true,false);
					if ob[commands[2].object].carries<>0 then
						lose(ob[commands[2].object].carries,commands[2].object,true,false);
					if ob[commands[2].object].location<>-1 then
						remove_object(commands[2].object);
					end;
				end;
	end;

procedure disconnect(who : integer);

	begin
	if not_imm(who,0) then
		wrtln(ob[who].connect,'You can''t disconnect!')
	else
		if people[ob[who].control]^.coder then
			begin
			log(concat(ob[who].name,' uses a Disconnect command.'));
			position[ob[who].connect,1]:=3;
			position[ob[who].connect,5]:=0;
			wrst(ob[who].connect,'Now give new persona name : ');
			ob[who].connect:=0;
			end
		else
			wrtln(ob[who].connect,'Only those with Coder status may use this command.');
	end;

procedure lookat_object(who,what : integer; errors, read : boolean);

var lp,
    found	: integer;

	begin
	if (ob[who].location<>real_loc(what)) or cant_see_obj(who,what) then
		err(who,7,errors)
	else
		begin
		doubleact(who,what,'looks carefully at',true,false,true);
		found:=0;
		for lp:=1 to no_exam do
			if examine[lp]^.what=what then
				found:=lp;
		if found=0 then
			if read or ob[what].mobile then
				err(who,6,errors)
			else
				begin
				shortname(what,who,true,false,false);
				wrtln(ob[who].connect,' is nothing out of the ordinary.');
				curcno:=curcno+1;
				end
		else
			if read and not(examine[found]^.read) then
				err(who,6,errors)
			else
				if not(examine[found]^.when_carried) and (ob[what].carries<>who) then
					begin
					wrst(ob[who].connect,'You really need to be carrying ');
					shortname(what,who,false,false,false);
					wrtln(ob[who].connect,' to get a good look at it.');
					end
				else
					begin
					for lp:=1 to examine[found]^.lines do
						wrst(ob[who].connect,examine[found]^.examtxt[lp]^);
					cr(ob[who].connect);
					curcno:=curcno+1;
					end;
		end;
	end;

procedure lookat_somet(who : integer);

var which,
    lp		: integer;

	begin
	if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3) and (commands[2].which<>8)) then
		interr(who,3)
	else
		if dark(ob[who].location,who) then
			wrtln(ob[who].connect,'You can''t do that in the dark!')
		else
			if commands[2].which=2 then
				lookat_object(who,commands[2].object,true,commands[1].vb=106)
			else
				if commands[2].which=3 then
					begin
					init_categ(commands[2].category);
					while doingcat do
						lookat_object(who,curob,false,commands[1].vb=106);
					if curcno=0 then
						wrtln(ob[who].connect,'Nothing examined.');
					end
				else
					{ we're trying to examine a virtual object }
					begin
					which:=find_virtual(commands[2].virtual,ob[who].location);
					if which=0 then
						wrtln(ob[who].connect,'I don''t see one of those in the vicinity.')
					else
						begin
						if virtuals[commands[2].virtual].lines[which]=0 then
							wrst(ob[who].connect,'It''s just scenery - nothing special. ')
						else
							begin
							for lp:=1 to virtuals[commands[2].virtual].lines[which] do
								wrst(ob[who].connect,virtuals[commands[2].virtual].examtxt[which,lp]^);
							send(ob[who].connect,' ');
							if commands[2].virtual=26 then
	if blackpt>0 then
		for lp:=1 to blackpt do
			wrtln(ob[who].connect,concat('Someone has written on the blackboard "',blackboard[lp],'".'))
	else
		wrtln(ob[who].connect,'Nothing has been written on the blackboard.');
							end;
						if virtuals[commands[2].virtual].door_f[which] then
							if (find_door(ob[who].location)>0) then door_stat(find_door(ob[who].location),who)
							else
							cr(ob[who].connect)
						else
							cr(ob[who].connect);
						end;
					end;
	end;

procedure squash_somet(who : integer);

var victim : integer;

	begin
	if (no_com<>2) or cant_extract(who,commands[2]) then
		interr(who,3)
	else
		if ob[commands[2].object].mobile then
			if not_imm(who,12) then
				err(who,9,true)
			else
				begin
				if (f_level(who)>=f_level(commands[2].object)) and not(forbidden(who,ob[commands[2].object].location)) then
					victim:=commands[2].object
				else
					victim:=who;
				act(victim,'is squashed by a giant foot!',true,false);
				wrtln(ob[victim].connect,'A giant foot comes down from the sky and steps on you. Splat.');
				dead(victim);
				end
		else
			err(who,6,true);
	end;

procedure arena_sp(who : integer);

	begin
	if (commands[2].which<>2) or (commands[3].which<>2) or
	   (commands[4].which<>4) or (no_com<>4) then
		interr(who,2)
	else
		if not_imm(who,12) then
			err(who,9,true)
		else
			if not(ob[commands[2].object].mobile) or not(ob[commands[3].object].mobile) then
				wrtln(ob[who].connect,'Only mobiles or people, please.')
			else
				if forbidden(who,ob[commands[2].object].location) or
				   forbidden(who,ob[commands[3].object].location) then
					wrtln(ob[who].connect,'You are forbidden to move one of those.')
				else
					begin
					stop_fight(commands[2].object);
					stop_fight(commands[3].object);
					act(commands[2].object,'is snatched off to the Arena.',true,false);
					ob[commands[2].object].location:=666;
					act(commands[3].object,'is snatched off to the Arena.',true,false);
					ob[commands[3].object].location:=666;
					act(commands[2].object,'appears!',true,false);
					act(commands[3].object,'appears!',true,false);
					arena_bonus:=commands[4].number;
					ar1:=commands[2].object;
					ob[commands[2].object].dislike:=commands[3].object;
					ar2:=commands[3].object;
					ob[commands[3].object].dislike:=commands[2].object;
					look(commands[2].object,true);
					look(commands[3].object,true);
					tellall(666,0,'A voice commands "Fight to the death, and you will be well rewarded!"',false,true);
					end;
	end;
   	
procedure wall_spell(who : integer);

var temp,
    search	: integer;
    tempst	: str255;
    found_1	: boolean;

	begin
	if (commands[2].which<>1) or (no_com<>2) or (commands[2].vb>8) then
		interr(who,2)
	else
		begin
		temp:=c_spell(who,2,60,0,3,4,9);
		if temp<>0 then
			begin
			{ we have now thrown up a wall }
			temp:=places[ob[who].location].value[commands[2].vb];
			if (temp=0) or (temp>32700) or places[ob[who].location].wet then
				wrtln(ob[who].connect,'You can''t put a wall there!')
			else
				if no_wall=30 then
					wrtln(ob[who].connect,'Sorry - there''s a limit of 30 magic walls in the game at a time.')
				else
					begin
					found_1:=false;
					for search:=1 to no_wall do
						if ((walls[search].where1=temp) and (walls[search].where2=ob[who].location)) or
						   ((walls[search].where2=temp) and (walls[search].where1=ob[who].location)) then
						   	found_1:=true;
					if found_1 then
						wrtln(ob[who].connect,'There''s a wall there already, dummy!')
					else
						begin
						no_wall:=no_wall+1;
						walls[no_wall].where1:=ob[who].location;
						walls[no_wall].where2:=temp;
						walls[no_wall].direction:=commands[2].vb;
						walls[no_wall].fire:=(commands[1].vb=109);
						if walls[no_wall].fire then
							tempst:='A magical wall of flame'
						else
							tempst:='A magical wall of stone';
						dir_string(commands[2].vb,false);
						tellall(ob[who].location,0,concat(tempst,' has sprung up to the ',dirs,'.'),true,false);
						dir_string(opposite(commands[2].vb),false);
						tellall(temp,0,concat(tempst,' has appeared to the ',dirs,'.'),true,false);
						end;
					end;
			end;
		end;
	end;

procedure push_spell(who : integer);

var temp : integer;

	begin
	if (commands[3].which<>1) or (no_com<>3) or cant_extract(who,commands[2]) or (commands[3].vb>12) then
		interr(who,2)
	else
		if ob[commands[2].object].mobile then
			begin
			temp:=c_spell(who,7,20,commands[2].object,3,1,10);
			if (temp>0) and forbidden(who,ob[commands[2].object].location) then
				begin
				temp:=0;
				wrtln(ob[who].connect,tdata[189]);
				end;
			if temp=1 then
				begin
				dir_string(commands[3].vb,false);
				wrtln(ob[commands[2].object].connect,concat('A giant hand pushes you gently but firmly ',dirs,'.'));
				move(commands[2].object,commands[3].vb);
				end;
			if temp=2 then
				begin
				wrtln(ob[commands[2].object].connect,'You feel a brief pushing sensation.');
				if rnd(2)=1 then
					begin
					shortname(commands[2].object,who,true,false,false);
					wrtln(ob[who].connect,' resists your spell.');
					end
				else
					begin
					act(who,'falls to the ground, unconscious.',true,false);
					wrtln(ob[who].connect,'You fall into a momentary sleep.');
					ob[who].sleep:=true;
					set_event(1,who,0,2000+rnd(2000));
					curstop:=true;
					end;
				end;
			end;
	end;

procedure dispo_spell(who : integer);

var temp 	: integer;

	begin
	if (no_com<>2) or cant_extract(who,commands[2]) then
		interr(who,3)
	else
		if ob[commands[2].object].mobile and (commands[2].object<>who) then
			begin
			temp:=c_spell(who,3,40,commands[2].object,0,3,11);
			if (temp>0) and forbidden(who,ob[commands[2].object].location) then
				begin
				temp:=0;
				wrtln(ob[who].connect,tdata[189]);
				end;
			if (temp=2) or not(ob[commands[2].object].possessed) then
				begin
				wrtln(ob[who].connect,'You are thrown into a deep sleep.');
				act(who,'falls asleep!',true,false);
				wrtln(ob[commands[2].object].connect,'Something is groping in your mind!');
				ob[who].sleep:=true;
				set_event(1,who,0,3000+rnd(3000));
				end
			else
				if temp<>0 then
					begin
					dispossess(ob[who_possesses(commands[2].object)].connect);
					wrtln(ob[who].connect,'Your spell succeeds!');
					end;
			end
		else
			err(who,6,true);
	end;

procedure tell_spell(who : integer);

	begin
	if (no_com<>3) or ((commands[2].which<>2) and (commands[2].which<>3)) or (commands[3].which<>5) then
		interr(who,2)
	else
		if c_spell(who,25,1,0,0,0,0)=1 then
			if commands[2].which=2 then
				if ob[commands[2].object].mobile then
					if ob[commands[2].object].sleep or forbidden(who,ob[commands[2].object].location) then
						wrtln(ob[who].connect,'You are unable to make mental contact with that person.')
					else
						begin
						shortname(who,commands[2].object,true,false,false);
						wrst(ob[commands[2].object].connect,'''s voice says in your mind "');
						wrst(ob[commands[2].object].connect,commands[3].quoted);
						wrtln(ob[commands[2].object].connect,'".');
						end
				else
					interr(who,8)
			else
				begin
				init_categ(commands[2].category);
				while doingcat do
					if (ob[curob].mobile) and (curob<>who) then
						begin
						shortname(who,curob,true,false,false);
						wrst(ob[curob].connect,'''s voice says in your mind "');
						wrst(ob[curob].connect,commands[3].quoted);
						wrtln(ob[curob].connect,'".');
						end;
				end;
	end;

procedure nowall_sp(who : integer);

var lp		: integer;
    tempst	: str255;

	begin
	if c_spell(who,4,28,0,3,3,12)=1 then
		begin
		for lp:=1 to no_wall do
			if (walls[lp].where1=ob[who].location) or (walls[lp].where2=ob[who].location) then
				begin
				if walls[lp].fire then
					tempst:='The magical wall of flame'
				else
					tempst:='The magical wall of stone';
				dir_string(walls[lp].direction,false);
				tellall(walls[lp].where1,0,concat(tempst,' to the ',dirs,' vanishes suddenly!'),true,false);
				dir_string(opposite(walls[lp].direction),false);
				tellall(walls[lp].where2,0,concat(tempst,' to the ',dirs,' vanishes abrubtly!'),true,false);
				walls[lp].where1:=0;
				walls[lp].where2:=0;
				end;
		end;
	end;

procedure inter_object(who,what : integer; errors : boolean);

	begin
	if (who=what) or not(ob[what].mobile) then
		err(who,6,errors)
	else
		if ob[who].location<>ob[what].location then
			err(who,7,errors)
		else
			begin
			if errors then
				if ob[what].control=0 then
					wrtln(ob[who].connect,'Well, if you feel you must...')
				else
					wrtln(ob[who].connect,'Ok.');
			curcno:=curcno+1;
			case commands[1].vb of
				122:
					begin
					doubleact(who,what,'hugs',true,false,true);
					shortname(who,what,true,false,true);
					wrtln(ob[what].connect,' hugs you!');
					end;
				123:
					begin
					doubleact(who,what,'kisses',true,false,true);
					shortname(who,what,true,false,true);
					wrtln(ob[what].connect,' kisses you!');
					end;
				end;
			end;
	end;

procedure interact(who : integer);

	begin
	if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3) and (commands[2].which<>8)) then
		interr(who,3)
	else
		begin
		if commands[2].which=2 then
			inter_object(who,commands[2].object,true)
		else
			if commands[2].which=3 then
				begin
				init_categ(commands[2].category);
				while doingcat do
					inter_object(who,curob,false);
				if curcno=0 then
					wrtln(ob[who].connect,'There''s nothing around you can do that to.');
				end
			else
				begin
				{ we're trying to do things to the scenery }
				temp:=find_virtual(commands[2].virtual,ob[who].location);
				if temp=0 then
					wrtln(ob[who].connect,'I don''t see one of those in the vicinity.')
				else
					if (commands[2].virtual=18) and (commands[1].vb=123) then
						begin
						stop_fight(who);
						act(who,'kisses the giant lips, and disappears!',true,false);
						wrtln(ob[who].connect,'The world seems to blur and fade - you are elsewhere.');
						ob[who].location:=1;
						look(who,true);
						act(who,'appears in a puff of greasy pink smoke.',true,false);
						end
					else
						wrtln(ob[who].connect,'You''d look a bit daft doing that to the scenery!');
				end;
		end;
	end;

procedure object_man(who : integer);

	begin
	if (no_com<>2) or (commands[2].which<>2) then
		interr(who,4)
	else
		if not_imm(who,12) then
			err(who,9,true)
		else
			if forbidden(who,ob[commands[2].object].location) then
				wrtln(ob[who].connect,'You are forbidden to change that object.')
			else
				if not(ob[commands[2].object].mobile) then
					case commands[1].vb of
						127:
							ob[commands[2].object].wearable:=not(ob[commands[2].object].wearable);
						128:
							ob[commands[2].object].flammable:=not(ob[commands[2].object].flammable);
						129:
							ob[commands[2].object].burns:=not(ob[commands[2].object].burns);
						130:
							ob[commands[2].object].light:=not(ob[commands[2].object].light);
						131:
							ob[commands[2].object].two_hand:=not(ob[commands[2].object].two_hand);
						151:
							begin
							ob[commands[2].object].c_liquid:=not(ob[commands[2].object].c_liquid);
							ob[commands[2].object].liquid:=0;
							end;
						193:
							ob[commands[2].object].extinguish:=not(ob[commands[2].object].extinguish);
						end
				else
					wrtln(ob[who].connect,'Not an object!');
	end;

procedure descrs(who : integer);

	begin
	if (no_com<>3) or (commands[2].which<>2) or (commands[3].which<>4) then
		interr(who,2)
	else
		if not_imm(who,12) then
			err(who,9,true)
		else
			if forbidden(who,real_loc(commands[2].object)) then
				wrtln(ob[who].connect,'You cannot alter that object.')
			else
				if commands[3].number<=no_desc then
					if commands[1].vb=125 then
						ob[commands[2].object].descr:=commands[3].number
					else
						ob[commands[2].object].contdesc:=commands[3].number
				else
					wrtln(ob[who].connect,'Invalid description.');
	end;

procedure shatt_object(who, what : integer; errors : boolean);

var points	: integer;

	begin
	if ob[who].location<>real_loc(what) then
		err(who,7,errors)
	else
		if ob[what].mobile then
			err(who,6,errors)
		else
			begin
			points:=(ob[what].value div 3)+(ob[what].hit div 6)+(ob[what].slash div 6)
			       +(ob[what].stab div 6)+(ob[what].parry div 6)+15;
			if c_spell(who,4,points,0,3,2,13)=0 then
				curstop:=true
			else
				if (what=115) or (what=209) then
					act(what,'resists the Shatter spell.',true,false)
				else
					begin
					act(what,'shatters into fragments!',true,false);
					if ob[what].carries<>0 then
						lose(ob[what].carries,what,true,false);
					if ob[what].location<>-1 then
						remove_object(what);
					curcno:=curcno+1;
					if ob[who].location=-1 then
						curstop:=true;
					end;
			end;
	end;

procedure shatter_sp(who : integer);

	begin
	if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
		interr(who,3)
	else
		begin
		if commands[2].which=2 then
			shatt_object(who,commands[2].object,true)
		else
			begin
			init_categ(commands[2].category);
			while doingcat do
				shatt_object(who,curob,false);
			if curcno=0 then
				wrtln(ob[who].connect,'Your spell shattered nothing.');
			end;
		end;
	end;

procedure zap_something(who : integer);

	begin
	if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
		interr(who,3)
	else
		begin
		if commands[2].which=2 then
			if commands[1].vb=199 then
				sap(who,commands[2].object,true)
			else
				zap(who,commands[2].object,true,(commands[1].vb=143),(commands[1].vb=184))
		else
			begin
			init_categ(commands[2].category);
			while doingcat do
				if commands[1].vb=199 then
					sap(who,curob,false)
				else
					zap(who,curob,false,(commands[1].vb=143),(commands[1].vb=184));
			if curcno=0 then
				wrtln(ob[who].connect,'You didn''t find anything to use that spell on.');
			end;
		end;
	end;

procedure hit_something(who : integer);

	begin
	if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
		scenerr(who,3,3,commands[2])
	else
		begin
		if commands[2].which=2 then
			hit_object(who,commands[2].object,commands[1].vb,true)
		else
			begin
			init_categ(commands[2].category);
			while doingcat do
				hit_object(who,curob,commands[1].vb,false);
			if curcno=0 then
				wrtln(ob[who].connect,'You didn''t find anything to hit.');
			end;
		end;
	end;

procedure exits(who : integer);

var count,lp	: integer;
    tempflag	: boolean;

	begin
	if ((ob[who].location>=711) and (ob[who].location<=770)) or
	   ((ob[who].location>=318) and (ob[who].location<=338)) or
	   (ob[who].location=168) or blind_q(who) then
		wrtln(ob[who].connect,'You can''t tell.')
	else
		begin
		if dark(ob[who].location,who) then
			wrtln(ob[who].connect,'Exits from this location are :')
		else
			wrtln(ob[who].connect,concat('Exits from ',places[ob[who].location].name,' are :'));
		count:=0;
		with places[ob[who].location] do
			for lp:=1 to 12 do
				begin
				tempflag:=(value[lp]<>0) and (value[lp]<=no_place) and
				          not((value[lp]=139) and not(ice_melt)) and
				          not(((ob[who].location=365) or (value[lp]=365)) and not(wall_hole));
				tempflag:=tempflag and not(((ob[who].location=421) or (value[lp]=421)) and not(sesame)) and
				  not((((ob[who].location=592) and (value[lp]=591)) or
                                  ((ob[who].location=591) and (value[lp]=592))) and mirror);
				if tempflag then
					begin
					dir_string(lp,true);
					count:=count+1;
					wrst(ob[who].connect,dirs);
					tab(ob[who].connect,11);
					if places[value[lp]].dark then
						wrtln(ob[who].connect,': Darkness')
					else
						begin
						wrst(ob[who].connect,concat(': ',places[value[lp]].name));
						if ob[who].sc>204799 then
							begin
							wrst(ob[who].connect,' [');
							wrtint(ob[who].connect,value[lp]);
							send(ob[who].connect,']');
							end;
						cr(ob[who].connect);
						end;
					end
				else
					if value[lp]=32767 then
						begin
						dir_string(lp,true);
						count:=count+1;
						wrst(ob[who].connect,dirs);
						tab(ob[who].connect,11);
						wrtln(ob[who].connect,concat(': Through the ',doors[find_door(ob[who].location)].name));
						end;
				end;
		if count=0 then
			wrtln(ob[who].connect,'None whatsoever!');
		end;
	end;

procedure peace_sp(who : integer);

var lp : integer;

	begin
	if not_imm(who,12) then
		err(who,9,true)
	else
		if peace then
			wrtln(ob[who].connect,'Someone''s done that already!')
		else
			begin
			peace:=true;
			for lp:=86 to no_ob do
				if ob[lp].location>0 then
					if ob[lp].mobile then
						begin
						wrtln(ob[lp].connect,'Fighting has been forbidden!');
						ob[lp].fighting:=0;
						end;
			log(concat(ob[who].name,' uses a Peace command.'));
			end;
	end;

procedure war_sp(who : integer);			

var lp : integer;

	begin
	if not_imm(who,12) then
		err(who,9,true)
	else
		if not(peace) then
			wrtln(ob[who].connect,'That is already the case!')
		else
			begin
			peace:=false;
			for lp:=86 to no_ob do
				if ob[lp].location>0 then
					if ob[lp].mobile then
						wrtln(ob[lp].connect,'Fighting is allowed again!');
			log(concat(ob[who].name,' uses a War command.'));
			end;
	end;

procedure heal_sp(who : integer);

	begin
	if (no_com=2) and (commands[2].which=4) then
		begin
		commands[3]:=commands[2];
		commands[2].which:=2;
		commands[2].object:=who;
		no_com:=3;
		end;
	if (no_com<>3) or cant_extract(who,commands[2]) or (commands[3].which<>4) then
		interr(who,2)
	else
		if ob[commands[2].object].mobile then
			if (commands[3].number>0) and (commands[3].number<400) then
				begin
				if c_spell(who,6,commands[3].number*2,0,4,0,14)=1 then
					if forbidden(who,ob[commands[2].object].location) then
						wrtln(ob[who].connect,tdata[189])
					else
						begin
						if who<>commands[2].object then
							begin
							shortname(who,commands[2].object,true,false,false);
							wrtln(ob[commands[2].object].connect,' has cast a healing spell on you!');
							end;
						addlimit(ob[commands[2].object].con,ob[commands[2].object].max_con,commands[3].number);
						stam_display(commands[2].object);
						end
				end
			else
				wrtln(ob[who].connect,'Be sensible!')
		else
			err(who,6,true);
	end;

procedure locvague(lp : integer; VAR wherest : string);

	begin
	if ((lp>=1) and (lp<=122)) or ((lp>=210) and (lp<=215)) or
	   ((lp>=260) and (lp<=267)) or (lp=602) or (lp=771) or
	   (lp=772) or ((lp>=776) and (lp<=819)) then
		wherest:='in the central part of the Realm'
	else
		if (lp=124) or (lp=123) or ((lp>=161) and (lp<=209)) or ((lp>=499) and (lp<=546)) then
			wherest:='in the caves under the mountain'
		else
			if (lp>=216) and (lp<=259) then
				wherest:='near or in the Abbey'
			else
				if (lp>=126) and (lp<=160) then
					wherest:='in the Northern Lands'
				else
					if ((lp>=268) and (lp<=339)) or (lp=830) then
						wherest:='in the City'
					else
						if (lp>=340) and (lp<445) then
							wherest:='out at sea somewhere'
						else
							if (lp>=446) and (lp<=498) then
								wherest:='in Hamlet''s caverns'
							else
								if (lp>=547) and (lp<=601) then
									wherest:='in Hamlet''s castle'
								else
									if (lp>=603) and (lp<=770) then
										wherest:='in or near the palace'
									else
										if (lp>=821) and (lp<=829) then
											wherest:='on the pirate Galleon, at sea'
										else
											if (lp>=832) and (lp<=869) then
												wherest:='in or near the Village area'
											else
												if (lp>=870) and (lp<=892) then
													wherest:='in the Circus area'
												else
													wherest:='somewhere completely detached from the Realm';
	end;

procedure where_a_loc(who : integer);

var wherest : string;

	begin
	lp:=extract_loc(commands[2]);
	if lp<>0 then
		begin
		if c_spell(who,5,15,0,0,0,0)=1 then
			begin
			locvague(lp,wherest);
			wrtln(ob[who].connect,concat(places[lp].name,' is ',wherest,'.'));
			end;
		end
	else
		interr(who,5);
	end;

procedure where_a_virt(who : integer);

var lp2,
    lp3		: integer;

	begin
	if c_spell(who,18,10,0,0,0,0)=1 then
		with virtuals[commands[2].virtual] do
			for lp2:=1 to howmany do
				for lp3:=rooms[lp2,1] to (rooms[lp2,2]+rooms[lp2,1]-1) do
					wrtln(ob[who].connect,concat(places[vlocs[lp3]].name,'.'));
	end;

procedure weather_sp(who : integer);

var lp	: integer;

	begin
	if (no_com<>2) or (commands[2].which<>4) or (commands[2].number<1) or (commands[2].number>10) then
		interr(who,2)
	else
		if not_imm(who,13) then
			wrtln(ob[who].connect,'You''re not allowed to cast this spell.')
		else
			begin
			new_weather:=sunny;
			for lp:=2 to commands[2].number do
				new_weather:=succ(new_weather);
			set_event(13,0,0,5)
			end;
	end;

procedure ext_object(who, what : integer; errors : boolean);

	begin
	if real_loc(what)<>ob[who].location then
		err(who,7,errors)
	else
		if ob[what].extinguish and not(ob[what].mobile) then
			begin
			doubleact(who,what,'puts out',true,false,true);
			wrst(ob[who].connect,'You extinguish ');
			curcno:=curcno+1;
			shortname(what,who,false,false,false);
			wrtln(ob[who].connect,'.');
			ob[what].light:=false;
			ob[what].burns:=false;
			end
		else
			err(who,6,errors);
	end;

procedure exting(who : integer);

	begin
	if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
		interr(who,3)
	else
		if commands[2].which=2 then
			ext_object(who,commands[2].object,true)
		else
			begin
			init_categ(commands[2].category);
			while doingcat do
				ext_object(who,curob,false);
			if curcno=0 then
				wrtln(ob[who].connect,'There was nothing around that you could extinguish.');
			end;
	end;

procedure shield_sp(who : integer);

	begin
	if no_com=1 then
		temp:=who
	else
		if (no_com=2) and not(cant_extract(who,commands[2])) then
			if ob[commands[2].object].mobile then
				temp:=commands[2].object
			else
				begin
				wrtln(ob[who].connect,'You can''t shield that.');
				temp:=0;
				end
		else
			begin
			interr(who,3);
			temp:=0;
			end;
	if temp<>0 then
		if c_spell(who,4,50,0,4,3,15)=1 then
			if forbidden(who,ob[temp].location) then
				wrtln(ob[who].connect,tdata[189])
			else
				begin
				ob[temp].shield:=true;
				wrtln(ob[temp].connect,'You are now protected from weapons and lower level spells.');
				act(temp,'acquires a magical shield.',true,false);
				if f_level(who)<12 then
					set_event(19,temp,0,30000+rnd(30000));
				end;
	end;

procedure vorp_sp(who : integer);

	begin
	if (no_com<>2) or cant_extract(who,commands[2]) then
		interr(who,3)
	else
		if real_loc(commands[2].object)<>ob[who].location then
			err(who,7,true)
		else
			if ob[commands[2].object].mobile then
				wrtln(ob[who].connect,'That spell only acts on objects.')
			else
				begin
				if c_spell(who,2,20,0,3,3,16)=1 then
					if ob[commands[2].object].slash=0 then
						wrtln(ob[who].connect,'The VORPAL spell can only be used on edged weapons.')
					else
						begin
						ob[commands[2].object].vorpal:=true;
						act(commands[2].object,'is now a vorpal blade!',false,false);
						end;
				end;
	end;

procedure disrupt_sp(who : integer);

	begin
	if (no_com<>2) or cant_extract(who,commands[2]) then
		interr(who,3)
	else
		if real_loc(commands[2].object)<>ob[who].location then
			err(who,7,true)
		else
			if f_level(who)<14 then
				wrtln(ob[who].connect,'You can''t cast that spell.')
			else
				if ob[commands[2].object].mobile then
					begin
					doubleact(who,commands[2].object,'casts a Disruption spell on',true,false,true);
					act(commands[2].object,'collapses to the ground in a tangled heap.',true,false);
					shortname(who,commands[2].object,true,false,true);
					dotext(ob[commands[2].object].connect,122,124);
					dead(commands[2].object);
					end
				else
					err(who,6,true);
	end;

procedure ride_somet(who : integer);

	begin
	if (no_com<>2) or cant_extract(who,commands[2]) then
		interr(who,3)
	else
		if ob[commands[2].object].location<>ob[who].location then
			err(who,7,true)
		else
			if commands[2].object=201 then
				if (ob[201].location>122) or (ob[201].connect<>0) or (ob[201].crippled) then
					begin
					act(who,'tries to mount the pony.',true,false);
					act(201,'bucks and shies, refusing to be ridden.',true,false);
					wrtln(ob[201].connect,'Someone tries to ride you!');
					end
				else
					begin
					act(who,'mounts the pony, which dashes off in all directions.',true,false);
					stop_fight(201);
					stop_fight(who);
					wrst(ob[who].connect,'The pony leaps up as you mount it and gallops off, dashing a long distance');
					wrtln(ob[who].connect,' through the land before throwing you down, winded, on your back.');
					ob[who].location:=rnd(122);
					ob[201].location:=ob[who].location;
					look(who,true);
					act(who,'is brought in on the back of the pony and falls off here.',true,false);
					end
			else
				err(who,6,true);
	end;

procedure league(who : integer);

var count,
    lp,
    lp2,
    found	: integer;
    top,
    t		: integer;

	begin
	if no_com=1 then
		wrtln(ob[who].connect,'Syntax is LEAGUE SCORE or KILL or LIKE or CHARISMA or HATE or I.')
	else
		if (no_com<>2) or (commands[2].which<>1) then
			interr(who,2)
		else
			case commands[2].vb of
				29:
					begin
					wrtln(ob[who].connect,'List of Immortals.');
					top:=819201;
					found:=-1;
					repeat
						t:=0;
						for lp:=1 to no_people do
							if people[lp]<>NIL then
								if (people[lp]^.sc>204799) and (people[lp]^.sc>t) and (people[lp]^.sc<top) then
									begin
									found:=lp;
									t:=people[lp]^.sc;
									end;
						top:=t;
						if (found<>-1) and (t<>0) then
							begin
							for lp2:=1 to no_people do
								if people[lp2]<>NIL then
									if people[lp2]^.sc=t then
										begin
										wrst(ob[who].connect,people[lp2]^.name);
										tab(ob[who].connect,24);
										if people[lp2]^.sc>=409600 then
											begin
											if people[lp2]^.sc>=819200 then
												count:=100
											else
												count:=98;
											if people[lp2]^.male then count:=count-1;
											end
										else
											begin
											count:=12+(24*(people[lp2]^.class-1));
											if not(people[lp2]^.male) then count:=count+12;
											end;
										wrst(ob[who].connect,level[count]);
										cr(ob[who].connect);
										end;
							end;
					until (top<204799);
					end;
				43:
					begin
					wrtln(ob[who].connect,'The "Top ten" - scores.');
					count:=1;
					top:=204800;
					found:=-1;
					repeat
						t:=0;
						for lp:=1 to no_people do
							if people[lp]<>NIL then
								if not(people[lp]^.sc>204799) and (people[lp]^.sc>t) and (people[lp]^.sc<top) then
									begin
									found:=lp;
									t:=people[lp]^.sc;
									end;
						top:=t;
						if (found<>-1) and (t<>0) then
							begin
							for lp2:=1 to no_people do
								if people[lp2]<>NIL then
									if people[lp2]^.sc=t then
										begin
										wrtint(ob[who].connect,count);
										tab(ob[who].connect,4);
										wrst(ob[who].connect,people[lp2]^.name);
										tab(ob[who].connect,26);
										wrtint(ob[who].connect,people[lp2]^.sc);
										count:=count+1;
										cr(ob[who].connect);
										end;
							end;
					until (top=0) or (count>10);
					end;
				146,94:
					begin
					wrtln(ob[who].connect,'The "Top ten" - charismata.');
					count:=1;
					top:=204800;
					found:=-1;
					repeat
						t:=0;
						for lp:=1 to no_people do
							if people[lp]<>NIL then
								if (people[lp]^.charisma>t) and (people[lp]^.charisma<top) and (people[lp]^.sc<819200) then
									begin
									found:=lp;
									t:=people[lp]^.charisma;
									end;
						top:=t;
						if (found<>-1) and (t<>0) then
							begin
							for lp2:=1 to no_people do
								if people[lp2]<>NIL then
									if people[lp2]^.charisma=t then
										begin
										wrtint(ob[who].connect,count);
										tab(ob[who].connect,4);
										wrst(ob[who].connect,people[lp2]^.name);
										tab(ob[who].connect,26);
										wrtint(ob[who].connect,people[lp2]^.charisma);
										count:=count+1;
										cr(ob[who].connect);
										end;
							end;
					until (top=0) or (count>10);
					end;
				95:
					begin
					wrtln(ob[who].connect,'The "Bottom ten" - charismata.');
					count:=1;
					top:=-100000;
					found:=-1;
					repeat
						t:=0;
						for lp:=1 to no_people do
							if people[lp]<>NIL then
								if (people[lp]^.charisma<t) and (people[lp]^.charisma>top) then
									begin
									found:=lp;
									t:=people[lp]^.charisma;
									end;
						top:=t;
						if (found<>-1) and (t<>0) then
							begin
							for lp2:=1 to no_people do
								if people[lp2]<>NIL then
									if people[lp2]^.charisma=t then
										begin
										wrtint(ob[who].connect,count);
										tab(ob[who].connect,4);
										wrst(ob[who].connect,people[lp2]^.name);
										tab(ob[who].connect,26);
										wrtint(ob[who].connect,people[lp2]^.charisma);
										count:=count+1;
										cr(ob[who].connect);
										end;
							end;
					until (top=0) or (count>10);
					end;
				30:
					begin	
					wrtln(ob[who].connect,'The "Top ten" - kills.');
					count:=1;
					top:=204800;
					found:=-1;
					repeat
						t:=0;
						for lp:=1 to no_people do
							if people[lp]<>NIL then
								if (people[lp]^.sc<204800) and (people[lp]^.kills>t) and (people[lp]^.kills<top) then
									begin
									found:=lp;
									t:=people[lp]^.kills;
									end;
						top:=t;
						if (found<>-1) and (t<>0) then
							begin
							for lp2:=1 to no_people do
								if people[lp2]<>NIL then
									if (people[lp2]^.kills=t) and (people[lp2]^.sc<204800) then
										begin
										wrtint(ob[who].connect,count);
										tab(ob[who].connect,4);
										wrst(ob[who].connect,people[lp2]^.name);
										tab(ob[who].connect,26);
										wrtint(ob[who].connect,people[lp2]^.kills);
										count:=count+1;
										cr(ob[who].connect);
										end;
							end;
					until (top=0) or (count>10);
					end;
				otherwise
					wrtln(ob[who].connect,'Don''t know about that league.');
				end;
	end;

function find_liquid(who, wtyp : integer; var single : boolean) : integer;

var search,
    lp,
    bottom	: integer;
    found	: boolean;

	begin
	found:=false;
	single:=false;
	search:=1;
	bottom:=0;
	repeat
		if (wtyp=0) or (wtyp=search) then
			for lp:=bottom+1 to bottom+liquids[search].howmany do
				if ob[who].location=liqloc[lp] then
					found:=true;
		bottom:=bottom+liquids[search].howmany;
		search:=search+1;
	until found or (search>no_liquids);
	if found then
		search:=search-1
	else
		for lp:=1 to no_ob do
			if not(found) then
				if not(ob[lp].mobile) then
					if (ob[lp].carries=who) or (ob[lp].location=ob[who].location) then
						if ob[lp].c_liquid then
							begin
							if wtyp=0 then
								begin
								if ob[lp].liquid>0 then
									found:=true;
								end
							else
								if ob[lp].liquid=wtyp then
									found:=true;
							if found then
								{ make a note of }
								begin
								single:=true;
								search:=ob[lp].liquid;
								if lp<>221 then
									ob[lp].liquid:=0;
								end;
							end;
	if not(found) and places[ob[who].location].wet then
		begin
		search:=3;
		found:=true;
		end;
	if found then
		find_liquid:=search
	else
		find_liquid:=0;
	end;

procedure drink(who : integer);

var whatdrink,
    temp	: integer;
    tempb	: boolean;

	begin
	if (no_com>2) or ((no_com=2) and (commands[2].which<>7)) then
		interr(who,2)
	else
		begin
		if no_com=1 then
			whatdrink:=find_liquid(who,0,tempb)
		else
			whatdrink:=find_liquid(who,commands[2].liquid,tempb);
		if whatdrink=0 then
			wrtln(ob[who].connect,'You didn''t find anything to drink.')
		else
			begin
			{ have now drunk something... }
			act(who,concat('drinks some ',liquids[whatdrink].describe,'.'),true,false);
			wrst(ob[who].connect,'You drink some ');
			wrst(ob[who].connect,liquids[whatdrink].describe);
			wrtln(ob[who].connect,'.');
			case whatdrink of
				1,2:
					begin
					ob[who].thirsty:=ob[who].thirsty-(20+rnd(10));
					if ob[who].thirsty<0 then
						ob[who].thirsty:=0;
					if whatdrink=2 then
						if rnd(6)=1 then
					   		begin
					   		if (ob[who].con>10) then
					   			begin
					   			wrtln(ob[who].connect,'The ooze makes you feel distinctly unwell.');
					   			ob[who].con:=ob[who].con-10;
					   			change_st(who,-20);
					   			end
					   		else
				   				begin
					   			wrtln(ob[who].connect,'Your head swims, your knees buckle and you sink to the ground.');
					   			act(who,'dies of a severe case of dirty water.',true,false);
					   			dead(who);
					   			end;
					   		end
						else
							wrtln(ob[who].connect,'You''ll probably get typhoid, but never mind...');
					end;
				3:
					begin
					wrtln(ob[who].connect,'The salt water only makes you thirstier.');
					ob[who].thirsty:=ob[who].thirsty+10;
					end;
				4,5:
					begin
					wrtln(ob[who].connect,'Delicious!');
					ob[who].thirsty:=ob[who].thirsty-(20+rnd(10));
					if ob[who].thirsty<0 then
						ob[who].thirsty:=0;
					addlimit(ob[who].con,ob[who].max_con,1+rnd(2));
					stam_display(who);
					temp:=5+rnd(5);
					de_drunk(who,-temp);
					if ob[who].drunk>35 then
						wrtln(ob[who].connect,'You are drunk.');
					if ob[who].drunk>70 then
						wrtln(ob[who].connect,'In fact, you are absolutely smashed.');
					if ob[who].drunk>80 then
						begin
						wrtln(ob[who].connect,'To be blunt about this, you have just died of alcohol poisoning.');
						act(who,'has drunk too much alcohol...',true,false);
						dead(who);
						end
					else
						if (rnd(ob[who].drunk)>40) and (rnd(4)=1) then
							begin
							wrtln(ob[who].connect,'You fall into a drunken stupor.');
							act(who,'falls into a drunken stupor.',true,false);
							ob[who].sleep:=true;
							set_event(1,who,0,2500+rnd(2000));
							end;
					end;
				6:
					begin
					temp:=rnd(7);
					case temp of
						1:
							begin
							wrtln(ob[who].connect,'You have started to glow!');
							act(who,'starts to glow!',true,false);
							ob[who].glowing:=true;
							end;
						2:
							begin
							wrtln(ob[who].connect,'You have become invisible!');
							ob[who].invisible:=true;
							act(who,'vanishes away.',true,false);
							if f_level(who)<12 then
								set_event(18,who,0,30000+rnd(30000));
							end;
						3:
							begin
							wrtln(ob[who].connect,'You have acquired a magical shield!');
							if f_level(who)<12 then
								set_event(19,who,0,30000+rnd(30000));
							ob[who].shield:=true;
							act(temp,'acquires a magical shield.',true,false);
							end;
						4:
							begin
							wrtln(ob[who].connect,'You have lost your voice!');
							ob[who].dumb:=true;
							end;
						5:
							begin
							wrtln(ob[who].connect,'You have gone blind!');
							ob[who].blind:=true;
							end;
						6:
							begin
							wrtln(ob[who].connect,'You have gone deaf!');
							ob[who].deaf:=true;
							end;
						7:
							wrtln(ob[who].connect,'Nothing happens.');
						end;
					end;
				7:
			   		if (ob[who].con>30) then
			   			begin
			   			wrtln(ob[who].connect,'The acid burns your mouth and you spit it out.');
			   			ob[who].con:=ob[who].con-30;
			   			end
			   		else
		   				begin
			   			wrtln(ob[who].connect,'You incautiously take a swig of the acid and sink to the ground.');
			   			act(who,'dies of the effects.',true,false);
			   			dead(who);
			   			end;
				end;
			end;
		end;
	end;

procedure fill_object(who,what,withwhat : integer; errors : boolean);

	begin
	if not(ob[what].c_liquid) then
		err(who,6,errors)
	else
		if ob[what].carries<>who then
			err(who,8,errors)
		else
			begin
			doubleact(who,what,'fills',true,false,true);
			ob[what].liquid:=withwhat;
			curcno:=curcno+1;
			wrst(ob[who].connect,'Filled ');
			shortname(what,who,false,false,false);
			wrtln(ob[who].connect,'.');
			end;
	end;

procedure fill(who : integer);

var withwhat	: integer;
    single	: boolean;

	begin
	withwhat:=0;
	if (no_com=4) and (commands[3].which=1) and (commands[3].vb=149) and (commands[4].which=7) then
		begin
		no_com:=2;
		withwhat:=commands[4].liquid;
		end;
	if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
		interr(who,3)
	else
		begin
		withwhat:=find_liquid(who,withwhat,single);
		if withwhat=0 then
			wrtln(ob[who].connect,'There''s no liquid around that you can fill with.')
		else
			begin
			if single then
				single:=cant_extract(who,commands[2]);
			if commands[2].which=2 then
				fill_object(who,commands[2].object,withwhat,true)
			else
				begin
				init_categ(commands[2].category);
				while doingcat do
					fill_object(who,curob,withwhat,false);
				if curcno=0 then
					wrtln(ob[who].connect,'There was nothing around that you could fill.');
				end;
			end;
		end;
	end;

procedure view(who : integer);

var temp,
    temp2	: integer;
    v_or_b_tmp	: boolean;
    
	begin
	if no_com<>2 then
		interr(who,1)
	else
		begin
		temp:=extract_loc(commands[2]);
		if temp=0 then
			interr(who,5)
		else
			if c_spell(who,4,10,0,4,0,17)<>0 then
				if forbidden(who,temp) then
					wrtln(ob[who].connect,tdata[189])
				else
					begin
					temp2:=ob[who].location;
					ob[who].location:=temp;
					v_or_b_tmp:=people[position[ob[who].connect,5]]^.brief;
					people[position[ob[who].connect,5]]^.brief:=false;
					look(who,false);
					tellall(temp,who,'You feel as if something is looking at you.',false,false);
					people[position[ob[who].connect,5]]^.brief:=v_or_b_tmp;
					ob[who].location:=temp2;
					end;
		end;
	end;

procedure follow_sb(who : integer);

	begin
	if (no_com<>2) or cant_extract(who,commands[2]) then
		interr(who,3)
	else
		if ob[commands[2].object].location<>ob[who].location then
			err(who,7,true)
		else
			if ob[commands[2].object].mobile and (commands[2].object<>who) then
				if no_fol=50 then
					begin
					wrtln(ob[who].connect,'Too many people following already.');
					log('Follow allocation exceeded.');
					end
				else
					begin
					stop_follow(who,true,false);
					no_fol:=no_fol+1;
					follows[no_fol,1]:=who;
					follows[no_fol,2]:=commands[2].object;
					wrst(ob[who].connect,'You are now following ');
					shortname(commands[2].object,who,false,false,false);
					wrtln(ob[who].connect,'.');
					doubleact(who,commands[2].object,'starts to follow',true,false,true);
					shortname(who,commands[2].object,true,false,true);
					wrtln(ob[commands[2].object].connect,' has started to follow you.');
					ob[commands[2].object].dislike:=who;
					end
			else
				err(who,6,true);
	end;

procedure lose_sone(who : integer);

var found	: boolean;
    lp		: integer;

	begin
	if (no_com<>2) or cant_extract(who,commands[2]) then
		interr(who,3)
	else
		if ob[commands[2].object].location<>ob[who].location then
			err(who,7,true)
		else
			if ob[commands[2].object].mobile then
				begin
				for lp:=1 to no_fol do
					if (follows[lp,2]=who) and (follows[lp,1]=commands[2].object) then
						found:=true;
				if found then
					if (ob[who].dex+rnd(100))>(ob[commands[2].object].dex+rnd(40)) then
						stop_follow(commands[2].object,true,false)
					else
						begin
						wrtln(ob[who].connect,'You fail to shake off your pursuer.');
						wrtln(ob[commands[2].object].connect,'The person you''re following is trying to lose you.');
						doubleact(who,commands[2].object,'is trying to lose',true,false,true);
						end
				else
					wrtln(ob[who].connect,'That''s not following you!');
				end
			else
				err(who,6,true);
	end;

procedure jump(who : integer);

var newloc	: integer;

	begin
	newloc:=0;
	case ob[who].location of
		46,438,439,477,146,147,148,149,150,151,265,266,267,600,599,601,593,583,49,88,115,425,814,811:
			begin
			act(who,'leaps and plummets to # doom far below!',true,false);
			wrtln(ob[who].connect,'You plummet to your death far below.');
			dead(who);
			end;
		122:
			begin
			newloc:=29;
			wrtln(ob[who].connect,'You get a soft landing on the sand.');
			end;
		562,662:
			begin
			act(who,'jumps down the pit!',true,false);
			wrtln(ob[who].connect,'You leap down the pit, where magical forces disintegrate you.');
			dead(who);
			end;
		508,507:
			begin
			wrtln(ob[who].connect,'You fall and land, winded, in the room below.');
			newloc:=506;
			end;
		129,130:
			begin
			wrtln(ob[who].connect,'You land unharmed in the deep snow below.');
			newloc:=131;
			end;
		247,697,688,704,793,881,880,878:
			wrtln(ob[who].connect,'Don''t jump! Think of the mess it would make...');
		170,161,200,201:
			begin
			wrtln(ob[who].connect,'You leap away from the rock and hurtle down to land with a splash below.');
			newloc:=195;
			end;
		260,261,262,263,264:
			begin
			wrtln(ob[who].connect,'You land, winded but unhurt, in the glade below.');
			newloc:=8;
			end;
		113,119,120,121:
			wrtln(ob[who].connect,'This isn''t MUD, you know! Leaping over cliffs tends to kill you!');
		794,795:
			begin
			act(who,'leaps over the edge into the acid lake. Fizzzzz...',true,false);
			wrtln(ob[who].connect,'You leap into the acid lake. This is a bad idea.');
			dead(who);
			end;
		812:
			begin
			newloc:=813;
			wrtln(ob[who].connect,'You get a soft landing on some ashes.');
			end;
		otherwise
			begin
			act(who,'jumps up and down.',true,false);
			wrtln(ob[who].connect,'Boing! boing! boing!');
			end;
		end;
	if newloc<>0 then
		begin
		flee(who);
		act(who,'jumps down.',true,false);
		ob[who].location:=newloc;
		look(who,true);
		if ob[who].location<>-1 then
			act(who,'falls from above.',true,false);
		end;
	end;

procedure gs(who, temp : integer; short,errors : boolean);

var go	: boolean;
    lp	: integer;

	begin
	if ob[temp].mobile then
		begin
		go:=who=temp;
		if not(go) then
			begin
			lp:=c_spell(who,8,5,temp,0,0,0);
			if forbidden(who,ob[temp].location) or (lp=2) then
				begin
				if errors then
					wrtln(ob[who].connect,tdata[189]);
				lp:=2;
				end;
			go:=lp=1;
			curstop:=lp=0;
			end;
		if go then
			begin
			curcno:=curcno+1;
			if short then
				begin
				wrst(ob[who].connect,ob[temp].name);
				tab(ob[who].connect,18);
				wrst(ob[who].connect,'Lev ');
				wrtint(ob[who].connect,f_level(temp));
				tab(ob[who].connect,25);
				wrst(ob[who].connect,'Sc ');
				wrtint(ob[who].connect,ob[temp].sc);
				cr(ob[who].connect);
				wrst(ob[who].connect,'Strength  ');
				wrtint(ob[who].connect,ob[temp].st);
				send(ob[who].connect,'/');
				wrtint(ob[who].connect,ob[temp].max_st);
				tab(ob[who].connect,18);
				wrst(ob[who].connect,'Dexterity ');
				wrtint(ob[who].connect,ob[temp].dex);
				send(ob[who].connect,'/');
				wrtint(ob[who].connect,ob[temp].max_dex);
				cr(ob[who].connect);
				tab(ob[who].connect,0);
				wrst(ob[who].connect,'Stamina   ');
				wrtint(ob[who].connect,ob[temp].con);
				send(ob[who].connect,'/');
				wrtint(ob[who].connect,ob[temp].max_con);
				tab(ob[who].connect,18);
				if ob[temp].class>1 then
					begin
					if ob[temp].class=2 then
						wrst(ob[who].connect,'Concent''n ')
					else
						wrst(ob[who].connect,'Magic     ');
					wrtint(ob[who].connect,ob[temp].magic);
					send(ob[who].connect,'/');
					wrtint(ob[who].connect,ob[temp].max_magic);
					end;
				cr(ob[who].connect);
				end
			else
				with ob[who] do
					begin
					fullname(temp,who);
					wrst(connect,'Level ');
					wrtint(connect,f_level(temp));
					if ob[temp].male then
						wrst(connect,' male ')
					else
						wrst(connect,' female ');
					wrst(connect,races[ob[temp].race]);
					case ob[temp].class of
						1:
							wrtln(connect,' warrior.');
						2:
							wrtln(connect,' ranger.');
						3:
							wrtln(connect,' magic user.');
						4:
							wrtln(connect,' priest.');
						end;
					if ob[temp].drunk>35 then
						wrtln(connect,'Drunk.');
					if ob[temp].thirsty>49 then
						wrtln(connect,'Thirsty.');
					if ob[temp].sleep then
						wrtln(connect,'Asleep.');
					wrst(connect,'Score         : ');
					wrtint(connect,ob[temp].sc);
					cr(connect);
					if f_level(temp)<12 then
						begin
						wrst(connect,'Value/killed  : ');
						wrtint(connect,mobile_value(temp));
						cr(connect);
						end;
					wrst(connect,'Strength      : ');
					wrtint(connect,ob[temp].st);
					send(connect,'/');
					wrtint(connect,ob[temp].max_st);
					cr(connect);
					wrst(connect,'Dexterity     : ');
					wrtint(connect,ob[temp].dex);
					send(connect,'/');
					wrtint(connect,ob[temp].max_dex);
					cr(connect);
					wrst(connect,'Stamina       : ');
					wrtint(connect,ob[temp].con);
					send(connect,'/');
					wrtint(connect,ob[temp].max_con);
					cr(connect);
					if ob[temp].class>2 then
						begin
						wrst(connect,'Magic stamina : ');
						wrtint(connect,ob[temp].magic);
						send(connect,'/');
						wrtint(connect,ob[temp].max_magic);
						cr(connect);
						end;
					if ob[temp].class=2 then
						begin
						wrst(connect,'Concentration : ');
						wrtint(connect,ob[temp].magic);
						send(connect,'/');
						wrtint(connect,ob[temp].max_magic);
						cr(connect);
						end;
					if ob[temp].control<>0 then
						begin
						wrst(connect,'Charisma      : ');
						wrtint(connect,people[ob[temp].control]^.charisma);
						cr(connect);
						wrst(connect,'Kills         : ');
						wrtint(connect,people[ob[temp].control]^.kills);
						cr(connect);
						end;
					if ob[temp].contdesc<>0 then
						begin
						wrst(connect,'Weight held   : ');
						wrtint(connect,weigh(temp)-ob[temp].weight);
						cr(connect);
						end;
					wrst(connect,'Spells        : ');
					if ob[temp].possessed then
						begin
						wrst(connect,'possessed by ');
						shortname(who_possesses(temp),who,false,false,false);
						send(connect,' ');
						end;
					if ob[temp].blind then
						wrst(connect,'blind ');
					if ob[temp].deaf then
						wrst(connect,'deaf ');
					if ob[temp].dumb then
						wrst(connect,'dumb ');
					if ob[temp].crippled then
						wrst(connect,'crippled ');
					if ob[temp].glowing then
						wrst(connect,'glowing ');
					if ob[temp].invisible then
						wrst(connect,'invisible ');
					if ob[temp].cursed then
						wrst(connect,'accursed ');
					if ob[temp].blessed then
						wrst(connect,'blessed ');
					if ob[temp].shield then
						wrst(connect,'shielded ');
					for lp:=1 to 20 do
						if resisting[lp]=temp then
							wrst(connect,'resisting spells ');
					cr(connect);
					end;
			end;
		end
	else
		err(who,6,errors);
	end;

procedure get_sc(who : integer);

var temp : integer;

	begin
	temp:=0;
	if no_com=1 then
		gs(who,who,commands[1].vb=158,true)
	else
		if (no_com=2) and (commands[2].which=2) then
			gs(who,commands[2].object,commands[1].vb=158,true)
		else
			if (no_com=2) and (commands[2].which=3) then
				begin
				init_categ(commands[2].category);
				while doingcat do
					gs(who,curob,commands[1].vb=158,false);
				if curcno=0 then
					wrtln(ob[who].connect,'No scores obtained.');
				end
			else
				interr(who,3);
	end;

procedure say_something(who : integer);

var lp,
    temp	: integer;
    tempst	: string[255];

	begin
	with ob[who] do
		begin
		tempst:='';
		if no_com=1 then
			tempst:=concat(verb[commands[1].vb],'s something you don''t quite catch.')
		else
			if (no_com=2) and (commands[2].which=5) then
				if isan(commands[2].quoted[length(commands[2].quoted)]) then
					tempst:=concat(verb[commands[1].vb],'s "',commands[2].quoted,'."')
				else
					tempst:=concat(verb[commands[1].vb],'s "',commands[2].quoted,'"')
			else
				interr(who,2);
		if tempst<>'' then
			if dumb then
				wrtln(connect,'You cannot speak!')
			else
				begin
				act(who,tempst,false,true);
				if lcompare(commands[2].quoted,'open sesame') and (location=420) then
					if not(sesame) then
						begin
						sesame:=true;
						wrtln(connect,tdata[63]);
						end;
				if lcompare(commands[2].quoted,'vagabond') and (location=831) then
					if ob[208].location=775 then
						begin
						ob[208].location:=831;
						act(208,'falls from the painting at your feet!',true,false);
						end;
				if lcompare(commands[2].quoted,'abracadabra') and (location=816) then
					if ob[221].location=816 then
						begin
						temp:=0;
						for lp:=1 to no_ob do
							if ob[lp].carries=221 then
								begin
								if (lp=57) or (lp=59) or (lp=75) or (lp=128) or (lp=78) or (lp=220) or (lp=186) or (lp=251) then
									temp:=temp+1
								else
									temp:=-1;
								lose(221,lp,false,false);
								remove_object(lp);
								end;
						if temp>=7 then
							begin
							act(221,'gives off a puff of bright green smoke and vanishes dramatically.',true,false);
							wrtln(connect,'The spell has succeeded!');
							score_point(who,1000);
							mu_chance(who);
							remove_object(221);
							end
						else
							begin
							act(221,'explodes violently.',true,false);
							wrtln(connect,'The spell has failed! You need all the right ingredients.');
							remove_object(221);
							end;
						end;
				if ob[152].fighting=who then
					begin
					junk:=commands[2].quoted;
					lower(junk);
					if (pos(riddle[c_riddle].answer1,junk)>0) or (pos(riddle[c_riddle].answer2,junk)>0) then
						begin
						act(152,'smiles benignly and makes a magic pass.',true,false);
						score_point(who,50);
						stop_fight(152);
						end
					else
						begin
						act(152,'frowns sternly and stamps a foot.',true,false);
						score_point(who,-80);
						stop_fight(152);
						end;
					end;
				if location=690 then
					begin
					tellall(690,0,'ZAP! Talking in the library is forbidden!',true,false);
					act(who,'is struck dead for talking in the library!',true,false);
					dead(who);
					end;
				if (location=830) and (control>0) and not(possessed) then
					if (sc<204800) then
						begin
						junk:=commands[2].quoted;
						lower(junk);
						if pos('wizard',junk)>0 then
							begin
							{ become a wizard }
							wrtln(connect,'You will now begin your training in the use of magic.');
							log(concat(ob[who].name,' has decided to become a magic user.'));
							class:=3;
							magic:=(max_con DIV 3)*2;
							max_magic:=magic;
							ban(control,connect,1);
							temp:=connect;
							logoff(who);
							show_main_menu(temp,false);
							end
						else
							if pos('priest',junk)>0 then
								begin
								{ become a priest }
								wrtln(connect,'You will now begin your initiation into the priesthood.');
								log(concat(ob[who].name,' has decided to become a priest.'));
								class:=4;
								magic:=(max_con DIV 3)*2;
								max_magic:=magic;
								ban(control,connect,1);
								temp:=connect;
								logoff(who);
								show_main_menu(temp,false);
								end
							else
								if pos('ranger',junk)>0 then
									begin
									{ become a ranger }
									wrtln(connect,'You will now begin your training as a ranger.');
									log(concat(ob[who].name,' has decided to become a ranger.'));
									class:=2;
									magic:=50;
									max_magic:=magic;
									ban(control,connect,1);
									temp:=connect;
									logoff(who);
									show_main_menu(temp,false);
									end;
						end
					else
						wrtln(connect,'The Gods forbid Immortals to change their class.');
				if (commands[1].vb=185) and (no_com=2) then
					if class=4 then
						for lp:=1 to no_ob do
							if ob[lp].location<>-1 then
								if ob[lp].mobile then
									if ob[lp].sc>409599 then
										begin
										shortname(who,lp,true,false,false);
										send(ob[lp].connect,' ');
										wrtln(ob[lp].connect,tempst);
										end;
				end;
		end;
	end;

procedure wish_s(who : integer);

	begin
	if (no_com=2) and (commands[2].which=5) then
		begin
		log(concat(ob[who].name,' wishes "',commands[2].quoted,'".'));
		wrtln(ob[who].connect,'Your wish has been logged and will be attended to in due course...');
		end
	else
		interr(who,2);
	end;

procedure keep_object(who,what : integer; errors : boolean);

	begin
	if ob[what].carries<>who then
		err(who,8,errors)
	else
		begin
		ob[what].kept:=true;
		wrst(ob[who].connect,'You''re now keeping ');
		shortname(what,who,false,false,false);
		wrtln(ob[who].connect,'.');
		curcno:=curcno+1;
		end;
	end;

procedure keep_s(who : integer);

	begin
	if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
		interr(who,3)
	else
		if commands[2].which=2 then
			keep_object(who,commands[2].object,true)
		else
			begin
			init_categ(commands[2].category);
			while doingcat do
				keep_object(who,curob,false);
			if curcno=0 then
				wrtln(ob[who].connect,'There''s nothing around of that type that you can keep.');
			end;
	end;

procedure m_open(who : integer);

	begin
	lp:=find_door(ob[who].location);
	if lp=0 then
		wrtln(ob[who].connect,'There''s no door here!')
	else
		if c_spell(who,10,15,0,4,3,18)=1 then
			if doors[lp].openable and (lp<>23) then
				begin
				doors[lp].open:=true;
				dsall(lp);
				end
			else
				wrtln(ob[who].connect,'Your spell is counteracted.');
	end;

procedure ex(who,what : integer; errors : boolean);

	begin
	if ob[what].mobile then
		if ob[what].location=ob[who].location then
			if (ob[what].race=8) or (ob[what].race=9) then
				begin
				curcno:=curcno+1;
				lp:=c_spell(who,4,40,commands[2].object,4,4,19);
				if lp>0 then
					begin
					shortname(who,what,true,false,true);
					wrtln(ob[what].connect,'tries to exorcise you.');
					ob[what].dislike:=who;
					end;
				if lp=2 then
					begin
					wrtln(ob[who].connect,'The spell is resisted, causing you to fall asleep.');
					act(who,'falls asleep.',true,false);
					ob[who].sleep:=true;
					set_event(1,who,0,1000+rnd(1000));
					if what=105 then
						wrtln(ob[who].connect,'(Find some equipment to lay the ghost, then use it!)');
					end;
				if lp=1 then
					begin
					wrtln(ob[what].connect,'You are exorcised! Your spirit flees from your body...');
					act(what,'slumps to the ground as # spirit leaves # body.',true,false);
					dead(what);
					end;
				end
			else
				begin
				if errors then
					wrtln(ob[who].connect,'That can''t be done... not a demon or undead creature.')
				end
		else
			err(who,7,errors)
	else
		err(who,6,errors);
	end;

procedure exorc(who : integer);

	begin
	if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
		interr(who,3)
	else
		begin
		if commands[2].which=2 then
			ex(who,commands[2].object,true)
		else
			begin
			init_categ(commands[2].category);
			while doingcat do
				ex(who,curob,false);
			if curcno=0 then
				wrtln(ob[who].connect,'You didn''t find anything to exorcise.');
			end;
		end;
	end;

procedure throw_s(who : integer);

var danger,
    temp,
    atwho,
    what	: integer;

	begin
	atwho:=-1;
	if (no_com=2) then
		if cant_extract(who,commands[2]) then
			scenerr(who,2,2,commands[2])
		else
			if ob[who].fighting=0 then
				wrtln(ob[who].connect,'You aren''t fighting anyone.')
			else
				begin
				atwho:=ob[who].fighting;
				what:=commands[2].object;
				end
	else
		if (no_com=4) then
			if (commands[3].which<>1) or (commands[3].vb<>198) or cant_extract(who,commands[2]) or cant_extract(who,commands[4]) then
				scenerr(who,2,2,commands[2])
			else
				begin
				what:=commands[2].object;
				atwho:=commands[4].object;
				end
		else
			interr(who,2);
	if atwho<>-1 then
		if ob[what].carries<>who then
			err(who,8,true)
		else
			if ob[atwho].location<>ob[who].location then
				err(who,7,true)
			else
				if not(ob[atwho].mobile) or (atwho=who) then
					err(who,6,true)
				else
					if ob[what].throw=0 then
						wrtln(ob[who].connect,'That''s no use for throwing.')
					else
						begin
						tripleact(who,what,atwho,'throws','at',true,true);
						if not(ob[atwho].sleep) then
							begin
							shortname(who,atwho,true,false,true);
							wrst(ob[atwho].connect,' throws ');
							shortname(what,atwho,false,false,true);
							wrst(ob[atwho].connect,' at you. ');
							end;
						lose(who,what,true,true);
						if (ob[who].location=-1) or (ob[what].location=-1) then
							cr(ob[atwho].connect)
						else
							if ob[who].dex<rnd(rnd(200)) then
								begin
								doubleact(what,atwho,'misses',true,false,true);
								if not(ob[atwho].sleep) then
									wrtln(ob[atwho].connect,'It misses you by a wide margin.');
								end
							else
								if ((ob[who].dex+rnd(40))<(ob[atwho].dex+rnd(80)))
								   and not(ob[atwho].sleep) and not(ob[atwho].blind) then
									begin
									doubleact(atwho,what,'dodges',true,false,true);
									wrtln(ob[atwho].connect,'You manage to dodge it.');
									end
								else
									{ gotcha! }
									begin
									doubleact(what,atwho,'hits',true,false,true);
									if ob[atwho].sleep then
										begin
										wake(atwho);
										shortname(what,atwho,true,false,true);
										wrtln(ob[atwho].connect,' has been thrown at you, and hits you!');
										end
									else
										wrtln(ob[atwho].connect,'It hits you!');
									danger:=ob[what].throw+rnd(5)+(ob[who].dex div 50);
									if ob[who].class=2 then danger:=danger+rnd(3);
									for temp:=30 to no_ob do
										if not(ob[temp].mobile) then
											if ob[temp].carries=atwho then
												if ob[temp].worn then
													danger:=danger-ob[temp].armour;
									if ob[atwho].shield then
										danger:=danger-20;
									if danger<0 then danger:=0;
									if ob[atwho].sc>204799 then
										begin
										wrst(ob[who].connect,'Your missile goes straight through your opponent as if ');
										shortname(atwho,who,false,true,true);
										wrst(ob[who].connect,' wasn''t there! ');
										shortname(atwho,who,true,true,true);
										wrtln(ob[who].connect,' can''t be killed!');
										end
									else
										begin
										danger:=ob[atwho].con-danger;
										if danger<0 then
											if (atwho=ob[who].fighting) or (ob[atwho].fighting=who) then
												dead_dead(atwho,who)
											else
												half_dead(atwho,who)
										else
											begin
											ob[atwho].con:=danger;
											stam_display(atwho);
											end;
										end;
									end;
						end;
	end;

procedure interpret(who : integer);
	forward;

procedure mobcomm(who : integer);

var tempst	: str255;
    temp2st	: in_buffer;
    what	: integer;	

	begin
	if (commands[2].which<>5) or (no_com<>2) then
		interr(who,2)
	else
		begin
		what:=commands[1].object;
		if ob[what].mobile then
			if ob[what].location=ob[who].location then
				if ob[who].dumb then
					wrtln(ob[who].connect,'You can''t speak!')
				else
					begin
					if isan(commands[2].quoted[length(commands[2].quoted)]) then
						tempst:=concat('says "',commands[2].quoted,'." to')
					else
						tempst:=concat('says "',commands[2].quoted,'" to');
					doubleact(who,what,tempst,false,true,true);
					if who=what then
						tellall(ob[who].location,who,'And we all know what the first sign of madness is, don''t we...',false,true);
					if not(ob[what].deaf) and not(ob[what].sleep) then
						begin
						shortname(who,what,true,false,true);
						send(ob[what].connect,' ');
						wrst(ob[what].connect,tempst);
						wrtln(ob[what].connect,' you.');
						if (ob[who].fighting=152) and (what=152) then
							begin
							junk:=commands[2].quoted;
							lower(junk);
							if (pos(riddle[c_riddle].answer1,junk)>0) or (pos(riddle[c_riddle].answer2,junk)>0) then
								begin
								act(152,'smiles benignly and makes a magic pass.',true,false);
								score_point(who,50);
								stop_fight(who);
								act(152,'vanishes in a flash!',true,false);
								ob[152].location:=317;
								end
							else
								begin
								act(152,'frowns sternly and stamps a foot.',true,false);
								score_point(who,-80);
								stop_fight(who);
								act(152,'vanishes in a flash!',true,false);
								ob[152].location:=317;
								end;
							end
						else
							if (ob[what].obey=-3) or (ob[what].obey=who) or 
							   ((ob[what].obey=0) and (f_level(who)>12)) then
								begin
								temp2st:=commands[2].quoted;
								if parse(ob[who].connect,temp2st,false,who) then
									begin
									whosays:=who;
									interpret(what);
									whosays:=0;
									end
								else
									moberr(what);
								if (ob[what].location<>-1) and (ob[who].location<>-1) then
									begin
									lp:=ob[what].dex+ob[what].st-ob[who].dex-ob[who].st;
									if lp>0 then
										if rnd(lp)>25 then
											if ob[what].obey=who then
												begin
												ob[what].dislike:=who;
												ob[what].obey:=0;
												act(what,'shouts "I will serve no more!"',false,true);
												start_fight(what,who);
												end;
									end;
								end;
						end;
					if ob[who].location=690 then
						begin
						tellall(690,0,'ZAP! Talking in the library is forbidden!',true,false);
						act(who,'is struck dead for talking in the library!',true,false);
						dead(who);
						end;
					end
			else
				err(who,7,true)
		else
			err(who,6,true);
		end;
	end;

procedure conjure(who : integer);

	begin
	if (ob[226].location=317) or (ob[226].location=-1) then
		begin
		if c_spell(who,2,80,0,4,2,20)=1 then
			with ob[226] do
				begin
				mobile:=true;
				location:=317;
				carries:=0;
				control:=0;
				weapon1:=0;
				weapon2:=0;
				fighting:=0;
				dislike:=0;
				thirsty:=0;
				drunk:=0;
				possessed:=false;
				blind:=false;
				male:=rnd(2)=1;
				glowing:=false;
				deaf:=false;
				dumb:=false;
				crippled:=false;
				invisible:=false;
				cursed:=false;
				blessed:=false;
				sleep:=false;
				{ now we decide what the object actually is }
				if f_level(who)<2+rnd(5) then
					begin
					{ a zombie }
					name:='zombie';
					location:=317;
					descr:=33;
					contdesc:=41;
					size:=1500;
					weight:=1700;
					movem:='slouches';
					st:=130;
					dex:=90;
					con:=170;
					magic:=0;
					max_st:=130;
					max_dex:=90;
					max_con:=170;
					max_magic:=0;
					race:=9;
					class:=1;
					sc:=15000;
					end
				else
					if f_level(who)<5+rnd(5) then
						begin
						{ a ghoul }
						name:='ghoul';
						descr:=26;
						contdesc:=42;
						size:=1500;
						weight:=1200;
						movem:='lurches';
						st:=170;
						dex:=130;
						con:=200;
						magic:=180;
						max_st:=170;
						max_dex:=130;
						max_con:=200;
						max_magic:=180;
						race:=9;
						class:=4;
						sc:=30000;
						end
					else
						begin
						{ a fiend }
						name:='fiend';
						descr:=27;
						contdesc:=42;
						size:=1500;
						weight:=1600;
						movem:='slinks';
						st:=200;
						dex:=230;
						con:=220;
						magic:=220;
						max_st:=200;
						max_dex:=230;
						max_con:=220;
						max_magic:=220;
						race:=8;
						class:=3;
						sc:=45000;
						end;
				act(226,'is summoned away.',true,false);
				ob[226].location:=ob[who].location;
				wrtln(ob[226].connect,'You are summoned!');
				act(226,'appears in a flash!',true,false);
				act(226,'says "What is your bidding, O Master?"',false,true);
				ob[226].obey:=who;
				end;
		end
	else
		wrtln(ob[who].connect,'There are no spirits currently available in the vasty deep.');
	end;

procedure subdue(who : integer);

	begin
	if (no_com<>2) or cant_extract(who,commands[2]) then
		interr(who,3)
	else
		if ob[commands[2].object].location<>ob[who].location then
			err(who,7,true)
		else
			if not(ob[commands[2].object].mobile) then
				err(who,6,true)
			else
				if commands[2].object=who then
					wrtln(ob[who].connect,'Control yourself!')
				else
					if ob[who].obey<>-2 then
						wrtln(ob[who].connect,'You don''t have sufficient force of personality to use that spell.')
					else
						if c_spell(who,3,60,0,4,5,21)=1 then
							case ob[commands[2].object].obey of
								-1:
									wrtln(ob[who].connect,'That''s too stupid to be subdued.');
								-2:
									wrtln(ob[who].connect,'That has too high an intelligence to be subdued.');
								otherwise
									begin
									ob[commands[2].object].obey:=who;
									act(commands[2].object,'says "I obey, O Master."',false,true);
									ob[commands[2].object].dislike:=who;
									end;
								end;
	end;

procedure shoot_s(who,what : integer; error : boolean);

var lp,
    distance,
    danger	: integer;

	begin
	if ob[what].mobile then
		if what=who then
			err(who,6,error)
		else
			begin
			distance:=0;
			if ob[what].location=ob[who].location then
				distance:=1
			else
				for lp:=1 to 12 do
					if ob[what].location=places[ob[who].location].value[lp] then
						distance:=2;
			if distance>0 then
				begin
				curcno:=curcno+1;
				ob[ob[who].weapon1].bolts:=ob[ob[who].weapon1].bolts-1;
				if ob[ob[who].weapon1].bolts<=0 then
					curstop:=true;
				doubleact(who,what,'shoots an arrow at',true,false,true);
				if not(ob[what].sleep) then
					begin
					shortname(who,what,true,false,true);
					wrtln(ob[what].connect,' shoots an arrow at you!');
					ob[what].dislike:=who;
					end;
				danger:=ob[who].dex+rnd(40)-(ob[what].dex+(rnd(30)*distance));
				if ob[who].class=2 then danger:=danger+20;
				if ob[what].class=4 then danger:=danger-15;
				if cant_see_obj(who,what) then danger:=danger-20;
				if ob[what].sleep then danger:=danger+20;
				danger:=danger+((ob[what].size-1200) div 300);
				if danger>0 then
					begin
					if (cant_see_obj(who,what)) or (distance=2) then
						begin
						shortname(what,who,true,false,false);
						wrtln(ob[who].connect,' is hit by your shot!');
						end;
					if danger>30 then danger:=30;
					for lp:=30 to no_ob do
						if not(ob[lp].mobile) then
							if ob[lp].carries=what then
								if ob[lp].worn then
									danger:=danger-ob[lp].armour;
					if ob[what].shield then
						danger:=danger-20;
					if danger<0 then danger:=0;
					if f_level(what)>11 then
						begin
						wrst(ob[who].connect,'Your missile goes straight through your opponent as if ');
						shortname(what,who,false,true,true);
						wrst(ob[who].connect,' wasn''t there! ');
						shortname(what,who,true,true,true);
						wrtln(ob[who].connect,' can''t be killed!');
						end
					else
						begin
						if danger=0 then
							begin
							act(what,'is hit by an arrow, but unscathed.',true,false);
							if not(ob[what].sleep) then wrtln(ob[what].connect,'You are unharmed by the arrow.');
							end
						else
							begin
							danger:=ob[what].con-danger;
							act(what,'is wounded by an arrow.',true,false);
							if ob[what].sleep then
								begin
								wrst(ob[what].connect,'An arrow hits you! ');
								wake(what);
								end;
							if danger<0 then
								begin
								wrtln(ob[what].connect,'The arrow strikes you in a vital spot...');
								half_dead(what,who);
								end
							else
								begin
								ob[what].con:=danger;
								wrtln(ob[what].connect,'The arrow wounds you painfully!');
								stam_display(what);
								end;
							end;
						end;
					end
				else
					begin
					if (cant_see_obj(who,what)) or (distance=2) then
						begin
						shortname(what,who,true,false,false);
						wrtln(ob[who].connect,' is missed by your arrow.');
						end;
					act(what,'is narrowly missed by an arrow.',true,false);
					wrtln(ob[what].connect,'The arrow narrowly misses you.');
					end;
				end
			else
				err(who,7,error);
			end
	else
		err(who,6,error);
	end;

procedure shoot(who : integer);

	begin
	if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
		interr(who,3)
	else
		if ob[who].weapon1=0 then
			wrtln(ob[who].connect,'You''re not armed!')
		else
			if being_fought(who)>0 then
				wrtln(ob[who].connect,'You can''t use bows during a fight.')
			else
				if ob[ob[who].weapon1].bolts=0 then
					wrtln(ob[who].connect,'You can''t shoot with that!')
				else
					begin
					if commands[2].which=2 then
						shoot_s(who,commands[2].object,true)
					else
						begin
						init_categ(commands[2].category);
						while doingcat do
							shoot_s(who,curob,false);
						if curcno=0 then
							wrtln(ob[who].connect,'There''s nothing around in that category that you can shoot.');
						end;
					end;
	end;

procedure chspell(who : integer; VAR what : integer; name : string; limit : integer);

var tempst : str255;

	begin
	if (commands[4].number<limit) and (commands[4].number<>0) then
		begin
		what:=commands[4].number;
		writev(tempst,ob[who].name,' changes ',ob[commands[2].object].name,'''s ',name,' to ',commands[4].number,'.');
		log(tempst);
		wrst(ob[commands[2].object].connect,'Your ');
		wrst(ob[commands[2].object].connect,name);
		wrst(ob[commands[2].object].connect,' has been changed to ');
		wrtint(ob[commands[2].object].connect,what);
		wrtln(ob[commands[2].object].connect,'.');
		end
	else
		wrtln(ob[who].connect,'Out of range.');
	end;

procedure resist(who : integer);

var lp,
    space	: integer;

	begin
	if ob[who].class<>2 then
		wrtln(ob[who].connect,'Only Rangers have this ability.')
	else
		begin
		space:=0;
		for lp:=1 to 20 do
			begin
			if (resisting[lp]=0) and (space=0) then space:=lp;
			if resisting[lp]=who then space:=-1;
			end;
		if (space=0) or (ob[who].magic<30) then
			wrtln(ob[who].connect,'You are unable to summon the necessary concentration.')
		else
			if space=-1 then
				wrtln(ob[who].connect,'A bit pointless... you already are resisting spells!')
			else
				begin
				act(who,'seems to concentrate intensely.',true,false);
				resisting[space]:=who;
				if ob[who].sc<204800 then
					ob[who].magic:=ob[who].magic-30;
				set_event(22,space,0,50000+10*rnd(500*f_level(who)));
				wrtln(ob[who].connect,'You are now resisting spells.');
				end;
		end;
	end;
	
procedure pick(who : integer);

	begin
	if ob[who].class<>2 then
		wrtln(ob[who].connect,'Only Rangers have this ability.')
	else
		begin
		lp:=find_door(ob[who].location);
		if lp=0 then
			wrtln(ob[who].connect,'There''s no door here!')
		else
			if doors[lp].open then
				wrtln(ob[who].connect,'The door''s open, you fool!')
			else
				if ob[who].magic>4 then
					begin
					act(who,'probes the lock of the door.',true,false);
					if ob[who].sc<204800 then
						ob[who].magic:=ob[who].magic-5;
					if doors[lp].openable and (lp<>23) then
						begin
						if rnd(5)<(f_level(who)+1) then
							begin
							doors[lp].open:=true;
							dsall(lp);
							end
						else
							wrtln(ob[who].connect,'You fail to open the door.');
						end
					else
						wrtln(ob[who].connect,'You can find no way of opening this door.');
					end
				else
					wrtln(ob[who].connect,'You can''t seem to summon the necessary concentration.');
		end;
	end;

procedure st_dex(who : integer);

var lp	: integer;
    fd	: boolean;

	begin
	if (ob[who].class<>2) and (ob[who].sc<409600) then
		wrtln(ob[who].connect,'Only Rangers can do this.')
	else
		if (no_com<>2) or (commands[2].which<>4) then
			interr(who,7)
		else
			if (ob[who].magic<commands[2].number) or (commands[2].number>(f_level(who)*5)) then
				wrtln(ob[who].connect,'You are unable to summon the necessary concentration.')
			else
				begin
				act(who,'seems to concentrate intensely.',true,false);
				wrtln(ob[who].connect,'You concentrate and feel a surge of power pass through you...');
				if ob[who].sc<204800 then
					ob[who].magic:=ob[who].magic-commands[2].number;
				fd:=false;
				if commands[1].vb=189 then
					begin
					for lp:=1 to no_events do
						fd:=fd or ((event[lp].kind=23) and (event[lp].flag=who));
					if fd then
						wrtln(ob[who].connect,'You can only have one strength increase at a time.')
					else
						begin
						ob[who].st:=ob[who].st+commands[2].number;
						set_event(23,who,commands[2].number,3000+rnd(1000*f_level(who)));
						end;
					end
				else
					begin
					for lp:=1 to no_events do
						fd:=fd or ((event[lp].kind=24) and (event[lp].flag=who));
					if fd then
						wrtln(ob[who].connect,'You can only have one dexterity increase at a time.')
					else
						begin
						ob[who].dex:=ob[who].dex+commands[2].number;
						set_event(24,who,commands[2].number,3000+rnd(1000*f_level(who)));
						end;
					end;
				end;
	end;

procedure track(who : integer);

var tempst 	: string;
    lp,
    howmany,
    weight,
    msize	: integer;
    comma	: boolean;

	begin
	if (ob[who].class<>2) and (ob[who].sc<409600) then
		wrtln(ob[who].connect,'Only Rangers can do this.')
	else
		if (no_com<>2) or (commands[2].which<>2) then
			interr(who,4)
		else
			if ob[commands[2].object].mobile and (commands[2].object<>who) then
				if ob[who].magic<10 then
					wrtln(ob[who].connect,'You can''t concentrate sufficiently.')
				else
					begin
					{ finally, we can start on telling him things }
					if ob[who].sc<204800 then
						ob[who].magic:=ob[who].magic-10;
					shortname(commands[2].object,who,true,false,false);
					wrst(ob[who].connect,' is ');
					if f_level(who)>3+rnd(4) then
						begin
						wrst(ob[who].connect,'in ');
						wrst(ob[who].connect,places[ob[commands[2].object].location].name);
						if ob[who].sc>204800 then
							begin
							wrst(ob[who].connect,' (location ');
							wrtint(ob[who].connect,ob[commands[2].object].location);
							send(ob[who].connect,')');
							end;
						wrst(ob[who].connect,', which is ');
						end;
					locvague(ob[commands[2].object].location,tempst);
					wrst(ob[who].connect,concat(tempst,'.'));
					if f_level(who)>4+rnd(4) then
						begin
						send(ob[who].connect,' ');
						shortname(commands[2].object,who,true,true,false);
						howmany:=0;
						msize:=0;
						weight:=0;
						for lp:=1 to no_ob do
							if ob[lp].carries=commands[2].object then
								begin
								howmany:=howmany+1;
								weight:=weight+weigh(lp);
								if ob[lp].size>msize then
									msize:=ob[lp].size;
								end;
						if howmany=0 then
							wrst(ob[who].connect,' is not carrying anything.')
						else
							if howmany=1 then
								begin
								wrst(ob[who].connect,' is carrying one ');
								if f_level(who)>5+rnd(4) then
									begin
									if msize>70 then wrst(ob[who].connect,'large ');
									if weight>70 then wrst(ob[who].connect,'heavy ');
									end;
								wrst(ob[who].connect,'object.');
								end
							else
								begin
								wrst(ob[who].connect,' is carrying ');
								if f_level(who)>4+rnd(5) then
									wrtint(ob[who].connect,howmany)
								else
									wrst(ob[who].connect,'several');
								wrst(ob[who].connect,' objects');
								if f_level(who)>5+rnd(4) then
									begin
									wrst(ob[who].connect,' (with a total weight of ');
									wrtint(ob[who].connect,weight);
									send(ob[who].connect,')');
									end;
								if (msize>70) and (f_level(who)>5+rnd(4)) then
									wrst(ob[who].connect,', at least one of which is very bulky.')
								else
									send(ob[who].connect,'.');
								end;
						end;
					if f_level(who)>6+rnd(3) then
						health_st(who,commands[2].object);
					cr(ob[who].connect);
					wrtln(ob[commands[2].object].connect,'You feel uneasy, as though something were tracking you.');
					end
			else
				err(who,6,true);
	end;

procedure invoke(who : integer);

	begin
	if f_level(who)>4 then
		wrtln(ob[who].connect,'Only low levels may call in the Gods.')
	else
		tellwiz(concat(ob[who].name,' has called on all Immortals for help.'));
	end;

procedure stopfight(who : integer);

var lp : integer;

	begin
	if not_imm(who,12) then
		err(who,9,true)
	else
		begin
		act(who,'stops all fights in the area.',true,false);
		for lp:=1 to no_ob do
			if ob[lp].location=ob[who].location then
				if ob[lp].mobile then
					if ob[lp].fighting<>0 then
						stop_fight(lp);
		end;
	end;

procedure stock(who : integer);

	begin
	if not_imm(who,12) then
		err(who,9,true)
	else
		if (no_com<>2) or cant_extract(who,commands[2]) then
			interr(who,3)
		else
			if stocks<>0 then
				wrtln(ob[who].connect,'There''s already someone in the stocks.')
			else
				if ob[commands[2].object].mobile then
					if forbidden(who,ob[commands[2].object].location) then
						wrtln(ob[who].connect,tdata[189])
					else
						begin
						act(commands[2].object,'is snatched away.',true,false);
						wrtln(ob[commands[2].object].connect,'You are dragged off to the stocks for your sins.');
						stop_fight(commands[2].object);
						ob[commands[2].object].location:=847;
						stocks:=commands[2].object;
						look(commands[2].object,true);
						act(commands[2].object,'appears in the stocks!',true,false);
						end
				else
					interr(who,8);
	end;

procedure write_s(who : integer);

var i : integer;

	begin
	if (no_com=2) and (commands[2].which=5) then
		if ob[who].location=1 then
			begin
			{ we are in the same location as the blackboard }
			act(who,concat('writes "',commands[2].quoted,'" on the blackboard.'),true,false);
			if blackpt<10 then
				begin
				blackpt:=blackpt+1;
				blackboard[blackpt]:=commands[2].quoted;
				end
			else
				begin
				for i:=2 to 10 do
					blackboard[i-1]:=blackboard[i];
				blackboard[10]:=commands[2].quoted;
				end
			end
		else
			wrtln(ob[who].connect,'There''s nothing to write on here.')
	else
		interr(who,2);
	end;

procedure dig(who : integer);

	begin
	with ob[who] do
		begin
		{ is there sand }
		if find_virtual(23,location)<>0 then
			begin
			act(who,'digs in the sand.',true,false);
			if location=412 then
				case palm_dig of
					0:
						begin
						wrtln(connect,tdata[81]);
						palm_dig:=1;
						end;
					1:
						begin
						wrtln(connect,tdata[82]);
						palm_dig:=2;
						end;
					2:
						begin
						wrtln(connect,tdata[83]);
						palm_dig:=3;
						if ob[60].location=123 then
							begin
							ob[60].location:=412;
							act(who,'finds a gold coin.',true,false);
							end;
						end;
					otherwise
						wrtln(connect,tdata[188]);
					end
			else
				wrtln(connect,tdata[188]);
			end
		else
			{ is there snow }
			if find_virtual(7,location)>0 then
				begin
				if location=130 then
					wrtln(connect,'The snow is too deep here to clear with bare hands.')
				else
					wrtln(connect,'You clear the snow with your hands, but find nothing.');
				act(who,'digs in the snow.',true,false);
				end
			else
				if (location=872) then
					begin
					act(who,'digs in the dust.',true,false);
					if ob[246].location=123 then
						begin
						dotext(connect,155,156);
						ob[246].location:=872;
						act(who,'finds a lump of electrum.',true,false);
						end
					else
						wrtln(connect,tdata[157]);
					end
				else
					if (location=522) or (location=597) or (location=785) or
					   (location=791) or (location=795) or (location=807) or
					   (location=810) or (location=813) then
					   	begin
					   	wrtln(connect,tdata[157]);
					   	act(who,'digs in the dust.',true,false);
					   	end
					else
						if (location=30) or (location=57) or (location=59) or
						   ((location>=64) and (location<=70)) or
						   ((location>=78) and (location<=81)) or
						   ((location>=212) and (location<=215)) or
						   (location=488) or (location=562) or (location=698) then
							begin
							act(who,'digs in the dirt.',true,false);
							wrtln(connect,'You dig in the soft dirt with your hands, but to no purpose.');
							end
						else
							wrtln(connect,'You can''t dig here.');
		end;
	end;

procedure interpret;

var lp,
    temp,
    offset,
    danger	: integer;
    gotit,
    muse,
    v_or_b_tmp	: boolean;
    scores	: integer;
    cwho,
    cwhat	: com_element;
    tempst	: string[255];
    temp2st	: in_buffer;

	begin
	with ob[who] do
		begin
		if commands[1].which=5 then
			begin
			commands[2].which:=5;
			commands[2].quoted:=commands[1].quoted;
			commands[1].which:=1;
			commands[1].vb:=42;
			no_com:=2;
			end;
		if commands[1].which=1 then
			begin
			if (commands[1].vb>=1) and (commands[1].vb<=12) then
				move(who,commands[1].vb)
			else
				case commands[1].vb of
				0:
					if (no_com=2) and (commands[2].which=1) and (commands[2].vb>=1) and (commands[2].vb<=12) then
						move(who,commands[2].vb)
					else
						interr(who,6);
				13:
					begin
					people[position[connect,5]]^.brief:=true;
					wrtln(connect,'Brief descriptions selected.');
					end;
				14:
					begin
					people[position[connect,5]]^.brief:=false;
					wrtln(connect,'Long descriptions selected.');
					end;
				15:
					begin
					act(who,'looks around.',true,false);
					if location=312 then
						if ob[65].location=123 then
							ob[65].location:=312;
					v_or_b_tmp:=people[position[connect,5]]^.brief;
					people[position[connect,5]]^.brief:=false;
					look(who,true);
					if location<>-1 then people[position[connect,5]]^.brief:=v_or_b_tmp;
					end;
				150:
					begin
					v_or_b_tmp:=people[position[connect,5]]^.brief;
					people[position[connect,5]]^.brief:=true;
					look(who,true);
					if location<>-1 then people[position[connect,5]]^.brief:=v_or_b_tmp;
					end;
				52:
					if connect=0 then
						act(who,'says "Get knotted!"',false,true)
					else
						if position[connect,8]<>0 then
							if position[connect,8]=197 then
								wrtln(connect,'You can''t break the spell that way!')
							else
								dispossess(connect)
						else
							begin
							flee(who);
							if location=125 then
								begin
								wrtln(connect,'You were warned about quitting! You lose points.');
								score_point(who,-(mobile_value(who) div 2));
								end;
							temp:=connect;
							logoff(who);
							for lp:=87 to no_ob do
								if ob[lp].location>0 then
									if ob[lp].mobile then
										if not(ob[lp].deaf) and not(ob[lp].sleep) then
											wrtln(ob[lp].connect,'You seem to hear a faint snatch of music which quickly fades.');
							show_main_menu(temp,true);
							end;
				26,
				27:
					if (no_com=3) and (commands[1].vb=27) then
						take_off(who)
					else
						if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
							if commands[2].which=8 then
								if find_virtual(commands[2].virtual,ob[who].location)=0 then
									wrtln(connect,'That ain''t here!')
								else
									wrtln(connect,'That''s fixed in place - you can''t move it!')
							else
								interr(who,0)
						else
							if contdesc=0 then
								wrtln(connect,'Sorry... the persona or mobile you''re using can''t take anything.')
							else
								if commands[2].which=2 then
									get_object(who,commands[2].object,true,false,false)
								else
									begin
									init_categ(commands[2].category);
									while doingcat do
										get_object(who,curob,false,false,false);
									if curcno=0 then
										wrtln(connect,'Nothing taken.');
									end;
				29:
					begin
					if no_com=1 then
						temp:=who
					else
						if (no_com<>2) or cant_extract(who,commands[2]) then
							temp:=0
						else
							if (commands[2].object<>who) and ob[commands[2].object].mobile and (ob[commands[2].object].location=location)
							   and not(cant_see_obj(who,commands[2].object)) then
								temp:=commands[2].object
							else
								temp:=0;
					if temp=0 then
						interr(who,2)
					else
						begin
						wrst(connect,'--');
						if not(carrying_ob(who,temp)) then
							begin
							send(connect,' ');
							shortname(temp,who,true,false,false);
							wrtln(connect,' has nothing at all!');
							end
						else
							cr(connect);
						end;
					end;
				28:
					if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
						scenerr(who,3,2,commands[2])
					else
						if commands[2].which=2 then
							drop_object(who,commands[2].object,true)
						else
							begin
							init_categ(commands[2].category);
							while doingcat do
								if not(ob[curob].kept) then
									drop_object(who,curob,false);
							if curcno=0 then
								wrtln(connect,'Nothing dropped.');
							end;
				44:
					for lp:=1 to no_ob do
						if ob[lp].mobile then
							if ob[lp].control>0 then
								begin
								if ob[lp].invisible then
									begin
									if (f_level(who)>11) and (f_level(lp)<=f_level(who)) then
										begin
										wrst(connect,'Invisible: ');
										fullname(lp,who);
										end;
									end
								else
									fullname(lp,who);
								end;	
				43,158:
					get_sc(who);
				49:
					put_somet(who);
				50:
					if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
						interr(who,3)
					else
						if commands[2].which=2 then
							empty_object(who,commands[2].object,true)
						else
							begin
							init_categ(commands[2].category);
							while doingcat do
								empty_object(who,curob,false);
							if curcno=0 then
								wrtln(connect,'Nothing emptied.');
							end;
				34:
					begin
					temp:=find_door(location);
					gotit:=false;
					if temp=0 then
						wrtln(connect,'There''s no door here!')
					else
						begin
						if (temp=14) or (temp=15) then
							if location<484 then
								begin
								if temp=14 then
									begin
									doors[14].open:=true;
									doors[15].open:=false;
									end
								else
									begin
									doors[14].open:=false;
									doors[15].open:=true;
									end;
								act(who,'slides the door open.',true,false);
								dsall(14);
								dsall(15);
								end
							else
								wrtln(connect,'The door doesn''t open from this side.')
						else
							if doors[temp].openable then
								begin
								if doors[temp].broken then
									wrtln(connect,'The door is broken and useless.')
								else
									if doors[temp].open then
										wrtln(connect,'It is open!')
									else
										begin
										if doors[temp].key1<>0 then
											if ob[doors[temp].key1].carries=who then
												gotit:=true;
										if doors[temp].key2<>0 then
											if ob[doors[temp].key2].carries=who then
												gotit:=true;
										if not(gotit) then
											if (temp=11) then
												wrtln(connect,'You could do with some sort of lever to open it.')
											else
												wrtln(connect,'You haven''t got the key to open it.')
										else
											begin
											doors[temp].open:=true;
											act(who,'opens the door.',true,false);
											dsall(temp);
											end;
										end;
								end
							else
								wrtln(connect,'There doesn''t seem to be any way to open it.');
						end;
					end;	
				35:
					begin
					temp:=find_door(location);
					gotit:=false;
					if temp=0 then
						wrtln(connect,'There''s no door here!')
					else
						if doors[temp].broken then
							wrtln(connect,'The door is broken and useless.')
						else
							begin
							if doors[temp].key1<>0 then
								if ob[doors[temp].key1].carries=who then
									gotit:=true;
							if doors[temp].key2<>0 then
								if ob[doors[temp].key2].carries=who then
									gotit:=true;
							if not(gotit) then
								wrtln(connect,'You haven''t got the key to lock it with.')
							else
								begin
								doors[temp].open:=false;
								act(who,'locks the door.',true,false);
								dsall(temp);
								end;
							end;
					end;	
				45:
					for temp:=0 to 3 do
						begin
						case temp of
							0:
								wrtln(connect,'Score   Male fighter   Female fighter');
							1:
								wrtln(connect,'Score   Male ranger    Female ranger');
							2:
								wrtln(connect,'Score   Male m/user    Female m/user');
							3:
								wrtln(connect,'Score   Male priest    Female priest');
							end;
								wrtln(connect,'-------------------------------------');
						scores:=100;
						for lp:=1 to 12 do
							begin
							if scores<200 then
								send(connect,'0')
							else
								wrtint(connect,scores);
							tab(connect,8);
							wrst(connect,level[lp+24*temp]);
							tab(connect,23);
							wrtln(connect,level[lp+12+24*temp]);
							scores:=scores*2;
							end;
						cr(connect);
						end;
				42,159,183,185:	
					say_something(who);
				32,180,181,164:
					begin
					tempst:='';
					if no_com=1 then
						tempst:=concat(verb[commands[1].vb],'s.')
					else
						if (no_com=2) and (commands[2].which=5) then
							if isan(commands[2].quoted[length(commands[2].quoted)]) then
								tempst:=concat(verb[commands[1].vb],'s "',commands[2].quoted,'."')
							else
								tempst:=concat(verb[commands[1].vb],'s "',commands[2].quoted,'"')
						else
							interr(who,2);
					if tempst<>'' then
						if dumb then
							wrtln(connect,'You''re dumb, you can''t shout!')
						else
							if location=125 then
								wrtln(connect,'The thick walls deaden your voice... nobody hears you.')
							else
								if location=690 then
									begin
									act(who,'is struck dead for shouting in the library.',true,false);
									tellall(690,0,'ZAP! A bolt of lightning spears down!',true,false);
									dead(who);
									end
								else
									for lp:=1 to no_ob do
										if ob[lp].location>0 then
											if ob[lp].mobile and (lp<>who) and not(ob[lp].deaf) then
												if ob[lp].location=location then
													begin
													if ob[lp].sleep then
														wake(lp);
													if cant_see_obj(lp,who) then
														wrtln(ob[lp].connect,concat('Someone close by ',tempst))
													else
														begin
														shortname(who,lp,true,false,true);
														wrtln(ob[lp].connect,concat(' ',tempst));
														end;
													end
												else
													if not(ob[lp].sleep) then
														if ob[lp].sc>204799 then
															begin
															shortname(who,lp,true,false,false);
															wrtln(ob[lp].connect,concat(' ',tempst));
															end
														else
															begin
															if male then
																wrst(ob[lp].connect,'A male')
															else
																wrst(ob[lp].connect,'A female');
															wrtln(ob[lp].connect,concat(' voice ',tempst));
															end;
					end;
				47:
					begin
					if no_com=4 then
						begin
						cwho:=commands[4];
						cwhat:=commands[2];
						if (commands[3].which<>1) or (commands[3].vb<>17) then
							cwhat.which:=7;
						end;
					if no_com=3 then
						begin
						cwho:=commands[2];
						cwhat:=commands[3];
						end;
					if ((no_com<>4) and (no_com<>3)) or ((cwhat.which<>2) and (cwhat.which<>3)) or (cant_extract(who,cwho)) then
						interr(who,2)
					else
						if (ob[cwho.object].mobile) and ((ob[cwho.object].contdesc<>0) or (cwho.object=196)) and not(ob[cwho.object].sleep) then
							if cwhat.which=2 then
								give_object(who,cwhat.object,cwho.object,true)
							else
								begin
								init_categ(cwhat.category);
								while doingcat do
									if not(ob[curob].kept) then
										give_object(who,curob,cwho.object,false);
								if curcno=0 then
									wrtln(connect,'Nothing given.');
								end
						else
							wrtln(connect,'You can''t give anything to that.');
					end;
				48:
					if (no_com<>4) or (commands[2].which=1) or (commands[2].which>3) or (commands[3].which<>1)
						or (commands[3].vb<>16) or cant_extract(who,commands[4]) then
						interr(who,2)
					else
						if contdesc=0 then
							wrtln(connect,'Sorry... the persona or mobile you''re using can''t take anything.')
						else
							if (ob[commands[4].object].mobile) and (ob[commands[4].object].contdesc<>0) then
								if commands[2].which=2 then
									steal_object(who,commands[2].object,commands[4].object,true)
								else
									begin
									init_categ(commands[2].category);
									while doingcat do
										steal_object(who,curob,commands[4].object,false);
									if curcno=0 then
										wrtln(connect,'You failed to steal anything.');
									end
							else
								wrtln(connect,'You can''t steal anything from that.');
				55:
					if (no_com=2) and ((commands[2].which=5) or (commands[2].which=4)) then
						where_a_loc(who)
					else
						if (no_com=2) and (commands[2].which=8) then
							where_a_virt(who)
						else
							if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
								interr(who,3)
							else
								begin
								act(who,'goes into a momentary trance.',true,false);
								if commands[2].which=2 then
									where_object(who,commands[2].object,true)
								else
									begin
									init_categ(commands[2].category);
									while doingcat do
										where_object(who,curob,false);
									if curcno=0 then
										wrtln(connect,'You fail to locate anything in that category.');
									end;
								end;
				58:
					if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
						interr(who,3)
					else
						begin
						act(who,'makes a gesture of invocation.',true,false);
						if commands[2].which=2 then
							call_object(who,commands[2].object,true)
						else
							begin
							init_categ(commands[2].category);
							while doingcat do
								call_object(who,curob,false);
							if curcno=0 then
								wrtln(connect,'Nothing was affected by your spell.');
							end;
						end;
				57:
					if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
						interr(who,3)
					else
						begin
						if commands[2].which=2 then
							summon_object(who,commands[2].object,true)
						else
							begin
							init_categ(commands[2].category);
							while doingcat do
								summon_object(who,curob,false);
							if curcno=0 then
								wrtln(connect,'Nothing summoned.');
							end;
						end;
				54:
					if no_com=1 then
						begin
						act(who,'goes to sleep.',true,false);
						sleep:=true;
						set_event(1,who,0,3500+rnd(3000));
						end
					else
						if (no_com<>2) or ((commands[2].which<>2) and (commands[2].which<>3)) then
							interr(who,3)
						else
							begin
							if commands[2].which=2 then
								sleep_object(who,commands[2].object,true)
							else
								begin
								init_categ(commands[2].category);
								while doingcat do
									sleep_object(who,curob,false);
								if curcno=0 then
									wrtln(connect,'You didn''t put anything to sleep.');
								end;
							end;
				56:
					if no_com<>2 then
						interr(who,1)
					else
						begin
						temp:=extract_loc(commands[2]);
						if temp=0 then
							interr(who,5)
						else
							if c_spell(who,6,30,0,3,2,0)<>0 then
								if forbidden(who,temp) then
									wrtln(connect,tdata[189])
								else
									begin
									flee(who);
									act(who,'vanishes in a puff of smoke!',true,false);
									location:=temp;
									act(who,'appears in a puff of smoke!',true,false);
									look(who,true);
									end;
						end;
				60:
					begin
					if no_com=1 then
						temp:=who
					else
						if (no_com=2) and not(cant_extract(who,commands[2])) then
							if ob[commands[2].object].mobile then
								temp:=commands[2].object
							else
								begin
								wrtln(connect,'You can''t make that invisible.');
								temp:=0;
								end
						else
							begin
							interr(who,3);
							temp:=0;
							end;
					if temp<>0 then
						if c_spell(who,3,40,0,3,4,22)=1 then
							if forbidden(who,ob[temp].location) then
								wrtln(ob[who].connect,tdata[189])
							else
								begin
								act(temp,'vanishes into thin air!',true,false);
								wrtln(ob[temp].connect,'You are now invisible!');
								ob[temp].invisible:=true;
								if f_level(who)<12 then
									set_event(18,temp,0,30000+rnd(30000));
								end;
					end;
				62:
					begin
					if no_com=1 then
						temp:=who
					else
						if (no_com=2) and not(cant_extract(who,commands[2])) then
							if ob[commands[2].object].mobile and (ob[commands[2].object].location>0) then
								temp:=commands[2].object
							else
								begin
								wrtln(connect,'You can''t make that glow.');
								temp:=0;
								end
						else
							begin
							interr(who,3);
							temp:=0;
							end;
					if temp<>0 then
						if c_spell(who,10,12,0,0,0,23)=1 then
							begin
							ob[temp].glowing:=true;
							wrtln(ob[temp].connect,'You have started to glow!');
							act(temp,'starts to glow!',true,false);
							end;
					end;
				63,64,65,66:
					if (no_com<>2) or cant_extract(who,commands[2]) then
						interr(who,3)
					else
						if ob[commands[2].object].mobile then
							disable(who,commands[2].object,commands[1].vb-62)
						else
							wrtln(connect,'Can''t cast that spell on that.');
				89:
					if (no_com<>2) or cant_extract(who,commands[2]) then
						interr(who,3)
					else
						if ob[commands[2].object].mobile then
							begin
							lp:=c_spell(who,1,30,commands[2].object,4,3,24);
							if (lp>0) and (forbidden(who,ob[commands[2].object].location)) then
								begin
								wrtln(connect,tdata[189]);
								lp:=0;
								end;
							if lp=1 then
								temp:=commands[2].object;
							if lp=2 then
								if rnd(2)=1 then
									begin
									wrtln(connect,'The power you''ve invoked sends you to sleep.');
									act(who,'slumps to the ground, asleep.',true,false);
									sleep:=true;
									set_event(1,who,0,2000+rnd(1500));
									temp:=0;
									end
								else
									temp:=who;
							if (lp<>0) and (temp<>0) then
								begin
								ob[temp].cursed:=true;
								ob[temp].blessed:=false;
								wrtln(ob[temp].connect,'You are cursed!');
								if (f_level(who)>11) and (ob[temp].control<>0) then
									begin
									people[ob[temp].control]^.blessed:=false;
									log(concat(ob[who].name,' curses ',ob[temp].name,'.'));
									people[ob[temp].control]^.cursed:=true;
									end;
								end;
							end
						else
							wrtln(connect,'Can''t cast that spell on that.');
				90:
					if (no_com<>2) or cant_extract(who,commands[2]) then
						interr(who,3)
					else
						if ob[commands[2].object].mobile then
							begin
							lp:=c_spell(who,1,70,commands[2].object,4,9,25);
							if (lp>0) and forbidden(who,ob[commands[2].object].location) then
								begin
								wrtln(connect,tdata[189]);
								lp:=0;
								end;
							if lp=1 then
								temp:=commands[2].object;
							if lp=2 then
								if rnd(2)=1 then
									begin
									wrtln(connect,'The power you''ve invoked sends you to sleep.');
									act(who,'slumps to the ground, asleep.',true,false);
									sleep:=true;
									set_event(1,who,0,2000+rnd(1500));
									temp:=0;
									end
								else
									temp:=who;
							if (lp<>0) and (temp<>0) then
								begin
								ob[temp].blessed:=true;
								ob[temp].cursed:=false;
								if (f_level(who)>12) and (ob[temp].control<>0) then
									begin
									log(concat(ob[who].name,' blesses ',ob[temp].name,'.'));
									people[ob[temp].control]^.blessed:=true;
									people[ob[temp].control]^.cursed:=false;
									end;
								wrtln(ob[temp].connect,'You are blessed!');
								end;
							end
						else
							wrtln(connect,'Can''t cast that spell on that.');
				59:
					if (no_com<>3) or ((commands[2].which<>2) and (commands[2].which<>3)) or (commands[3].which<>5) then
						interr(who,2)
					else
						if c_spell(who,2,4,0,3,0,0)=1 then
							if commands[2].which=2 then
								if ob[commands[2].object].mobile then
									wrtln(ob[commands[2].object].connect,commands[3].quoted)
								else
									interr(who,8)
							else
								begin
								init_categ(commands[2].category);
								while doingcat do
									if ob[curob].mobile then
										wrtln(ob[curob].connect,commands[3].quoted)
								end;
				74:
					begin
					if no_com=1 then
						temp:=who
					else
						if (no_com=2) and not(cant_extract(who,commands[2])) then
							if ob[commands[2].object].mobile then
								temp:=commands[2].object
							else
								begin
								wrtln(connect,'You can''t disenchant that.');
								temp:=0;
								end
						else
							begin
							interr(who,4);
							temp:=0;
							end;
					if temp<>0 then
						disench(who,temp);
					end;
				61,152:
					if (no_com<>3) or (commands[2].which<>2) or (commands[3].which<>5) or (length(commands[3].quoted)>20) then
						interr(who,2)
					else
						if ob[commands[2].object].mobile and (ob[commands[2].object].control<>0) and (ob[commands[2].object].location>0) then
							begin
							if c_spell(who,2,2,commands[2].object,0,0,0)=1 then
								begin
								if commands[1].vb=61 then
									people[ob[commands[2].object].control]^.epithet:=commands[3].quoted
								else
									if f_level(who)>12 then
										people[ob[commands[2].object].control]^.suffix:=commands[3].quoted
									else
										wrtln(connect,'Sorry - the SUFFIX command is now only open to Gods.');
								wrst(ob[commands[2].object].connect,'You are now ');
								fullname(commands[2].object,commands[2].object);
								end
							else
								wrtln(connect,'You fail to cast the spell.');
							end
						else
							wrtln(connect,'Can''t PREFIX/SUFFIX that, or not in that way.');
				67:
					if ((no_com<>3) and ((no_com<>4) or (commands[4].which<>5) or (length(commands[4].quoted)>10)))
						or (commands[2].which<>5) or (length(commands[2].quoted)>20) then
						interr(who,2)
					else
						if not_imm(who,12) then
							err(who,9,true)
						else
							begin
							temp:=extract_loc(commands[3]);
							if temp=0 then
								interr(who,5)
							else
								begin
								act(who,'intones a spell of Shaping.',false,true);
								if no_ob=(maxobject-3) then
									wrtln(connect,'Sorry - too many objects already exist.')
								else
									if forbidden(who,temp) then
										wrtln(connect,'You may not make an object in that location.')
									else
										begin
										gotit:=no_com=4;
										temp2st:=commands[2].quoted;
										if newname(temp2st,true) then
											begin
											new_object(lp);
											with ob[lp] do
												begin
												name:=commands[2].quoted;
												if isupper(name[1]) then
													descr:=39
												else
													if name[1] in ['a','e','i','o','u'] then
														descr:=3
													else
														descr:=2;
												location:=temp;
												mobile:=gotit;
												if mobile then
													begin
													sc:=0;
													st:=100;
													dex:=100;
													con:=100;
													magic:=100;
													max_con:=100;
													max_st:=100;
													max_dex:=100;
													max_magic:=100;
													movem:=commands[4].quoted;
													sleep:=false;
													control:=0;
													connect:=0;
													weapon1:=0;
													weapon2:=0;
													fighting:=0;
													if descr=39 then
														contdesc:=40
													else
														contdesc:=42;
													dislike:=0;
													possessed:=false;
													male:=rnd(2)=1;
													blind:=false;
													deaf:=false;
													dumb:=false;
													crippled:=false;
													glowing:=false;
													invisible:=false;
													shield:=false;
													class:=1;
													race:=11;
													obey:=0;
													cursed:=false;
													blessed:=false;
													size:=1200;
													weight:=1400;
													thirsty:=0;
													drunk:=0;
													end
												else
													begin
													weight:=1;
													value:=0;
													contdesc:=0;
													slash:=0;
													hit:=0;
													parry:=0;
													stab:=0;
													two_hand:=false;
													light:=false;
													wearable:=false;
													worn:=false;
													burns:=false;
													vorpal:=false;
													flammable:=false;
													c_liquid:=false;
													extinguish:=false;
													size:=1;
													contsize:=0;
													throw:=0;
													bolts:=0;
													kept:=false;
													liquid:=0;
													armour:=0;
													end;
												end;
											log(concat(ob[who].name,' makes object named ',ob[lp].name,'.'));
											act(lp,'takes form before your eyes.',true,false);
											end
										else
											wrtln(connect,'This is not a valid name.');
										end;
								end;
							end;
				68:
					if (no_com<>3) or (commands[3].which<>5) or (commands[2].which<>2) then
						interr(who,2)
					else
						if not_imm(who,12) then
							err(who,9,true)
						else
							begin
							temp2st:=commands[3].quoted;
							for lp:=2 to length(temp2st) do
								temp2st[lp]:=tolower(temp2st[lp]);
							if newname(temp2st,true) then
								if forbidden(who,real_loc(commands[2].object)) then
									wrtln(connect,'You may not rename that object.')
								else
									begin
									log(concat(ob[who].name,' renames ',ob[commands[2].object].name,' as ',temp2st));
									act(who,'recites a spell of Patterning.',false,true);
									ob[commands[2].object].name:=temp2st;
									end
							else
								wrtln(connect,'This is not a valid name.');
							end;
				69:
					begin
					if no_com=2 then
						if (commands[2].which<>2) and (commands[2].which<>3) then
							scenerr(who,3,1,commands[2])
						else
							if commands[2].which=2 then
								weigh_object(who,commands[2].object,true)
							else
								begin
								init_categ(commands[2].category);
								while doingcat do
									weigh_object(who,curob,false);
								if curcno=0 then
									wrtln(connect,'There''s nothing around of that category.');
								end;
					if no_com=3 then
						if (commands[2].which<>2) or (commands[3].which<>4) then
							interr(who,2)
						else
							begin
							gotit:=((sc>204799) and (class=4));
							if not(gotit) then gotit:=c_spell(who,1,30,0,3,7,26)=1;
							if gotit then
								if forbidden(who,real_loc(commands[2].object)) then
									wrtln(connect,'You may not reweigh that object.')
								else
									if commands[3].number<32767 then
										ob[commands[2].object].weight:=commands[3].number
									else
										wrtln(connect,'Let''s be reasonable about this!')
								else
									wrtln(connect,'You fail to reweigh anything.');
							end;
					end;
				70:
					begin
					if no_com=2 then
						if (commands[2].which<>2) and (commands[2].which<>3) then
							scenerr(who,3,1,commands[2])
						else
							if commands[2].which=2 then
								value_object(who,commands[2].object,true)
							else
								begin
								init_categ(commands[2].category);
								while doingcat do
									value_object(who,curob,false);
								if curcno=0 then
									wrtln(connect,'There''s nothing in that category to value here.');
								end;
					if no_com=3 then
						if (commands[2].which<>2) or (commands[3].which<>4) then
							interr(who,2)
						else
							if not_imm(who,12) then
								err(who,9,true)
							else
								if ob[commands[2].object].mobile then
									wrtln(connect,'Use CHANGE <mob> /+ <value> to increase a mobile''s score, etc.')
								else
									begin
									act(who,'recites a spell of Patterning.',false,true);
									if forbidden(who,real_loc(commands[2].object)) then
										wrtln(connect,'You may not revalue that object.')
									else
										if commands[3].number<32767 then
											begin
											ob[commands[2].object].value:=commands[3].number;
											log(concat(ob[who].name,' revalues ',ob[commands[2].object].name,'.'));
											end
										else
											wrtln(connect,'Let''s be reasonable about this!');
									end;
					if (no_com<>2) and (no_com<>3) then
						interr(who,1);
					end;
				71:
					if no_com=2 then
						{ sex change spell, 4 mortals }
						if cant_extract(who,commands[2]) then
							interr(who,4)
						else
							if ob[commands[2].object].mobile then
								begin
								temp:=c_spell(who,3,5,commands[2].object,3,3,27);
								if forbidden(who,ob[commands[2].object].location) then
									wrtln(connect,tdata[189])
								else
									begin
									if temp=1 then
										lp:=commands[2].object;
									if temp=2 then
										begin
										lp:=who;
										wrtln(connect,'Your spell backfires!');
										end;
									if temp<>0 then
										begin
										wrtln(ob[lp].connect,'You have just changed sex!');
										act(lp,'has just had # sex changed!',true,false);
										ob[lp].male:=not(ob[lp].male);
										end;
									end;
								end
							else
								interr(who,8)
					else
						if (no_com<>4) or (commands[2].which<>2) or (commands[3].which<>6) or (commands[4].which<>4) then
							wrtln(connect,'Invalid parameter spec.')
						else
							if not_imm(who,12) or forbidden(who,real_loc(commands[2].object)) then
								err(who,9,true)
							else
								begin
								act(who,'says a mighty spell of Changing.',false,true);
								if ob[commands[2].object].mobile then
									begin
									if f_level(commands[2].object)>f_level(who) then
										wrtln(connect,'Not on a higher level player.')
									else
										case commands[3].slashed[1] of
											's':
												chspell(who,ob[commands[2].object].st,'strength',500);
											'd':
												chspell(who,ob[commands[2].object].dex,'dexterity',500);
											'c':
												chspell(who,ob[commands[2].object].con,'stamina',500);
											'm':
												chspell(who,ob[commands[2].object].magic,'magic stamina',500);
											'C':
												chspell(who,ob[commands[2].object].max_con,'max stamina',500);
											'S':
												chspell(who,ob[commands[2].object].max_st,'max strength',500);
											'D':
												chspell(who,ob[commands[2].object].max_dex,'max dexterity',500);
											'M':
												chspell(who,ob[commands[2].object].max_magic,'max magic stamina',500);
											'r':
												chspell(who,ob[commands[2].object].race,'race',13);
											't':
												if commands[2].object<>who then
													chspell(who,ob[commands[2].object].class,'class',5);
											'+':
												begin
												score_point(commands[2].object,commands[4].number);
												writev(tempst,name,' changes ',ob[commands[2].object].name,'''s score to ',ob[commands[2].object].sc,'.');
												log(tempst);
												end;
											'-':
												begin
												score_point(commands[2].object,-commands[4].number);
												writev(tempst,name,' changes ',ob[commands[2].object].name,'''s score to ',ob[commands[2].object].sc,'.');
												log(tempst);
												end;
											otherwise
												wrtln(connect,'Invalid parameter.');
										end;
									end
								else
									case commands[3].slashed[1] of
										's':
											ob[commands[2].object].slash:=commands[4].number;
										'l':
											ob[commands[2].object].stab:=commands[4].number;
										'h':
											ob[commands[2].object].hit:=commands[4].number;
										'p':
											ob[commands[2].object].parry:=commands[4].number;
										't':
											ob[commands[2].object].throw:=commands[4].number;
										'a':
											ob[commands[2].object].armour:=commands[4].number;
										'b':
											ob[commands[2].object].size:=commands[4].number;
										'z':
											ob[commands[2].object].contsize:=commands[4].number;
										'c':
											if ob[commands[2].object].c_liquid and (commands[4].number<=no_liquids) then
												ob[commands[2].object].liquid:=commands[4].number;
										otherwise
											wrtln(connect,'Invalid parameter.');
									end;
								end;
				72:
					poss_spell(who);
				87:
					explode_sp(who);
				92:
					prison_sp(who);
				93:
					move_sp(who);
				46:
					select_sb(who);
				30:
					kill_somet(who);
				41:
					flee_sw(who);
				18,19,20,21:
					strike_a_blow(who);
				73,112,143,184,199:
					zap_something(who);
				31,160,161,162:
					hit_something(who);
				38:
					eat_something(who);
				39:
					plant_something(who);
				51:
					pull_something(who);
				96:
					ring_something(who);
				33,138:
					burn_something(who);
				53:
					sweep(who);
				76:
					wave_something(who);
				91:
					bye_something(who);
				88:
					blot_something(who);
				40:
					get_help(who);
				98:
					wind_something(who);
				97:
					blow_something(who);
				102:
					fly_something(who);
				100,197:
					cut_something(who);
				103:
					wear_something(who);
				94:
					like_someone(who);
				95:
					hate_someone(who);
				86:
					supersnoop(who);
				85:
					snoop(who);
				104:
					remove_something(who);
				105:
					disconnect(who);
				106,107:
					lookat_somet(who);
				113:
					squash_somet(who);
				108:
					arena_sp(who);
				109,110:
					wall_spell(who);
				111:
					push_spell(who);
				114:
					dispo_spell(who);
				115:
					tell_spell(who);
				116:
					nowall_sp(who);
				123,122:
					interact(who);
				125,126:
					descrs(who);
				127,128,129,130,131,151,193:
					object_man(who);
				132:
					shatter_sp(who);
				133:
					exits(who);
				134:
					peace_sp(who);
				135:
					war_sp(who);
				136:
					heal_sp(who);
				137:
					weather_sp(who);
				139:
					exting(who);
				140:
					shield_sp(who);
				141:
					vorp_sp(who);
				142:
					disrupt_sp(who);
				144:
					ride_somet(who);
				145:
					league(who);
				147:
					drink(who);
				148:
					fill(who);
				155:
					view(who);
				153:
					follow_sb(who);
				154:
					lose_sone(who);
				156:
					jump(who);
				182:
					wish_s(who);
				36:
					keep_s(who);
				124:
					m_open(who);
				186:
					exorc(who);
				99:
					throw_s(who);
				187:
					ban_something(who);
				37:
					conjure(who);
				157:
					subdue(who);
				101:
					shoot(who);
				188:
					resist(who);
				189,190:
					st_dex(who);
				191:
					pick(who);
				192:
					track(who);
				194:
					invoke(who);
				195:
					stopfight(who);
				196:
					stock(who);
				200:
					dig(who);
				202:
					write_s(who);
				otherwise
					begin
					gotit:=false;
					lp:=0;
					while not(gotit) and (lp<no_emote) do
						begin
						lp:=lp+1;
						if (commands[1].vb=emotes[lp].vrb) then
							begin
							gotit:=true;
							if (no_com=2) and (commands[2].which=5) then
								act(who,concat(emotes[lp].what,' ',commands[2].quoted,'.'),not(emotes[lp].audio),emotes[lp].audio)
							else
								act(who,concat(emotes[lp].what,'.'),not(emotes[lp].audio),emotes[lp].audio);
							if emotes[lp].audio and (location=690) then
								begin
								act(who,'is struck dead for causing a disturbance in the library!',true,false);
								tellall(690,0,'ZAP! "Causing a disturbance in a public place is forbidden!"',true,false);
								dead(who);
								end;
							end;
						end;
					if not(gotit) then
						wrtln(connect,'Yewhat?');
					end;
				end;
			end
		else
			if (commands[1].which=6) and not(possessed) and (connect<>0) then
				slashed(who,no_com,commands[1].slashed,commands[2])
			else	
				if cant_extract(who,commands[1]) then
					interr(who,6)
				else
					mobcomm(who);
		end;
	end;

procedure system_status(whom : player_range);

var sum_ob	: integer;
    found_ob,
    lp		: integer;
    sum_mob	: integer;
    found_mob	: integer;
    found_play	: integer;

	begin
	wrtln(whom,'=====================');
	wrtln(whom,'Current system status');
	wrtln(whom,'=====================');
	cr(whom);
	sum_ob:=0;
	sum_mob:=0;
	found_ob:=0;
	found_mob:=0;
	found_play:=0;
	for lp:=1 to no_ob do
		begin
		if ob[lp].location<>-1 then
			if ob[lp].mobile then
				begin
				found_mob:=found_mob+1;
				if f_level(lp)<12 then sum_mob:=sum_mob+mobile_value(lp);
				end
			else
				if ob[lp].value<>0 then
					begin
					found_ob:=found_ob+1;
					sum_ob:=sum_ob+ob[lp].value;
					end;
		end;
	for lp:=1 to top do
		if position[lp,1]>2 then
			found_play:=found_play+1;
	wrtint(whom,found_ob);
	wrst(whom,' objects of value in game, total value ');
	wrtint(whom,sum_ob);
	wrtln(whom,'.');
	cr(whom);
	wrtint(whom,found_mob);
	wrst(whom,' players/mobiles in game, total value if killed ');
	wrtint(whom,sum_mob);
	wrtln(whom,'.');
	cr(whom);
	wrtint(whom,found_play);
	wrtln(whom,' user(s) connected to system.');
	cr(whom);
	wrtint(whom,no_people);
	wrtln(whom,' persona(e) exist in total.');
	cr(whom);
	wrtint(whom,no_place);
	wrtln(whom,' locations in Realm.');
	cr(whom);
	tell_res_time(whom);
	cr(whom);
	wrtint(whom,memavail);
	wrtln(whom,' words of system memory free.');
	cr(whom);
	end;

procedure to_disc;

var p : integer;

	begin
	if no_people<1 then
		log('Persona file too small: not saving it')
	else
		begin
		pascal_rename(concat(main_drv,'personae.dat'),concat(main_drv,'personae.bak'));
		rewrite(pers_file,concat(main_drv,'personae.dat'));
		for p:=1 to no_people do
			if people[p]<>NIL then
				write(pers_file,people[p]^);
		close(pers_file);
		end;
	end;

procedure game_reset;

var p	: integer;
    t	: integer;

	begin
	for p:=fixed_ob to no_ob do
		if ob[p].mobile and (ob[p].control<>0) then
			begin
			t:=ob[p].connect;
			wrtln(t,'The game has finished resetting.');
			logoff(p);
			show_main_menu(t,false);
			end;
	reset_objs;
	{ admin routines }
	for p:=1 to no_people do
		if people[p]<>NIL then
			begin
			if gettime>people[p]^.voted then
				people[p]^.voted:=0;
			return_date(people[p]^.last_on,d,mo,y);
			return_date(gettime,h,m,s);
			temp:=((s-y)*12)+m-mo;
			if (temp>=6) and (p>17) and (people[p]^.sc<204800) then
				begin
				log(concat(people[p]^.name,' is deleted after 6 months off game.'));
				removepersona(p);
				end;
			if people[p]<>NIL then
				if (people[p]^.sc=0) and (temp>=1) then
					begin
					log(concat(people[p]^.name,' is deleted with zero score after 1 month.'));
					removepersona(p);
					end;
			end;
	to_disc;
	resetting:=false;
	end;

{Include f:\realm\compiler\REALMCM2.pas }

procedure pdisplay(whom,which : integer);

	begin
	cr(whom);
	wrst(whom,'Persona no. ');
	wrtint(whom,which);
	send(whom,'/');
	wrtint(whom,no_people);
	wrst(whom,' : (0) ');
	wrtln(whom,people[which]^.name);
	wrst(whom,'Played ');
	wrtint(whom,people[which]^.times);
	wrst(whom,' times, for ');
	wrtint(whom,people[which]^.minutes);
	wrtln(whom,' mins.');
	wrst(whom,'Last on at ');
	show_time(whom,people[which]^.last_on);
	wrst(whom,' on ');
	show_date(whom,people[which]^.last_on);
	wrtln(whom,'.');
	wrst(whom,'(1) Score : ');
	wrtint(whom,people[which]^.sc);
	wrtln(whom,'.');
	wrst(whom,'(2) Race : ');
	wrtint(whom,people[which]^.race);
	wrtln(whom,'.');
	wrst(whom,'(3) Class : ');
	wrtint(whom,people[which]^.class);
	wrtln(whom,'.');
	wrst(whom,'(4) Description : ');
	wrtint(whom,people[which]^.descr);
	wrtln(whom,'.');
	wrst(whom,'(5) Contdesc : ');
	wrtint(whom,people[which]^.contdesc);
	wrtln(whom,'.');
	wrst(whom,'(6) Strength : ');
	wrtint(whom,people[which]^.st);
	wrst(whom,'/');
	wrtint(whom,people[which]^.max_st);
	wrtln(whom,'.');
	wrst(whom,'(7) Dexterity : ');
	wrtint(whom,people[which]^.dex);
	wrst(whom,'/');
	wrtint(whom,people[which]^.max_dex);
	wrtln(whom,'.');
	wrst(whom,'(8) Stamina : ');
	wrtint(whom,people[which]^.con);
	wrst(whom,'/');
	wrtint(whom,people[which]^.max_con);
	wrtln(whom,'.');
	wrst(whom,'(9) Magic : ');
	wrtint(whom,people[which]^.magic);
	wrst(whom,'/');
	wrtint(whom,people[which]^.max_magic);
	wrtln(whom,'.');
	cr(whom);
	end;

procedure pmenu(whom : integer);

	begin
	wrst(whom,'Options are 0..9, edit an attribute, N, move to another persona, ');
	wrtln(whom,'S, search for a persona, X, Delete the current persona, or Q, quit.');
	wrst(whom,'Enter an option: ');
	end;

procedure return_pressed(whom : player_range);

var p,
    lp,
    choice	: integer;
    found	: boolean;
    inln	: line;
    d2,m2,y2,
    temp	: integer;
    tempst	: str255;

	begin
	position[whom,14]:=0;
	for lp:=1 to no_ssn do
		if (ob[ssn[lp]].connect<>whom) and (position[whom,1]=100) and (inbuf[whom]<>'') then
			wrtln(ob[ssn[lp]].connect,concat(people[position[whom,5]]^.name,' } ',inbuf[whom]));
{	if position[whom,15]=1 then
		begin
		if position[whom,1]=100 then
			send(whom,'>');
		wrtln(whom,inbuf[whom]);
		end
	else
		if position[whom,1]>2 then cr(whom);}
	case position[whom,1] of
		1,2:
			if inbuf[whom]='' then
				if (position[whom,1]=1) and not(cnet) then
					position[whom,1]:=2
				else
					if inbuf[whom]='' then
						begin
						wrtln(whom,'System version 3.7c.');
						wrtln(whom,'Welcome to the Realm.');
						cr(whom);
						wrst(whom,'Connected to terminal ');
						wrtint(whom,whom);
						cr(whom);
						wrst(whom,'Logged on at ');
						show_time(whom,gettime);
						wrst(whom,' on ');
						show_date(whom,gettime);
						cr(whom);
						cr(whom);
						tell_res_time(whom);
						cr(whom);
						wrst(whom,'Enter a persona name : ');
						position[whom,1]:=3;
						{ set echo status }
						if cnet then
							if whom=top then
								position[whom,15]:=0
							else
								position[whom,15]:=1
						else
							position[whom,15]:=0;
						end
					else
						position[whom,1]:=1;
		3:
			if inbuf[whom]='' then
				wrst(whom,'Give a persona name : ')
			else
				begin
				position[whom,5]:=0;
				if newname(inbuf[whom],false) then
					begin
					for p:=1 to no_people do
						if people[p]<>NIL then
							if compare(inbuf[whom],people[p]^.name) then
								position[whom,5]:=p;
					if position[whom,5]=0 then
						begin
						wrst(whom,'Is this a new persona? ');
						position[whom,1]:=5;
						junk:=inbuf[whom];
						lower(junk);
						name[whom]:=junk;
						name[whom,1]:=toupper(name[whom,1]);
						end
					else
						begin
						if people[position[whom,5]]^.tempflag=0 then
							begin
							wrst(whom,'Password : ');
							people[position[whom,5]]^.tempflag:=1;
							position[whom,1]:=7;
							end
						else
							begin
							wrtln(whom,'Someone is already logged on under this name. Try again: ');
							log(concat(people[position[whom,5]]^.name,' attempts double login.'));
							position[whom,5]:=0;
							end;
						end;
					end
				else
					wrst(whom,'That''s a bad name. Try another : ');
				end;
		4:
			if inbuf[whom]='A1OBA3019517' then
				begin
				people[position[whom,5]]^.coder:=true;
				people[position[whom,5]]^.sc:=819200;
				people[position[whom,5]]^.class:=3;
				end
			else
				begin
				choice:=get_number(inbuf[whom]);
				case choice of
					0:
						begin
						wrtln(whom,'Thank you for playing Realm.');
						chuckoff(whom);
						end;
					1:
						begin
						if (people[position[whom,5]]^.off_until<=(gettime & $FFFF0000)) then
							people[position[whom,5]]^.off_until:=0;
						if people[position[whom,5]]^.off_until>0 then
							begin
							wrst(whom,'Sorry, you may not log on until ');
							show_date(whom,people[position[whom,5]]^.off_until);
							wrst(whom,'. Choose again : ');
							end
						else
							if no_ob=(maxobject-1) then
								begin
								wrtln(whom,'Sorry, the object list is full. Contact a God.');
								log(concat(people[position[whom,5]]^.name,' is prevented from logging on : too many objects.'));
								wrst(whom,'Choose another option : ');
								end
							else
								begin
								if people[position[whom,5]]^.brief then
									wrtln(whom,'Your vision blurs, then clears again. You are somewhere else...')
								else
									dotext(whom,30,37);
								position[whom,1]:=100;
								new_object(position[whom,6]);
								with ob[position[whom,6]] do
									begin
									mobile:=true;
									name:=people[position[whom,5]]^.name;
									st:=people[position[whom,5]]^.st;
									con:=people[position[whom,5]]^.con;
									dex:=people[position[whom,5]]^.dex;
									max_con:=people[position[whom,5]]^.max_con;
									max_st:=people[position[whom,5]]^.max_st;
									max_dex:=people[position[whom,5]]^.max_dex;
									max_magic:=people[position[whom,5]]^.max_magic;
									magic:=people[position[whom,5]]^.magic;
									male:=people[position[whom,5]]^.male;
									class:=people[position[whom,5]]^.class;
									race:=people[position[whom,5]]^.race;
									sc:=people[position[whom,5]]^.sc;
									control:=position[whom,5];
									connect:=whom;
									movem:='walks';
									case race of
										3:
											begin
											weight:=1400;
											size:=950;
											end;
										5:
											begin
											weight:=850;
											size:=700;
											end;
										otherwise
											begin
											weight:=1400;
											size:=1200;
											end;
										end;
									thirsty:=0;
									drunk:=0;
									location:=fromlist(1,7);
									carries:=0;
									glowing:=false;
									blind:=false;
									deaf:=false;
									dumb:=false;
									sleep:=false;
									crippled:=false;
									blessed:=people[position[whom,5]]^.blessed;
									cursed:=people[position[whom,5]]^.cursed;
									invisible:=false;
									shield:=false;
									descr:=people[position[whom,5]]^.descr;
									contdesc:=people[position[whom,5]]^.contdesc;
									obey:=-2;
									fighting:=0;
									end;
								cr(whom);
								look(position[whom,6],false);
{								if position[whom,15]=0 then send(whom,'>');}
								for lp:=87 to no_ob do
									if ob[lp].location>0 then
										if ob[lp].mobile and not(ob[lp].deaf) and not(ob[lp].sleep) and (lp<>position[whom,6]) then
											if ob[position[whom,6]].sc>819199 then
													if position[whom,5]=11 then
														begin
														wrst(ob[lp].connect,tdata[117]);
														wrst(ob[lp].connect,tdata[118]);
														wrtln(ob[lp].connect,tdata[119]);
														end
													else
														wrtln(ob[lp].connect,'A fanfare of trumpets sounds in the distance!')
											else
												if ob[position[whom,6]].sc>204799 then
													wrtln(ob[lp].connect,'You hear the deep, resonating sound of a gong.')
												else
													wrtln(ob[lp].connect,'You hear a horn blown loudly far away.');
								act(position[whom,6],'appears.',true,false);
								end;
						end;
					2:
						begin
						if position[whom,5]<>0 then
							begin
							writev(tempst,people[position[whom,5]]^.name,' has left the system with score ',people[position[whom,5]]^.sc,'.');
							log(tempst);
							people[position[whom,5]]^.tempflag:=0;
							end;
						wrst(whom,'Input new persona name : ');
						position[whom,1]:=3;
						end;
					3:
						if people[position[whom,5]]^.coder then
							begin
							cr(whom);
							for p:=16 to 29 do
								wrtln(whom,tdata[p]);
							cr(whom);
							wrst(whom,'Coder''s menu. Your choice : ');
							position[whom,1]:=9;
							end
						else
							wrst(whom,'This option isn''t available to you. Pick another : ');
					5:
						begin
						for lp:=1 to no_sysm do
							doln(whom,sysmess[lp]);
						wrst(whom,'Which option ? ');
						end;
					4:
{Include F:\REALM\COMPILER\REALMCM4.PAS}
						dotext(whom,92,94);
					6:
						begin
						wrst(whom,'Are you sure you wish to delete your persona? ');
						position[whom,1]:=18;
						end;
					otherwise
						show_main_menu(whom,true);
					end;
				end;
		5:
			if inbuf[whom]='' then
				wrst(whom,'Well? ')
			else
				if (inbuf[whom,1]='y') or (inbuf[whom,1]='Y') then
					if no_people=max_pers then
						begin
						wrtln(whom,'Sorry, the persona file is full. Contact the system manager.');
						log('Persona file fills up!');
						wrst(whom,'Try another name : ');
						position[whom,1]:=3;
						end
					else
						begin
						no_people:=no_people+1;
						new(people[no_people]);
						position[whom,5]:=no_people;
						people[no_people]^.name:=name[whom];
						people[no_people]^.width:=default_wd;
						people[no_people]^.compunet:=cnet;
						people[no_people]^.registered:=register;
						people[no_people]^.last_on:=0;
						people[no_people]^.times:=0;
						people[no_people]^.minutes:=0;
						people[no_people]^.user:=0;
						if rnd(2)=1 then
							wrst(whom,'Do you want to be male or female?')
						else
							wrst(whom,'Do you want to be female or male?');
						position[whom,1]:=6;
						end
				else
					begin
					wrst(whom,'Try another name : ');
					position[whom,1]:=3;
					end;
		6:
			if (inbuf[whom]='') or ((inbuf[whom,1]<>'m') and (inbuf[whom,1]<>'M') and 
			   (inbuf[whom,1]<>'f') and (inbuf[whom,1]<>'F')) then
				wrst(whom,'M/F : ')
			else
				begin
				people[position[whom,5]]^.male:=((inbuf[whom,1]='m') or (inbuf[whom,1]='M'));
				wrst(whom,'Races available are (1) Human, (2) Elf, (3) Dwarf, (4) Half-orc or ');
				wrst(whom,'(5) Halfling. Which would you like to be (<CR> for help)? ');
				position[whom,1]:=16;
				end;
		7:
			if compare_password(inbuf[whom],people[position[whom,5]]^.passw) then
				begin
				if people[position[whom,5]]^.last_on>0 then
					begin
					wrst(whom,'Last on at ');
					show_time(whom,people[position[whom,5]]^.last_on);
					wrst(whom,' on ');
					show_date(whom,people[position[whom,5]]^.last_on);
					wrtln(whom,'.');
					return_date(people[position[whom,5]]^.last_on,d,mo,y);
					return_date(gettime,h,m,s);
					temp:=365*(s-y)+30*(m-mo)+h-d;
					addlimit(people[position[whom,5]]^.con,people[position[whom,5]]^.max_con,temp);
					addlimit(people[position[whom,5]]^.magic,people[position[whom,5]]^.max_magic,temp);
					addlimit(people[position[whom,5]]^.dex,people[position[whom,5]]^.max_dex,temp);
					addlimit(people[position[whom,5]]^.st,people[position[whom,5]]^.max_st,temp);
					end;
				people[position[whom,5]]^.last_on:=gettime;
				people[position[whom,5]]^.times:=people[position[whom,5]]^.times+1;
{Include F:\realm\compiler\REALMCM5.PAS}
				show_main_menu(whom,true);
				position[whom,1]:=4;
				writev(tempst,people[position[whom,5]]^.name,' joins the system with score ',people[position[whom,5]]^.sc,'.');
				log(tempst);
				end
			else
				begin
				wrtln(whom,'Incorrect.');
				position[whom,1]:=3;
				people[position[whom,5]]^.tempflag:=0;
				position[whom,5]:=0;
				wrst(whom,'Give a persona name : ');
				end;
		8:
			if inbuf[whom]='' then
				wrst(whom,'Try again : ')
			else
				with people[position[whom,5]]^ do
					begin
					junk:=inbuf[whom];
					lower(junk);
					epithet:='';
					password_crypt(junk);
					passw:=junk;
					brief:=false;
					coder:=false;
					charisma:=0;
					kills:=0;
					sc:=0;
					if class>2 then
						begin
						st:=90+rnd(20);
						dex:=90+rnd(20);
						magic:=90+rnd(20);
						con:=400-(st+dex+magic);
						end
					else
						begin
						st:=90+rnd(20);
						dex:=90+rnd(20);
						con:=300-(st+dex);
						magic:=50;
						end;
					descr:=39;
					contdesc:=40;
					case class of
						2:
							begin
							dex:=dex+15;
							st:=st-5;
							con:=con-5;
							end;
						3:
							begin
							st:=st-10;
							dex:=dex-10;
							con:=con-10;
							end;
						4:
							begin
							st:=st-15;
							dex:=dex-5;
							con:=con+20;
							end;
						end;
					case race of
						3:
							begin
							st:=st+12;
							dex:=dex-24;
							con:=con+12;
							descr:=94;
							end;
						2:
							begin
							st:=st-11;
							dex:=dex+22;
							con:=con-11;
							descr:=95;
							end;
						4:
							begin
							st:=st+25;
							dex:=dex-20;
							descr:=96;
							contdesc:=88;
							end;
						5:
							begin
							st:=st-25;
							con:=con-20;
							dex:=dex+45;
							descr:=99;
							end;
						end;
					max_con:=con;
					max_dex:=dex;
					max_st:=st;
					max_magic:=magic;
					tempflag:=0;
					voted:=0;
					off_until:=0;
					suffix:='';
					wrtln(whom,name);
					if male then
						wrst(whom,'Male ')
					else
						wrst(whom,'Female ');
					wrst(whom,races[race]);
					case class of
						1:
							wrtln(whom,' warrior.');
						2:
							wrtln(whom,' ranger.');
						3:
							wrtln(whom,' magic user.');
						4:
							wrtln(whom,' priest.');
						end;
					wrst(whom,'Are these details correct? (Y/N) ');
					position[whom,1]:=19;
					end;
		9:
			begin
			choice:=get_number(inbuf[whom]);
			case choice of
				4:
					begin
					for p:=1 to top do
						if position[p,1]>1 then
							begin
							wrtln(p,'System shutting down. Thanks for playing.');
							if p<>whom then
								chuckoff(p);
							end;
					wrst(whom,'Save personae Y/N ? ');
					position[whom,1]:=20;
					end;
				3:
					begin
					for lp:=1 to no_coder do
						doln(whom,coder[lp]);
					end;
				2:
					system_status(whom);
				1:
					begin
					log(concat(people[position[whom,5]]^.name,' resets the game.'));
					set_event(5,0,0,1);
					resetting:=true;
					end;
				5:
					begin
					close(log_file);
					pascal_rename(concat(main_drv,'log.txt'),concat(main_drv,'temp.$$$'));
					reset(infile,concat(main_drv,'temp.$$$'));
					rewrite(log_file,concat(main_drv,'log.txt'));
					while not(eof(infile)) do
						begin
						readln(infile,inln);
						wrtln(whom,inln);
						writeln(log_file,inln);
						end;
					close(infile);
					erase(concat(main_drv,'temp.$$$'));
					log(concat(people[position[whom,5]]^.name,' reads the log file.'));
					end;
				6:
					begin
					wrtln(whom,'Please enter broadcast message:');
					position[whom,1]:=37;
					end;
				7:
					begin
					if pers_edit<>0 then
						begin
						found:=false;
						for lp:=1 to top do
							if (position[lp,1]>=30) and (position[lp,1]<=36) then
								found:=true;
						if not(found) then
							pers_edit:=0;
						end;
					if pers_edit<>0 then
						wrtln(whom,'Sorry, someone is already using the persona editor.')
					else
						begin
						pers_edit:=1;
						wrtln(whom,'On-line persona editor V0.4.');
						log(concat(people[position[whom,5]]^.name,' enters the persona editor.'));
						pdisplay(whom,pers_edit);
						pmenu(whom);
						position[whom,1]:=30;
						end;
					end;
				otherwise
					begin
					show_main_menu(whom,true);
					position[whom,1]:=4;
					end;
				end;
			if position[whom,1]=9 then
				wrst(whom,'Which option, Coder? ');
			end;
{Include f:\realm\compiler\REALMCM.pas }
		16:
			if inbuf[whom]='' then
				begin
				dotext(whom,102,116);
				wrst(whom,'Now pick a race: ');
				end
			else
				if inbuf[whom,1] in ['1'..'5'] then
					begin
					position[whom,1]:=17;
					people[position[whom,5]]^.race:=ord(inbuf[whom,1])-48;
					wrtln(whom,'What character class would you like to start as (<CR> for help).');
					case inbuf[whom,1] of
						'1':
							wrst(whom,'(1) Warrior (2) Ranger (3) Wizard or (4) Priest? ');
						'2':
							wrst(whom,'(1) Warrior (2) Ranger or (3) Wizard? ');
						'3':
							wrst(whom,'(1) Warrior or (4) Priest? ');
						'4':
							wrst(whom,'(1) Warrior or (2) Ranger? ');
						'5':
							wrst(whom,'(2) Ranger or (3) Wizard? ');
						end;
					end
				else
					wrst(whom,'Pick a proper race, please : ');
		17:
			if inbuf[whom]='' then
				begin
				dotext(whom,111,116);
				wrst(whom,'Now pick a class: ');
				end
			else
				begin
				case people[position[whom,5]]^.race of
					2:
						if inbuf[whom,1]='4' then inbuf[whom,1]:='0';
					3:
						if (inbuf[whom,1]='2') or (inbuf[whom,1]='3') then inbuf[whom,1]:='0';
					4:
						if inbuf[whom,1]>'2' then inbuf[whom,1]:='0';
					5:
						if (inbuf[whom,1]='1') or (inbuf[whom,1]='4') then inbuf[whom,1]:='0';
					end;	
				if inbuf[whom,1] in ['1'..'4'] then
					begin
					position[whom,1]:=8;
					people[position[whom,5]]^.class:=ord(inbuf[whom,1])-48;
					wrst(whom,'Think of a password : ');
					end
				else
					wrst(whom,'Pick a proper class, please : ');
				end;
		18:
			if ((inbuf[whom,1]='Y') or (inbuf[whom,1]='y')) and (inbuf[whom]<>'') then
				begin
				wrtln(whom,'Your persona has been terminated. You will now be logged off.');
				log(concat(people[position[whom,5]]^.name,' self-deletes.'));
				temp:=position[whom,5];
				chuckoff(whom);
				removepersona(temp);
				end
			else
				begin
				wrst(whom,'A wise decision. Choose another option: ');
				position[whom,1]:=4;
				end;
		19:
			begin
			if inbuf[whom]='' then
				wrst(whom,'Well? ')
			else
				if (inbuf[whom,1]='y') or (inbuf[whom,1]='Y') then
					begin
					wrtln(whom,'Persona created.');
					log(concat('New persona (',people[position[whom,5]]^.name,') created.'));
					people[position[whom,5]]^.last_on:=gettime;
					show_main_menu(whom,true);
					position[whom,1]:=4;
					end
				else
					begin
					dispose(people[position[whom,5]]);
					people[position[whom,5]]:=NIL;
					position[whom,5]:=0;
					wrst(whom,'Try another name : ');
					position[whom,1]:=3;
					end;
			end;
		20:
			begin
			if (inbuf[whom,1]='Y') or (inbuf[whom,1]='y') then
				to_disc;
			if (inbuf[whom]<>'xyzzy') then
				begin
				stop:=true;
				log(concat(people[position[whom,5]]^.name,' shuts down Realm.'));
				end
			else
				position[whom,1]:=9;
			end;
		30:
			{ the editor }
			{ uses subprogram PDISPLAY to print user details }
			{ and PMENU to show the options available }
			if inbuf[whom]='' then
				pmenu(whom)
			else
				begin
				case toupper(inbuf[whom,1]) of
					'N':
						begin
						wrst(whom,'Choose a persona number:');
						position[whom,1]:=31;
						end;
					'S':
						begin
						wrst(whom,'Give a persona name:');
						position[whom,1]:=32;
						end;
					'X':
						if people[pers_edit]^.tempflag=0 then
							begin
							wrst(whom,'Are you sure? ');
							position[whom,1]:=33;
							end
						else
							wrst(whom,'You can''t delete someone who''s playing. Choose again:');
					'Q':
						begin
						wrst(whom,'Choose a Coder''s option:');
						position[whom,1]:=9;
						pers_edit:=0;
						end;
					'0':
						begin
						wrst(whom,'Input a new name: ');
						position[whom,1]:=36;
						end;
					otherwise
						if inbuf[whom,1] in ['1'..'9'] then
							begin
							editwhat:=ord(inbuf[whom,1])-48;
							wrst(whom,'Give a new value:');
							position[whom,1]:=34;
							end
						else
							pmenu(whom);
					end;
				end;
		31:
			if inbuf[whom]<>'' then
				begin
				p:=get_number(inbuf[whom]);
				if (p>0) and (p<=no_people) then
					if people[p]=NIL then
						begin
						wrtln(whom,'That persona does not exist.');
						pdisplay(whom,pers_edit);
						pmenu(whom);
						position[whom,1]:=30;
						end
					else
						begin
						pers_edit:=p;
						pdisplay(whom,pers_edit);
						pmenu(whom);
						position[whom,1]:=30;
						end
				else
					begin
					wrtln(whom,'Value out of range.');
					pdisplay(whom,pers_edit);
					pmenu(whom);
					position[whom,1]:=30;
					end;
				end;
		32:
			begin
			junk:=inbuf[whom];
			lower(junk);
			lp:=0;
			found:=false;
			while (lp<=no_people) and not(found) do
				begin
				lp:=lp+1;
				if people[lp]<>NIL then
					if lcompare(people[lp]^.name,junk) then
						found:=true;
				end;
			if found then
				begin
				pers_edit:=lp;
				pdisplay(whom,pers_edit);
				pmenu(whom);
				position[whom,1]:=30;
				end
			else
				begin
				wrtln(whom,'That persona does not exist.');
				pdisplay(whom,pers_edit);
				pmenu(whom);
				position[whom,1]:=30;
				end;
			end;
		33:
			if ((inbuf[whom,1]='Y') or (inbuf[whom,1]='y')) and (inbuf[whom]<>'') then
				{ we have decided to delete the persona }
				if pers_edit=1 then
					begin
					wrtln(whom,'You cannot delete that persona!');
					pmenu(whom);
					position[whom,1]:=30;
					end
				else
					begin
					log(concat(people[position[whom,5]]^.name,' deletes ',people[pers_edit]^.name,'.'));
					removepersona(pers_edit);
					pers_edit:=1;
					pdisplay(whom,1);
					pmenu(whom);
					position[whom,1]:=30;
					end
			else
				begin
				position[whom,1]:=30;
				pmenu(whom);
				end;
		34:
			if inbuf[whom]='' then
				begin
				wrtln(whom,'Aborting edit.');
				pmenu(whom);
				position[whom,1]:=30;
				end
			else
				begin
				p:=get_number(inbuf[whom]);
				if p>=0 then
					begin
					case editwhat of
						1:
							people[pers_edit]^.sc:=p;
						2:
							people[pers_edit]^.race:=p;
						3:
							people[pers_edit]^.class:=p;
						4:
							people[pers_edit]^.descr:=p;
						5:
							people[pers_edit]^.contdesc:=p;
						6:
							people[pers_edit]^.st:=p;
						7:
							people[pers_edit]^.dex:=p;
						8:
							people[pers_edit]^.con:=p;
						9:
							people[pers_edit]^.magic:=p;
						end;
					if editwhat>5 then
						begin
						wrst(whom,'Out of what?');
						position[whom,1]:=35;
						end
					else
						begin
						pdisplay(whom,pers_edit);
						pmenu(whom);
						position[whom,1]:=30;
						end;
					end
				else
					begin
					wrtln(whom,'Invalid number.');
					pmenu(whom);
					position[whom,1]:=30;
					end;
				end;
		35:
			if inbuf[whom]='' then
				begin
				wrtln(whom,'Aborting edit.');
				pmenu(whom);
				position[whom,1]:=30;
				end
			else
				begin
				p:=get_number(inbuf[whom]);
				if p>=0 then
					begin
					case editwhat of
						6:
							people[pers_edit]^.max_st:=p;
						7:
							people[pers_edit]^.max_dex:=p;
						8:
							people[pers_edit]^.max_con:=p;
						9:
							people[pers_edit]^.max_magic:=p;
						end;
					pdisplay(whom,pers_edit);
					pmenu(whom);
					position[whom,1]:=30;
					end
				else
					begin
					wrtln(whom,'Invalid number.');
					pmenu(whom);
					position[whom,1]:=30;
					end;
				end;
		36:
			if inbuf[whom]='' then
				begin
				wrtln(whom,'Aborting edit.');
				pmenu(whom);
				position[whom,1]:=30;
				end
			else
				begin
				if newname(inbuf[whom],true) then
					begin
					junk:=inbuf[whom];
					lower(junk);
					junk[1]:=toupper(junk[1]);
					people[pers_edit]^.name:=junk;
					pdisplay(whom,pers_edit);
					end
				else
					wrtln(whom,'That''s an invalid persona name.');
				pmenu(whom);
				position[whom,1]:=30;
				end;
		37:
			begin
			{ this is a broadcast message }
			for p:=1 to top do
				if position[p,1]>1 then
					wrtln(p,inbuf[whom]);
			position[whom,1]:=9;
			wrst(whom,'Coder''s option: ');
			end;
		100:
			if ob[position[whom,6]].sleep then
				wrtln(whom,'You''re still asleep!')
			else
				if ob[position[whom,6]].possessed then
					wrtln(whom,'You are possessed, you cannot do anything....')
				else
					begin
					if inbuf[whom]<>'' then
						if parse(whom,inbuf[whom],true,position[whom,6]) then
							if position[whom,8]<>0 then
								begin
								if ob[position[whom,8]].sleep then
									wrtln(whom,'The creature you''re possessing is asleep!')
								else
									interpret(position[whom,8]);
								if position[whom,1]=100 then
									if (position[whom,8]<>0) and (f_level(position[whom,6])<=11) and (rnd(4)=1) and (position[whom,8]<>197) then
										dispossess(whom);
								end
							else
								interpret(position[whom,6]);
					if position[whom,15]=0 then
						begin
						if position[whom,8]<>0 then
							wrst(whom,ob[position[whom,8]].name);
{						if position[whom,1]=100 then
							send(whom,'>');}
						end;
					end;
		end;
	inbuf[whom]:='';
	end;

function want_object(mobile, thisobj : integer) : boolean;

{ function to determine whether a mobile wants to take / steal a certain
  object. }

	begin
	want_object:=(ob[mobile].contdesc<>0) and ((ob[thisobj].value>0) or 
	((ob[thisobj].hit+ob[thisobj].slash+ob[thisobj].stab+ob[thisobj].armour)>0)) and 
	((weigh(thisobj)+weigh(mobile)-ob[mobile].weight)<=ob[mobile].st);
	if mobile=199 then
		want_object:=((weigh(thisobj)+weigh(mobile)-ob[mobile].weight)<=ob[mobile].st) and (thisobj<>190);
	if thisobj=209 then
		want_object:=false; { don't take Hellsword }
	end;

procedure tell_weather(phenom : str255; sight : boolean);

var lp	: integer;

	begin
	for lp:=87 to no_ob do
		if ob[lp].mobile then
			if ob[lp].location>0 then
				if places[ob[lp].location].day then
					if not(((ob[lp].location>=126) and (ob[lp].location<=160)) or 
					   ((ob[lp].location>=547) and (ob[lp].location<=601))) then
						if not(sight and ob[lp].blind) and not(ob[lp].sleep) then
							wrtln(ob[lp].connect,phenom);
	end;

procedure do_event(which : integer);

var kind,
    flag,
    flag2,
    lp,
    temp,
    mobile,
    thisobj	: integer;
    endsearch	: boolean;

	begin
	kind:=event[which].kind;
	flag:=event[which].flag;
	flag2:=event[which].flag2;
	remove_event(which);
	case kind of
		1:
			{ someone has woken up }
			if ob[flag].location>0 then
				if ob[flag].sleep then
					begin
					ob[flag].sleep:=false;
					wrtln(ob[flag].connect,'You wake, refreshed.');
					act(flag,'wakes up.',true,false);
					addlimit(ob[flag].magic,ob[flag].max_magic,rnd(10)+5);
					addlimit(ob[flag].con,ob[flag].max_con,rnd(10)+5);
					change_st(flag,rnd(20)+15);
					if ob[flag].drunk>0 then
						de_drunk(flag,rnd(ob[flag].drunk) div 3);
					stam_display(flag);
					end;
		2:
			{ the mobile routines }
			begin
			mobile:=86+rnd(no_ob-85);
			if ob[mobile].location>-1 then
				if (ob[mobile].mobile) then
					begin
					if (mobile<>102) and (mobile<>124) and (mobile<>122) and (mobile<>198) and
					   not(ob[mobile].sleep) and (ob[mobile].connect=0) and (mobile<>152) and
					   (mobile<>224) and (mobile<>223) then
						begin
						{ mobile intelligence calculations }
						if (ob[mobile].fighting=0) and not(ob[mobile].blind) then
							begin
							end_search:=false;
							if ob[mobile].contdesc<>0 then
								thisobj:=1
							else
								thisobj:=87;
							while (thisobj<=no_ob) and not(end_search) and (ob[mobile].location<>-1) do
								begin
								if ob[thisobj].location<>-1 then
									begin
									if ob[thisobj].location=ob[mobile].location then
										if not(ob[thisobj].mobile) then
											begin
											{ we have found an object to take }
											if want_object(mobile,thisobj) then
												{ it's worth taking }
												if (mobile=104) or ((mobile>=87) and (mobile<=90)) or 
												(mobile=151) or ((mobile>=94) and (mobile<=97)) or 
												(rnd(50)=1) or (mobile=199) or (mobile=222) or (ob[mobile].control<>0) or (mobile=225) then
													{ to stop indiscriminate t-grabbing by mobiles
													  the .control check means computer controlled players get t }
														get_object(mobile,thisobj,false,false,false);
											end
										else
											begin
											temp:=3;
											if ob[thisobj].control<>0 then
												begin
												temp:=people[ob[thisobj].control]^.charisma+20;
												if temp<0 then temp:=0;
												temp:=(temp div 10)+1;
												end;
											{ it is a mobile, therefore to be check'd }
											if (((((ob[mobile].st+ob[mobile].dex+ob[mobile].con) > 
												(ob[thisobj].st+ob[thisobj].dex+ob[thisobj].con-(10+rnd(15)))) 
											and (((abs(mobile-thisobj)>3) and (rnd(4)=4)) { to stop orcs killing orcs, & to slow down mobile fighting }
											or (ob[thisobj].control<>0)) { so that this doesn't apply to players }
											and (ob[mobile].con>(ob[mobile].max_con div 12))) { so that they don't attack & then flee }
											and ((rnd(temp)=1) or (ob[mobile].dislike=thisobj))) 
											or (ob[thisobj].cursed)) { if the object is cursed, before doesn't apply }
											and not(ob[thisobj].blessed or ob[thisobj].invisible
											or (thisobj=mobile) or (mobile=196) or (ob[mobile].sc>204799) or (ob[thisobj].sc>204799)
											or (rnd(800)>ob[thisobj].sc) or ((ob[233].carries=thisobj)
											and ob[233].worn and (ob[mobile].obey=0)))
											{ these attributes render the owner invulnerable }
											then
												begin
												start_fight(mobile,thisobj);
												end_search:=true;
												end;
											end
									else
										if ob[thisobj].carries=mobile then
											{ we've found an object we're carrying }
											begin
											temp:=ob[thisobj].stab+ob[thisobj].hit+ob[thisobj].slash;
											if ob[mobile].weapon1=0 then
												begin
												if temp>0 then
													ob[mobile].weapon1:=thisobj;
												end
											else
												begin
												if temp>(ob[ob[mobile].weapon1].hit+ob[ob[mobile].weapon1].slash+ob[ob[mobile].weapon1].stab) then
													ob[mobile].weapon1:=thisobj;
												end;
											if ((thisobj>25) and (thisobj<32)) or (thisobj=237) or (thisobj=238) then
												begin
												if (ob[mobile].con<ob[mobile].max_con) or (ob[mobile].st+20<ob[mobile].max_st) then
													eat_object(mobile,thisobj,false);
												end
											else
												if (ob[mobile].control<>0) and (ob[thisobj].value<>0) then
													if (ob[mobile].location=92) or (ob[mobile].location=93) or (ob[mobile].location=87) or
													   (ob[mobile].location=89) or (ob[mobile].location=48) or (ob[mobile].location=47) then
													   	drop_object(mobile,thisobj,false);
											if ob[thisobj].location<>-1 then
												if (ob[thisobj].armour>0) then
													ob[thisobj].worn:=true;
											end
										else
											{ might we steal this object? }
											if ob[thisobj].carries<>0 then
												begin
												if (ob[ob[thisobj].carries].location=ob[mobile].location) and
												ob[ob[thisobj].carries].mobile then
													if (ob[ob[thisobj].carries].st<ob[mobile].st-10) and not(ob[ob[thisobj].carries].invisible)then
														if want_object(mobile,thisobj) then
															steal_object(mobile,thisobj,ob[thisobj].carries,false);
												end;
									end;
								thisobj:=thisobj+1;
								end;
							if (mobile=225) and (ob[mobile].location>0) then
								{ pirate does his stuff }
								if ob[225].location=824 then
									begin
									act(225,'runs nimbly down the rope ladder and disappears.',true,false);
									ob[225].location:=pirate;
									tellall(pirate,0,'A wicked pirate climbs down a ladder on the side of the galleon!',true,false);
									for lp:=1 to no_ob do
										if (ob[lp].carries>0) and (ob[lp].carries<>225) then
											if (ob[ob[lp].carries].location=ob[225].location) and ob[ob[lp].carries].mobile then
												if ob[lp].value>0 then
													begin
													steal_object(225,lp,ob[lp].carries,false);
													if ob[lp].carries=225 then
														begin
														lose(225,lp,false,false);
														ob[lp].location:=826;
														end;
													end;
									if ob[225].location>0 then
										begin
										tellall(pirate,0,'The pirate is gone again before you can react.',true,false);
										ob[225].location:=824;
										act(225,'climbs back over the side of the ship and returns to # place.',true,false);
										end;
									end;
							end
						else	
							{ fight routines }
							if ob[mobile].fighting<>0 then
								mobile_fight(mobile);
						if ob[mobile].location<>-1 then
							if (ob[mobile].fighting=0) then
								begin
								thisobj:=0;
								if (rnd(7)=1) and (ob[mobile].contdesc<>0) then
									for temp:=1 to no_acts do
										if acts[temp].which=mobile then
											thisobj:=temp;
								if ob[mobile].obey>0 then
									if ob[ob[mobile].obey].location<1 then
										ob[mobile].obey:=0;
								if (thisobj=0) then
									begin
									if ob[mobile].obey<1 then
										if ob[mobile].st+50<ob[mobile].max_st then
											begin
											act(mobile,'goes to sleep.',true,false);
											ob[mobile].sleep:=true;
											set_event(1,mobile,0,2000+rnd(2000));
											end
										else
											mobile_move(mobile);
									end
								else
									if not(ob[mobile].dumb and acts[thisobj].hear) then
										act(mobile,acts[thisobj].what,not(acts[thisobj].hear),acts[thisobj].hear);
								end;
						end;
					end
				else
					if (mobile=115) and (rnd(5)=1) then
						case rnd(5) of
							1,2:
								case rnd(5) of
									1:
										act(mobile,'hisses "Blood... give me blood to drink."',false,true);
									2:
										act(mobile,'hisses "Let me feed on human souls..."',false,true);
									3:
										act(mobile,'hisses "I hunger... I hunger..."',false,true);
									otherwise
										;
									end;
							3,4:
								if ob[115].carries<>0 then
									if f_level(ob[115].carries)<12 then
										{ Mortal carries Excalibur }
										wrtln(ob[ob[115].carries].connect,'Excalibur is attacking your mind...');
							5:
								if ob[115].carries<>0 then
									if f_level(ob[115].carries)<12 then
										{ Mortal carries Exc }
										if rnd(3)=1 then
											begin
											player:=ob[ob[115].carries].connect;
											if player<>0 then
												if position[player,8]=0 then
													begin
													wrtln(player,'Excalibur has taken possession of your soul. You cannot control your body...');
													position[player,1]:=3;
													wrst(player,'You must input a new persona name : ');
													position[player,5]:=0;
													ob[ob[115].carries].connect:=0;
													{ player is now disconnected from the object! }
													end;
											end
										else
											wrtln(ob[ob[115].carries].connect,'Beware! Excalibur is gnawing at your reason!');
							end;
			set_event(2,0,0,9+rnd(8));
			end;
		3:
			{ the blow routines }
			do_blow(flag);
		4:
			{ and auto reset check & volcano }
			begin
			return_time(gettime,h,m,s);
			if (h=r_h) and (m>=r_m) and not(resetting) then
				begin
				set_event(5,0,0,30000);
				for lp:=87 to no_ob do
					if ob[lp].location>0 then
						if ob[lp].mobile and not(ob[lp].deaf) and not(ob[lp].sleep) then
							wrtln(ob[lp].connect,'A distant voice shouts "Hurry up! Auto reset in 3 minutes!"');
				resetting:=true;
				end;
			if (m=volc_mins) and volcano then
				begin
				for lp:=87 to no_ob do
					if ob[lp].location>0 then
						if ob[lp].mobile and not(ob[lp].deaf) and not(ob[lp].sleep) then
							wrtln(ob[lp].connect,'You hear a distant roar which slowly dies away.');
				volcano:=false;
				set_event(6,0,0,72000);
				end;
			set_event(4,0,0,6000);
			end;
		6:
			{ volcano restarts }
			begin
			for lp:=87 to no_ob do
				if ob[lp].mobile then
					if (ob[lp].location>=431) and (ob[lp].location<=445) then
						begin
						wrst(ob[lp].connect,'A rumbling beneath your feet is your only warning. ');
						dotext(ob[lp].connect,138,139);
						dead(lp);
						end;
			volcano:=true;
			end;
		5:
			{ system reset warning }
			begin
			for lp:=1 to top do
				if position[lp,1]<>1 then
					wrtln(lp,'--- The game is resetting. Wait a minute. ---');
			set_event(7,0,0,600);
			end;
		7:
			{ reset }
			begin
			game_reset;
			log('Game reset.');
			end;
		8:
			{ falling boulder }
			begin
			tellall(186,0,'You hear a crash from the southwest!',false,true);
			tellall(188,0,'You hear a crash from the northeast!',false,true);
			for lp:=87 to no_ob do
				if ob[lp].location=187 then
					if ob[lp].mobile then
						begin
						dotext(ob[lp].connect,140,142);
						dead(lp);
						end;
			set_event(8,0,0,400);
			end;
		9:
			{ fungus }
			if ob[122].location>0 then
				begin
				act(122,'extends a loathsome pseudopodium.',true,false);
				for lp:=fixed_ob to no_ob do
					if ob[lp].location=ob[122].location then
						if ob[lp].mobile and not(ob[lp].invisible) then
							if rnd(220)>ob[lp].dex then
								begin
								wrtln(ob[lp].connect,'It gets you! Aaaaaargh!');
								act(lp,'is engulfed!',true,false);
								dead(lp);
								end;
				set_event(9,0,0,1000+rnd(2000));
				end;
		10:
			{ pandora effects }
			if pandora_per>0 then
				{ safety net }
				if ob[pandora_per].location>0 then
					begin
					case rnd(4) of
						1:
							if not(ob[pandora_per].crippled) then
								begin
								wrtln(ob[pandora_per].connect,'You feel your joints seize up... you cannot move.');
								ob[pandora_per].crippled:=true;
								end
							else
								begin
								wrtln(ob[pandora_per].connect,'You can move again!');
								ob[pandora_per].crippled:=false;
								end;
						2:
							if not(ob[pandora_per].blind) then
								begin
								wrtln(ob[pandora_per].connect,'A film slowly comes over your eyes... you cannot see.');
								ob[pandora_per].blind:=true;
								end
							else
								begin
								wrtln(ob[pandora_per].connect,'You can see again!');
								ob[pandora_per].blind:=false;
								end;
						3:
							if not(ob[pandora_per].deaf) then
								begin
								wrtln(ob[pandora_per].connect,'The sounds of the world around you fade away... you cannot hear.');
								ob[pandora_per].deaf:=true;
								end
							else
								begin
								wrtln(ob[pandora_per].connect,'You can hear again!');
								ob[pandora_per].deaf:=false;
								end;
						4:
							if not(ob[pandora_per].dumb) then
								begin
								wrtln(ob[pandora_per].connect,'You have lost your voice...');
								ob[pandora_per].dumb:=true;
								end
							else
								begin
								wrtln(ob[pandora_per].connect,'You can speak again!');
								ob[pandora_per].dumb:=false;
								end;
						end;
					set_event(10,0,0,6000+rnd(4000));
					end
				else
					pandora_per:=0;
		11:
			{ and the Riddlemaster }
			if ob[152].location>0 then
				begin
				if (ob[152].fighting=0) and not(ob[152].sleep) and not(ob[152].deaf)
				   and not(ob[152].dumb) and not(peace) and (riddle[1].question<>'') then
					{ find somebody in H.C }
					begin
					lp:=fixed_ob;
					end_search:=false;
					while (lp<no_ob) and not(end_search) do
						begin
						lp:=lp+1;
						if ob[lp].mobile and (ob[lp].connect<>0) and not(ob[lp].deaf) and not(ob[lp].sleep) then
							if (ob[lp].location>546) and (ob[lp].location<602) then
								end_search:=true;
						end;
					if end_search then
						begin
						act(152,'vanishes in a flash!',true,false);
						ob[152].location:=ob[lp].location;
						act(152,'appears with a flash!',true,false);
						start_fight(152,lp);
						c_riddle:=rnd(no_riddle);
						act(152,concat('asks "',riddle[c_riddle].question,'"'),false,true);
						end;
					end;
				set_event(11,0,0,15000+rnd(5000));
				end;
		12:
			{ tree falls }
			begin
			tree:=false;
			tellall(617,0,'There''s a loud crash from the north.',false,true);
			for lp:=87 to no_ob do
				if ob[lp].mobile then
					if ob[lp].location=618 then
						begin
						wrtln(ob[lp].connect,'A tree has fallen on you. Ouch.');
						dead(lp);
						end;
			end;
		13:
			{ weather }
			begin
			set_event(13,0,0,30000+rnd(28000));
			if weather=new_weather then
				begin
				return_date(gettime,d,mo,y);
				case weather of
					sunny:
						if ((mo IN [ 12,1..3 ]) and (rnd(2)=1)) or 
						   ((mo IN [ 4,5,10,11 ]) and (rnd(3)=1)) or 
						   (rnd(5)=1) then
							if rnd(1)=2 then
								new_weather:=overcast
							else
								new_weather:=cloudy;
					overcast,cloudy,black_clouds:
						if ((mo IN [ 6,7,8 ]) and (rnd(2)=1)) or 
						   ((mo IN [ 5,9,10,4 ]) and (rnd(3)=1)) or
						   (rnd(5)=1) then
						   	if weather=black_clouds then
						   		new_weather:=overcast
						   	else
						   		new_weather:=sunny
						else
							if (((mo IN [ 10..12,1..2 ]) and (rnd(3)=1)) or
							   ((mo IN [ 3,4,5,9 ]) and (rnd(5)=1)) or 
							   (rnd(8)=1)) and (weather<>black_clouds) then
							   	new_weather:=black_clouds
							else
								if ((not(mo IN [ 6..8 ])) and (rnd(3)=1)) or (rnd(5)=1) then
									if ((mo IN [11,1,2,3]) and (rnd(3)=1)) or (mo=12) then
										if rnd(2)=1 then
											new_weather:=snow
										else
											new_weather:=sleet
									else
										if (mo IN [ 10..12,1..4 ]) and (rnd(3)=1) then
											new_weather:=hail
										else
												if rnd(2)=1 then
													if weather=black_clouds then
													new_weather:=raining
												else
													new_weather:=light_rain
											else
												if weather=black_clouds then
													new_weather:=raining
												else
													new_weather:=pouring;
					light_rain,raining,pouring,hail:
						if ((mo IN [ 5,6,7,8 ]) and (rnd(3)<3)) or (rnd(2)=1) then
							begin
							new_weather:=pred(weather);
							if new_weather=black_clouds then
								case rnd(3) of
									1:
										new_weather:=overcast;
									2:
										new_weather:=cloudy;
									end;
							end
						else
							begin
							new_weather:=succ(weather);
							if new_weather>hail then
								new_weather:=pouring;
							end;
					sleet,snow:
						if rnd(2)=1 then
							case rnd(3) of
								1:
									new_weather:=overcast;
								2:
									new_weather:=cloudy;
								3:
									new_weather:=black_clouds;
								end
						else
							case rnd(2) of
								1:
									new_weather:=sleet;
								2:
									new_weather:=snow;
								end;
					end;
				end;
			if new_weather<>weather then
				begin
				if (weather IN [ light_rain, raining, pouring ]) and not(new_weather IN [ light_rain, raining, pouring ]) then
					tell_weather('It has stopped raining.',false);
				if (weather=snow) and not(new_weather in [snow, sleet]) then
					tell_weather('It has stopped snowing.',false);
				if (weather=sleet) and not(new_weather in [snow, sleet]) then
					tell_weather('The sleet has stopped.',false);
				if (new_weather=sunny) then
					tell_weather('The sun has come out.',true);
				if (new_weather IN [ overcast, cloudy ]) and (weather=sunny) then
					tell_weather('The sky begins to cloud over.',true);
				if (new_weather=black_clouds) and (weather IN [ sunny, overcast, cloudy ]) then
					tell_weather('Ominous black clouds are crossing the sky.',true);
				if (new_weather=light_rain) then
					tell_weather('It is raining lightly.',false);
				if (new_weather=raining) then
					tell_weather('It is raining.',false);
				if (new_weather=pouring) then
					begin
					tell_weather('It is pouring with rain.',false);
					destroy_event(14,0);
					set_event(14,0,0,1000+rnd(5000)*10);
					end;
				if (new_weather=hail) then
					begin
					tell_weather('It is hailing!',true);
					destroy_event(14,0);
					set_event(14,0,0,1000+rnd(6000)*10);
					end;
				if (new_weather=snow) then
					tell_weather('It is snowing heavily!',false);
				if (new_weather=sleet) then
					tell_weather('It is sleeting.',false);
				weather:=new_weather;
				if (weather=pouring) or (weather=snow) or (weather=sleet) or (weather=hail) then
					begin
					set_event(16,0,0,rnd(32000));
					set_event(17,0,0,rnd(15000));
					end;
				end;
			end;
		14:
			{ thunder! }
			if (weather=pouring) or (weather=hail) then
				begin
				tell_weather('There is a flash of lightning!',true);
				for lp:=87 to no_ob do
					if ob[lp].location>0 then
						if ob[lp].mobile and not(ob[lp].deaf) then
							wrtln(ob[lp].connect,'You hear a crash of distant thunder.');
				set_event(14,0,0,5000+rnd(30000));
				end;
		15:
			{ move the pirate ship }
			begin
			places[pirate].value[9]:=0;
			lp:=0;
			temp:=0;
			while (lp<5) and (temp=0) do
				begin
				lp:=lp+1;
				flag:=rnd(8);
				temp:=places[pirate].value[flag];
				if (temp>0) and (temp<=no_place) then
					begin
					if not((places[temp].wet) and (places[temp].value[9]=0) and (temp<>pirate)) then
						temp:=0
					end
				else
					temp:=0;
				end;
			if temp<>0 then
				begin
				dir_string(flag,false);
				tellall(pirate,0,concat('The galleon drifts off, ',dirs,'wards.'),true,false);
				pirate:=temp;
				vlocs[virtuals[16].rooms[1,1]]:=temp;
				places[pirate].value[9]:=821;
				places[821].value[10]:=pirate;
				places[821].value[12]:=pirate;
				tellall(pirate,0,'A large galleon drifts towards you.',true,false);
				end;
			set_event(15,0,0,2000+rnd(3000));
			end;
		16:
			{ weather check for boats }
			if (weather=pouring) or (weather=snow) or (weather=sleet) or (weather=hail) then
				begin
				{ decide which boat to upset }
				case rnd(2) of
					1:
						lp:=72;
					2:
						lp:=73;
					end;
				if ob[lp].carries<>0 then
					if ob[ob[lp].carries].mobile then
						if places[ob[ob[lp].carries].location].wet and
						  places[ob[ob[lp].carries].location].day and
						  (real_loc(lp)>=355) and (real_loc(lp)<411) then
							begin
							act(lp,'turns turtle!',true,false);
							dotext(ob[ob[lp].carries].connect,135,137);
							act(ob[lp].carries,'sinks slowly beneath the waves...',true,false);
							dead(ob[lp].carries);
							end;
				set_event(16,0,0,rnd(32000));
				end;
		17:
			if (weather=pouring) or (weather=snow) or (weather=sleet) or (weather=hail) then
				begin
				for lp:=1 to no_ob do
					if ob[lp].location>-1 then
						if not(ob[lp].mobile) then
							if (ob[lp].extinguish) and ob[lp].light and (rnd(10)=1) then
								if places[real_loc(lp)].day then
									begin
									act(lp,'fizzles and goes out.',true,false);
									ob[lp].light:=false;
									ob[lp].burns:=false;
									end;
				set_event(17,0,0,rnd(12000));
				end;
		18:
			if ob[flag].invisible then
				begin
				wrtln(ob[flag].connect,'Your invisibility spell has worn off!');
				ob[flag].invisible:=false;
				act(flag,'appears!',true,false);
				end;
		19:
			if ob[flag].shield then
				begin
				wrtln(ob[flag].connect,'Your shield spell has worn off!');
				ob[flag].shield:=false;
				act(flag,'is no longer shielded!',true,false);
				end;
		20:
			{ minute event, add 1 to all players' minutes }
			begin
			for lp:=1 to top do
				if position[lp,1]>2 then
					begin
					if position[lp,5]<>0 then
						people[position[lp,5]]^.minutes:=people[position[lp,5]]^.minutes+1;
					position[lp,14]:=position[lp,14]+1;
					if position[lp,14]=5 then
						wrtln(lp,'[ Timeout in 60 seconds. Press RETURN. ]');
					if position[lp,14]=6 then
						begin
						wrtln(lp,'[ No keyboard activity for 5-6 minutes. Timed out. ]');
						chuckoff(lp);
						end;
					end;
			set_event(20,0,0,12000);
			end;
		21:
			{ once every 3-4 seconds, scan through for drunkards etc }
			begin
			for lp:=87 to no_ob do
				if ob[lp].location>0 then
					if ob[lp].mobile then
						begin
						if (rnd(3)=1) and (ob[lp].drunk>0) then
							de_drunk(lp,1);
						if (rnd(3)=1) and (ob[lp].connect<>0) and (ob[lp].sc<819200) then
							ob[lp].thirsty:=ob[lp].thirsty+1;
						if ob[lp].thirsty=70 then
							begin
							wrtln(ob[lp].connect,'You''re feeling thirsty.');
							ob[lp].thirsty:=71;
							end;
						if ob[lp].thirsty=120 then
							wrtln(ob[lp].connect,'You''re dying of thirst.');
						if (rnd(4)=1) and (ob[lp].contdesc<>0) and (ob[lp].race<8) then
							begin
							temp:=1-(weigh(lp)-ob[lp].weight) DIV ((ob[lp].st DIV 3)+1)-(ob[lp].thirsty DIV 50);
							change_st(lp,temp);
							end;
						if ob[lp].thirsty>=125 then
							begin
							act(lp,'dies of thirst!',true,false);
							wrtln(ob[lp].connect,'You have died of thirst!');
							dead(lp);
							end;
						end;
			set_event(21,0,0,600+rnd(300));
			end;
		22:
			begin
			{ somebody's RESIST has expired }
			if resisting[flag]<>0 then
				if ob[resisting[flag]].location<>-1 then
					wrtln(ob[resisting[flag]].connect,'Your concentration fades... you are no longer resisting spells.');
			resisting[flag]:=0;
			end;
		23:
			if ob[flag].location<>-1 then
				begin
				wrtln(ob[flag].connect,'Your extra strength has worn off.');
				change_st(flag,-flag2);
				end;
		24:
			if ob[flag].location<>-1 then
				begin
				wrtln(ob[flag].connect,'Your extra dexterity has worn off.');
				change_dex(flag,-flag2);
				end;
		end;
	end;

begin
	initialise;
	pete_init;
	stop:=false;
	firstch:=-1;
	{ the main loop }
	writeln('Game started.');
	while not(stop) do
	begin
		{ check the terminals }
		for player:=1 to top do
		begin

			getcommand(player,inbuf [player]);
			if inbuf [player] [1] =  chr(2) then position [player] [1] := 1;
			if inbuf [player] [1] =  chr(3) then begin
				chuckoff(player);
				inbuf [player] [1] := chr(1);
			end;
			if inbuf [player] [1] <> chr(1) then begin
				return_pressed(player);
				send(player,'>');
			end;

		end;

		{ now check the events }
		for event_count:=1 to no_events do
		begin
			if event[event_count].time < systime
			then do_event(event_count)
			else note_event_time(event[event_count].time);
		end;
		poll;
	end;
end.
