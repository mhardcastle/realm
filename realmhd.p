const top = 17; { 3 for normal, 17 for C'net, 6 for Muxer }
      bufsize=10000; { 6000 for Cnet }
      maxobject=280;
      maxloc=895;
      max_pers=200; { 200 for Cnet }
      max_event=100;
      maxlsize=263000;

TYPE	player_range = 1..top;
        pm_range = 0..top;
        body_range = 1..4;
	line = string[80];
	block = packed array[1..512] of char;
	locarray = packed array[0..maxlsize] of char;
	obj_at = RECORD
		name	: string[20];
		location,
		descr,
		contdesc,
                size,
		weight	: integer;
		carries : integer;
		CASE mobile : boolean of
		true:	( movem	: string[10];
			  st,
			  con,
			  dex,
			  magic,
			  max_st,
			  max_con,
			  max_dex,
			  max_magic,
			  control	: integer;
			  weapon1,
			  weapon2,
			  connect,
			  fighting,
			  dislike,
			  thirsty,
			  drunk,
			  race,
			  class,
			  obey		: integer;
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
			  sleep		: boolean;
			  sc		: integer );
	  	 false:	( value : integer;
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
			  kept	: boolean );
	  	 end;
	persona = ^pers_at;
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
	location = RECORD
		 name		: string[16];
		 value		: array [1..12] of integer;
		 dark,
		 wet,
		 day		: boolean;
		 end;
	door = RECORD
		 name		: string[40];
		 first,
		 second,
		 key1,
		 key2		: integer;
		 open,
		 break,
		 openable,
		 broken,
		 s_hole		: boolean;
		 end;
	categ = RECORD
		 name		: string[16];
		 objects	: array[1..16] of array[1..2] of integer;
		 end;
	str255 = string[255];
	in_buffer = string[128];
	com_range = 0..8;
	com_element = RECORD
		 case which : com_range of
			0: ( error : boolean );
		 	1: ( vb : integer );
		 	2: ( object : integer );
		 	3: ( category : integer );
		 	4: ( number : integer );
		 	5: ( quoted : string[126] );
		 	6: ( slashed : string[16] );
		 	7: ( liquid : integer );
		 	8: ( virtual : integer );
		 end;
	blow_type = RECORD
		blow_sub : boolean;
		active : string[50];
		passive : string[50];
		invariant : string[50];
		end;
	mess_type = RECORD
		valid	: boolean;
		from,
		address,
		no_strs	: integer;
		time_st	: integer;
		txt	: array[1..8] of line;
		end;
	riddle_type = RECORD
		question	: string[200];
		answer1		: string[16];
		answer2		: string[16];
		end;
	we_type	= ( sunny, overcast, cloudy, black_clouds, light_rain, raining, pouring, hail, sleet, snow );
	line_pt	= ^line;
	exam_type = record
		what		: integer;
		read,
		when_carried	: boolean;
		lines		: 0..15;
		examtxt		: array[1..15] of line_pt;
		end;
	exam = ^exam_type;
	wall_type = record
		where1,
		where2,
		direction	: integer;
		fire		: boolean;
		end;
	mobact_type = record
		which		: integer;
		hear		: boolean;
		what		: line;
		end;
	liquid_type = record
		name		: string[16];
		describe	: string[40];
		howmany		: integer;
		end;
	emote = record
		vrb		: integer;
		audio		: boolean;
		what		: string[32];
		end;
	virtual_type = record
		name		: string[16];
		howmany		: 0..5;
		door_f		: array[1..5] of boolean;
		lines		: array[1..5] of 0..6;
		examtxt		: array[1..5,1..6] of line_pt;
		rooms		: array[1..5,1..2] of integer;
		end;
	help_atom = record
		name		: string[40];
		startline,
		endline		: integer;
		immortal	: boolean;
		end;
	event_type = record
		kind,
		flag,
		flag2		: integer;
		time		: integer;
		end;
	verbal = record
		words		: string[90];
		spoken		: boolean;
		end;

var infile,
    log_file	: text;
    obj_file	: file of obj_at;
    door_file	: file of door;
    loc_file	: file of location;
    pers_file	: file of pers_at;
    cat_file    : file of categ;
    mess_file	: file of mess_type;
    blow_file	: file of blow_type;
    desfile	: file of block;

    buffer	: array[player_range] of packed array[1..bufsize] of char;
		  { circular output buffer }
    name	: array[player_range] of string[22];
		  { temp name while creating new persona }
    position	: array[player_range] of array[1..15] of integer;
		  { [1] is the current state ie 0 - not on, 100 - playing,
		    [2] is the current x position of the terminal,
		    [3] is the "head" in the buffer,
		    [4] is the "chaser",
		    [5] is the persona connected to this terminal.
		    [6] is the object connected to this terminal
		    [7] is the CONNECT of the persona/mobile possessed
		    [8] is the object number of mobile being possessed
		    [9] is the connect value of the persona snooping on you
		   [10] is the current indent value
		   [11] is the number of letters of the 'logoffst' word in 
     		   [12] is the 'good_device flag' for m'plexer
     		   [13] is the 'ignore counter' for m'plexer
		   [14] is the timeout counter, in minutes
		   [15] is the echo status (0-local, 1-c'net type) }
    commands	: array[1..10] of com_element;
    psize	: array[player_range] of integer;
    curr_mess	: array[player_range] of mess_type;
    inbuf	: array[player_range] of in_buffer;
    cur_b	: array[1..64] of array[1..6] of integer;
    		  { 1 : who's striking, 2 : where, 3 : what weapon (1/2)
		    4 : event #, 5 : blow type (1..6) 6 : weapon (ob #) }
    blows	: array[1..18] of blow_type;
    event	: array[1..max_event] of event_type;
    fight	: array[1..97] of string[23];
    places	: array[1..maxloc] of location;
    l_pointer	: array[1..maxloc] of integer;
    ob		: array[1..maxobject] of obj_at;
    people	: array[1..max_pers] of persona;
    doors	: array[1..32] of door;
    categs	: array[1..20] of categ;
	{ categs[1].objects[1,2] should always be no_ob! }
    descs	: array[1..110] of string[60];
    liquids	: array[1..10] of liquid_type;
    verb	: array[1..210] of string[16];
    liqloc	: array[1..100] of integer;
    number	: array[1..85] of integer;
    level	: array[1..100] of string[16];
    races	: array[1..12] of string[16];
    emotes	: array[1..32] of emote;
    riddle	: array[1..25] of riddle_type;
    ssn		: array[1..10] of integer; { the supersnoopers }
    follows	: array[1..40,1..2] of integer;
    suppress	: array[player_range,1..2] of boolean; { 1 sup's o/p,2 i/p }
    walls	: array[1..30] of wall_type;
    acts	: array[1..8] of mobact_type;
    help_item	: array[1..12] of help_atom;
    help_txt	: array[1..460] of line;
    sysmess	: array[1..50] of line;
    coder	: array[1..50] of line;
    vlocs	: array[1..200] of integer;
    virtuals	: array[1..30] of virtual_type;
    tdata	: array[1..189] of line;
    swear	: array[1..10] of string[10];
    exerrs	: array[1..25] of line;
    examine	: array[1..32] of exam;
    tcode	: array[1..6] of integer;
    resisting	: array[1..20] of integer;
    spellvb	: array[1..28] of verbal;
    blackboard  : array[1..10] of string[126];

    loctxt	: ^locarray;

    rdin	: char;
    player	: player_range;
    no_com	: 0..10;
    no_events	: 0..max_event;
    no_fol	: 0..50;
    no_ssn	: 0..10; { the number of supersnoopers }
    palm_dig	: 0..3;
    volc_mins	: 0..59;
    weather,
    new_weather	: we_type;

    blow_no,	  { the number of blows "in the air" at present }
    no_sysm,
    no_coder,
    no_wall,	  { how many magic walls - max of 30 }
    no_acts, 	  { how many random mobile actions }
    no_place,
    no_ob,
    no_people,
    no_door,
    no_desc,
    no_liquids,
    no_cat,
    no_riddle,
    no_emote,
    no_virtual,
    no_help,
    no_verb,
    fixed_ob, { the number of objects present after a reset }
    curcat,
    curob,
    curcpos,
    curcno,
    acidlake,
    pirate,
    c_riddle,
    pandora_per,
    lp,
    temp,
    r_h,
    r_m,
    r_s,
    h,
    m,
    s,
    d,
    mo,
    y,
    ar1,
    no_exam,
    ar2,
    swears,
    firstch,
    default_wd,
    event_count,
    noterms,
    pers_edit,
    editwhat,
    stocks,
    balloon,
    whosays,
    leverp1,
    leverp2,
    blackpt	: integer;

    stop,
    curstop,
    end_search,
    lever1,
    lever2,
    ice_melt,
    water_f,
    wall_hole,
    sesame,
    volcano,
    nine_to_1,
    kobolds_bl,
    clockwk,
    clockwnd,
    seaweed,
    ice_pond,
    mirror,
    glass_sh,
    tree,
    rockfall,
    nastytree,
    grassburn,
    garg_pd,
    peace,
    resetting,
    dragonwoken,
    duckfl,
    turnstile,
    swap,	  { do we want to swap discs }
    memory,	  { are we keeping locs in memory }
    register,	  { do we register people on creation }
    good_dev,	  { is this a good device, muxer }
    cnet	: boolean; { is this a c'net system }

    stoptime,
    messageno,
    w_time,
    arena_bonus,
    time_ct	: integer;

    dirs,
    logoffst	: string[20];
    junk	: str255;
    main_drv,
    locs_drv	: string[32];

