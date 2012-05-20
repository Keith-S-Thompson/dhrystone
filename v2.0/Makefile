#
#	Adjust for your system
#
#	TIME_FUNC, STRUCTASSIGN, and ENUMS selectable by changing order
#
CC=		cc			# C compiler name goes here

TIME_FUNC=	-DTIME			# Use time(2) for measurement
TIME_FUNC=	-DTIMES			# Use times(2) for measurement
HZ=		60			# Frequency of times(2) clock ticks

STRUCTASSIGN=	-DNOSTRUCTASSIGN	# Compiler cannot assign structs
STRUCTASSIGN=				# Compiler can assign structs

ENUMS=		-DNOENUMS		# Compiler doesn't have enum type
ENUMS=					# Compiler does have enum type

OPTIMIZE=	-O			# Optimization Level

LFLAGS=					#Loader Flags

CFLAGS=	$(OPTIMIZE) $(TIME_FUNC) -DHZ=$(HZ) $(ENUMS) $(STRUCTASSIGN) $(CFL)

#
#		You shouldn't need to touch the rest
#
SRC=	dhry_pack_1.c dhry_pack_2.c
HDR=	dhry_global.h

all:	dry2 dry2reg

dry2:		$(SRC) $(HDR)
		$(CC) $(CFLAGS) $(SRC) $(LFLAGS) -o $@

dry2reg:	$(SRC) $(HDR)
		$(CC) $(CFLAGS) -DREG=register $(SRC) $(LFLAGS) -o $@

shar:	dry2shar.1 dry2shar.2 dry2shar.3

dry2shar.1: README.RER Makefile submit.frm
	shar -p X README.RER Makefile submit.frm >$@

dry2shar.2: README $(HDR) $(SRC)
	shar -p X README $(HDR) $(SRC) >$@

dry2shar.3: dhry.p
	shar -p X dhry.p >$@

clean:
	-rm -f *.o

clobber: clean
	-rm -f dry2 dry2reg dry2shar.*

post:
	for i in 1 2 3;\
	do\
		cat HEADERS BOILER.$$i dry2shar.$$i |\
		inews -h -t "Dhrystone 2.0 ($$i of 3)" -n comp.arch;\
	done
