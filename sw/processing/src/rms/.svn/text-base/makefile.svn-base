export COSS_ROOT = ../..

include $(COSS_ROOT)/mk/config.mk

COSS_SRCS = \
	scheduler.c \
	thread1000hz.c \
	thread100hz.c \
	thread10hz.c \
	thread1hz.c
	
COSS_HDRS = \
	thread1000hz.h \
	thread100hz.h \
	thread10hz.h \
	thread1hz.h	

COSS_OBJS = $(addprefix $(OBJS_PATH),$(COSS_SRCS:.c=.o))
COSS_LIB = $(LIBS_PATH)libcoss.a
INCS += -I.

all: $(COSS_LIB)($(COSS_OBJS))

$(COSS_LIB)($(COSS_OBJS)): $(COSS_OBJS)
	$(AR) $(ARFLAGS) $(@) $(%)
		
$(COSS_OBJS): $(COSS_DIRS) $(COSS_SRCS) $(COSS_HDRS)
	$(CC) $(CFLAGS) $(INCS) -o $(@) $(@F:.o=.c)
	
$(COSS_DIRS):
	mkdir -p $(COSS_DIRS)
	
clean:
	$(RM) $(COSS_OBJS) $(COSS_LIB)