#PROFILE = -O2 -s
#CFLAGS = $(PROFILE)
#LDFLAGS = -lmodbus -lsqlite3 -lconfig

CC = gcc 
CFLAGS = -Os -Wall -Wmissing-declarations -g3
CPPFLAGS = -I../inc -I./ -I$(STAG_DIR)/usr/include
LDFLAGS  = -lmodbus -lsqlite3 -lconfit -L$(STAG_DIR)/usr/lib -L./

all: main

# build it
main:
	$(CC) $(CFLAGS) mb2sql.c $(LDFLAGS) -o mb2sql

# clean it
clean:
	rm mb2sql
