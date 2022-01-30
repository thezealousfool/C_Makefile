CC=clang
CFLAGS=-std=c99 -pedantic -g -Wall -Werror -Wextra
LDFLAGS=
DEBUGGER=lldb

CFLAGS_DEBUG=-O0 -g -DDEBUG
CFLAGS_RELEASE=-flto -O2
LDFLAGS_DEBUG=
LDFLAGS_RELEASE=-flto
SRC=src
OUT=target
OBJ=obj
BIN=proj1

DEBUG=debug
OBJ_DEBUG=$(OUT)/$(DEBUG)/$(OBJ)
BIN_DEBUG = $(OUT)/$(DEBUG)/$(BIN)

RELEASE=release
OBJ_RELEASE=$(OUT)/$(RELEASE)/$(OBJ)
BIN_RELEASE = $(OUT)/$(RELEASE)/$(BIN)

SRCS=$(wildcard $(SRC)/*.c)
OBJS_DEBUG=$(patsubst $(SRC)/%.c, $(OBJ_DEBUG)/%.o, $(SRCS))
OBJS_RELEASE=$(patsubst $(SRC)/%.c, $(OBJ_RELEASE)/%.o, $(SRCS))

.PHONY: all build debug run clean test

all: run

test:
	@echo "No tests implemented yet"

build: | clean_build $(BIN_RELEASE)

debug_build: $(BIN_DEBUG)

debug: debug_build
	$(DEBUGGER) $(BIN_DEBUG)

run: debug_build
	./$(BIN_DEBUG)

$(BIN_DEBUG): $(OBJS_DEBUG) $(OBJ_DEBUG)
	$(CC) $(CFLAGS) $(CFLAGS_DEBUG) -o $@ $(LDFLAGS) $(LDFLAGS_DEBUG) $<

$(OBJ_DEBUG)/%.o: $(SRC)/%.c $(OBJ_DEBUG)
	$(CC) -c $(CFLAGS) $(CFLAGS_DEBUG) -o $@ $<

$(OBJ_DEBUG):
	mkdir -p $@

$(BIN_RELEASE): $(OBJS_RELEASE) $(OBJ_RELEASE)
	$(CC) $(CFLAGS) $(CFLAGS_RELEASE) -o $@ $(LDFLAGS) $(LDFLAGS_RELEASE) $<
	strip $@

$(OBJ_RELEASE)/%.o: $(SRC)/%.c $(OBJ_RELEASE)
	$(CC) -c $(CFLAGS) $(CFLAGS_RELEASE) -o $@ $<

$(OBJ_RELEASE):
	@mkdir -p $@

clean:
	@rm -rf $(OUT)

clean_build:
	@rm -rf $(OUT)/$(RELEASE)
