CC=clang
CFLAGS=-g -Wall -Werror -Wextra
LDFLAGS=

CFLAGS_DEBUG=-O0 -g -DDEBUG
CFLAGS_BUILT=-O2
SRC=src
OUT=build
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

build: $(BIN_RELEASE)

debug: $(BIN_DEBUG)

print-%  : ; @echo $* = $($*)

run: | debug
	./$(BIN_DEBUG)

$(BIN_DEBUG): $(OBJS_DEBUG) $(OBJ_DEBUG)
	$(CC) $(CFLAGS) $(CFLAGS_DEBUG) -o $@ $(LDFLAGS) $<

$(OBJ_DEBUG)/%.o: $(SRC)/%.c $(OBJ_DEBUG)
	$(CC) -c $(CFLAGS) $(CFLAGS_DEBUG) -o $@ $<

$(OBJ_DEBUG):
	mkdir -p $@

$(BIN_RELEASE): $(OBJS_RELEASE) $(OBJ_RELEASE)
	$(CC) $(CFLAGS) $(CFLAGS_RELEASE) -o $@ $(LDFLAGS) $<
	strip $@

$(OBJ_RELEASE)/%.o: $(SRC)/%.c $(OBJ_RELEASE)
	$(CC) -c $(CFLAGS) $(CFLAGS_RELEASE) -o $@ $<

$(OBJ_RELEASE):
	@mkdir -p $@

clean:
	@rm -rf $(OUT)
