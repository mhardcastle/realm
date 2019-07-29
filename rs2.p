function fsize(what : short_integer) : short_integer;

var lp,
    c_size	: short_integer;
    
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

procedure err(who,number : short_integer; fatal : boolean);

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

function forbidden(who,where : short_integer) : boolean;

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

{ a null program }

Begin
End.
