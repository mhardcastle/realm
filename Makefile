P2CLIB = /home/mjh/git/p2c/home
P2CEXE = /home/mjh/git/p2c/p2c
COPTS=	-g

all:	realm 

build:  realm makedata

clean:	FORCE
	rm -f *~ *.o r2.c rs.c realm

FORCE:

cleanall: clean
	rm -f  c_blo.c c_blo c_cat.c c_cat c_door.c c_door c_loc.c c_loc c_obj.c c_obj c_pers.c c_pers

realm:	r2.o rs.o pete.o
	gcc $(COPTS) -o realm r2.o rs.o pete.o -L$(P2CLIB) -lp2c -lcrypt

r2.o:	r2.c
	gcc $(COPTS) -c r2.c -I$(P2CLIB)

rs.o:	rs.c
	gcc $(COPTS) -c rs.c -I$(P2CLIB)

pete.o:	pete.c constants.h
	gcc $(COPTS) -c pete.c

constants.h:	realmhd.p
	@echo '/* DO NOT EDIT - THIS FILE WAS AUTOMATICALLY GENERATED FROM REALMHD.P */' > constants.h
	awk '/bufsize=[^{]*{.*/ { printf "#define BUFSIZE "; gsub("bufsize *=","",$$0); gsub(";.*",""); print $$0 } /.* top *=.*/ { printf "#define TOP "; gsub(".*top *=",""); gsub(";.*",""); print }' <realmhd.p >>constants.h

r2.c:	r2.p realmhd.p
	$(P2CEXE) r2.p
	awk '/#include/ {print;print "#undef Static\n#define Static /* nothing */"} ! /#include/ {print}' <r2.c >tmp
	mv tmp r2.c

rs.c:	rs.p realmhd.p
	$(P2CEXE) rs.p
	awk '/#include/ {print;print "#undef Static\n#define Static extern"} ! /#include/ {print}' <rs.c >tmp
	sed -i -e 's/return isupper(c)/return isupper(c)>0/' tmp
	sed -i -e 's/return islower(c)/return islower(c)>0/' tmp

	mv tmp rs.c

convert: c_blo c_cat c_door c_loc c_obj c_pers

c_blo:	c_blo.p
	$(P2CEXE) $@.p
	gcc $(COPTS) -I$(P2CLIB) -L$(P2CLIB) $@.c -l p2c -o $@

c_cat:	c_cat.p
	$(P2CEXE) $@.p
	gcc $(COPTS) -I$(P2CLIB) -L$(P2CLIB) $@.c -l p2c -o $@

c_door:	c_door.p
	$(P2CEXE) $@.p
	gcc $(COPTS) -I$(P2CLIB) -L$(P2CLIB) $@.c -l p2c -o $@

c_loc:	c_loc.p
	$(P2CEXE) $@.p
	gcc $(COPTS) -I$(P2CLIB) -L$(P2CLIB) $@.c -l p2c -o $@

c_obj:	c_obj.p
	$(P2CEXE) $@.p
	gcc $(COPTS) -I$(P2CLIB) -L$(P2CLIB) $@.c -l p2c -o $@

c_pers:	c_pers.p
	$(P2CEXE) $@.p
	gcc $(COPTS) -I$(P2CLIB) -L$(P2CLIB) $@.c -l p2c -o $@

makedata: convert
	./c_blo
	./c_cat
	./c_door
	./c_loc
	./c_obj
	./c_pers
