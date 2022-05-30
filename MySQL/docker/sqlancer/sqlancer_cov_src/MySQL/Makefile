SUB_DIRS := src AFL

LIB_SRCS := $(wildcard src/*.cpp) 
COMM_OBJS := $(patsubst %.cpp,%.o,$(LIB_SRCS))
DEPEN_PATH  = ../src/*.cpp 

AFL_OBJS := AFL/afl-fuzz.o $(COMM_OBJS)

MYSQL_INCLUDE_PATH = /usr/include/mysql
MYSQL_LIB_PATH = 

export CC = g++
export DEBUG =
export OPT = -O3
export CFLAGS = -std=c++17 -fpermissive -static-libstdc++ $(DEBUG) $(OPT) $(ASAN_FLAGS)
LDFLAGS = -ldl -lmysqlclient -pg -lpthread 


all: afl-fuzz


$(SUB_DIRS):
	@$(MAKE) -C $@

afl-fuzz: $(SUB_DIRS)
	$(CC) $(CFLAGS) $(AFL_OBJS) -o $@ $(LDFLAGS) $(PARSER_LINK_FLAGS)

debug: DEBUG = -g
debug: OPT = -O0
debug:
	$(MAKE) -e

asan: ASAN_FLAGS = -fsanitize=address
asan: DEBUG = -g
asan: OPT = -O0
asan:
	$(MAKE) -e

.PHONY: $(SUB_DIRS)

clean:
	@make clean -C src
	@make clean -C AFL
	rm -rf afl-fuzz
