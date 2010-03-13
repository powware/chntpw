#
# Makefile for the Offline NT Password Editor
#
#
# Change here to point to the needed OpenSSL libraries & .h files
# See INSTALL for more info.
#

#SSLPATH=/usr/local/ssl
OSSLPATH=/usr
OSSLLIB=$(OSSLPATH)/lib
OSSLINC=$(OSSLPATH)/include

CC=gcc
CFLAGS= -DUSEOPENSSL -g -I. -I$(OSSLINC) -Wall -m32


# This is to link with whatever we have, SSL crypto lib we put in static
LIBS=-L$(OSSLLIB) $(OSSLLIB)/libcrypto.a

all: chntpw chntpw.static cpnt

chntpw: chntpw.o ntreg.o
	$(CC) $(CFLAGS) -o chntpw chntpw.o ntreg.o $(LIBS)

chntpw.static: chntpw.o ntreg.o
	$(CC) -static $(CFLAGS) -o chntpw.static chntpw.o ntreg.o $(LIBS)

cpnt: cpnt.o
	$(CC) $(CFLAGS) -o cpnt cpnt.o $(LIBS)

#ts: ts.o ntreg.o
#	$(CC) $(CFLAGS) -nostdlib -o ts ts.o ntreg.o $(LIBS)

# -Wl,-t

.c.o:
	$(CC) -c $(CFLAGS) $<

clean:
	rm -f *.o chntpw chntpw.static *~

