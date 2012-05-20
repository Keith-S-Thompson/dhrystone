CFLAGS = 
TIME = time

all: rundhrystone rundhrystoneR rundhrystoneO rundhrystoneRO

dhrystone: dhrystone.c
	$(CC) dhrystone.c -o dhrystone

rundhrystone: dhrystone
	@echo 'Running dhrystone (Level 1 optimization, without registers)'
	./dhrystone
	./dhrystone
	./dhrystone
	@echo


dhrystoneR: dhrystone.c
	$(CC) -DREG=register dhrystone.c -o dhrystoneR

rundhrystoneR: dhrystoneR
	@echo 'Running dhrystone (Level 1 optimization, with registers)'
	./dhrystoneR
	./dhrystoneR
	./dhrystoneR
	@echo


dhrystoneO: dhrystone.c
	$(CC) -O dhrystone.c -o dhrystoneO

rundhrystoneO: dhrystoneO
	@echo 'Running dhrystone (Level 2 optimization, without registers)'
	./dhrystoneO
	./dhrystoneO
	./dhrystoneO
	@echo


dhrystoneRO: dhrystone.c
	$(CC) -O -DREG=register dhrystone.c -o dhrystoneRO

rundhrystoneRO: dhrystoneRO
	@echo 'Running dhrystone (Level 2 optimization, with registers)'
	./dhrystoneRO
	./dhrystoneRO
	./dhrystoneRO
	@echo


clean:
	(set nonomatch;rm -f dhrystone dhrystoneR dhrystoneO dhrystoneRO *.o)
