VERSION = 1.0
PREFIX = /usr
CC = gcc

BIN = gendoc
SRC = gendoc.c

all: $(BIN)

gendoc:
	$(CC) $(SRC) -o $@

install: all
	mkdir -p $(PREFIX)/bin
	cp -f $(BIN) $(PREFIX)/bin

uninstall:
	cd $(PREFIX)/bin && rm -f $(BIN)

clean:
	rm -f $(BIN)
