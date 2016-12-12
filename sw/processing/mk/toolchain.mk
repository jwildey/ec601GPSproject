CC = gcc
CXX = g++
MACHINE= x86_64
ARFLAGS= -ru
RM = rm -f
LDFLAGS = -ggdb

# Options are to have multi or single threaded executable with 
# Real-Time or Non-Realtime timing. On Windows only use the NRT version.
# The default with be to build Multi-threaded and Real-Time
DEFS = -DTHREAD_SINGLE -DCLOCK_NRT

ifeq ($(OS),Windows_NT)
	CFLAGS = -O0 -c -ggdb -Wall $(DEFS) -pipe -I/c/MinGW/include
else
	CFLAGS = -O0 -c -ggdb -Wall $(DEFS) -pipe -fPIC -I/usr/include
endif
