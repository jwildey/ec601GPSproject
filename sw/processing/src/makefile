export COSS_ROOT = ..

include $(COSS_ROOT)/mk/config.mk

COSS_SRCS = coss_main.c coss_cfg.c
COSS_HDRS = 
COSS_OBJS = $(addprefix $(OBJS_PATH),$(COSS_SRCS:.c=.o))
COSS_BIN = $(addprefix $(BINS_PATH),green.exe)
LIBS += -lcoss -lconfig
INCS += -I.

all: $(COSS_BIN)
		
$(COSS_BIN): $(COSS_DIRS) $(COSS_OBJS)
	$(MAKE) -C rms all
	$(CC) $(LDFLAGS) -o $(@) $(COSS_OBJS) -L$(LIBS_PATH) $(LIBS)
	
$(COSS_OBJS): $(COSS_SRCS) $(COSS_HDRS)
	$(CC) $(CFLAGS) $(INCS) -o $(@) $(@F:.o=.c)
	
$(COSS_DIRS):
	mkdir -p $(COSS_DIRS)
	
clean:
	$(RM) $(COSS_OBJS) $(COSS_BIN)