export GPS_ROOT = .

include $(GPS_ROOT)/mk/config.mk

all clean: $(GPS_DIRS)
	$(MAKE) -C src $(@)
	
$(GPS_DIRS):
	mkdir -p $(GPS_DIRS) 	
	
clobber:
	$(RM) -r obj lib bin