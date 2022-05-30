#
# american fuzzy lop - makefile
# -----------------------------
#
# Written and maintained by Michal Zalewski <lcamtuf@google.com>
# 
# Copyright 2013, 2014, 2015, 2016, 2017 Google LLC All rights reserved.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at:
# 
#   http://www.apache.org/licenses/LICENSE-2.0
#

PROGNAME    = afl
VERSION     = $(shell grep '^\#define VERSION ' config.h | cut -d '"' -f2)

PREFIX     ?= /usr/local
BIN_PATH    = $(PREFIX)/bin
HELPER_PATH = $(PREFIX)/lib/afl
DOC_PATH    = $(PREFIX)/share/doc/afl
MISC_PATH   = $(PREFIX)/share/afl
DEPEN_PATH  = ../src/*.cpp

# PROGS intentionally omit afl-as, which gets installed elsewhere.

# PROGS       = afl-fuzz

CC         = g++
CFLAGS     ?= -fpermissive --std=c++11 -static-libstdc++
CFLAGS     += -g -w \
	      -DAFL_PATH=\"$(HELPER_PATH)\" -DDOC_PATH=\"$(DOC_PATH)\" \
	      -DBIN_PATH=\"$(BIN_PATH)\" -lpthread 

DEPDIR := .deps
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.d


COMPILE.c = $(CC) $(DEPFLAGS) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c

SRCS = afl-fuzz.cpp

# include depend.make

all: $(SRCS:%.cpp=%.o)

afl-fuzz.o: afl-fuzz.cpp $(DEPDIR)
	$(COMPILE.c) -g $^ $(DEPEN_PATH) $(LDFLAGS)  -lmysqlclient


.NOTPARALLEL: clean

clean:
	rm -f $(PROGS) afl-as as afl-g++ afl-clang afl-clang++ *.o *~ a.out core core.[1-9][0-9]* *.stackdump test .test test-instr .test-instr0 .test-instr1 qemu_mode/qemu-2.10.0.tar.bz2 afl-qemu-trace

$(DEPDIR): ; @mkdir -p $@

DEPFILES := $(SRCS:%.cpp=$(DEPDIR)/%.d)
$(DEPFILES):

include $(wildcard $(DEPFILES))
