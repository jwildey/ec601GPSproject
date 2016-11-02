LINT=splint

ifeq ($(OS),Windows_NT)
SYSDIR=$(WIND_BASE)
else
SYSDIR=/usr/include
endif

LFLAGS = \
	+checks \
	+linelen 160 \
	+quiet \
	+limit 99 \
	+try-to-recover \
	+shortint \
	+posixlib \
	+enumindex \
	-unqualifiedtrans \
	-declundef \
	-namechecks \
	-stringliteralsmaller \
	-readonlytrans \
	-incon-defs \
	-compdef \
	-mustfreefresh \
	-mustfreeonly \
	-temptrans \
	-mayaliasunique \
	-exportlocal \
	-nullassign \
	-nullstate \
	-nullpass \
	-nullret \
	-paramuse \
	-globstate \
	-preproc \
	-must-define \
	-macroredef \
	-immediatetrans \
	-retalias \
	+impouts \
	-sysdirs $(SYSDIR)

max_col_exceeded = test `wc -L $(1) | sort | head -n 1 | cut -c1-5` -gt 80
max_col_num = wc -L $1 | sort | head -n 1 | cut -c1-5
max_col_file = $(shell wc -L $(1) | sort | head -n 1 | cut -c7-)

#climit:
#ifeq (1,$(if $(call max_col_exceeded, $(SRCS)),1,0))
#	$(info $(call max_col_file, $(SRCS)):1:1 File exceeds 80 char limit)
#endif
