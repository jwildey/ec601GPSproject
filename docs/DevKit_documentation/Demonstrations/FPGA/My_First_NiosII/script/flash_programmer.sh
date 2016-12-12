#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-programmer-generate or nios2-flash-programmer-gui.
#

#
# Converting ELF File: D:\My_First_NiosII\software\My_First_NiosII\My_First_NiosII.elf to: "..\flash/My_First_NiosII_cfi_flash.flash"
#
$SOPC_KIT_NIOS2/bin/elf2flash --input="D:/My_First_NiosII/software/My_First_NiosII/My_First_NiosII.elf" --output="../flash/My_First_NiosII_cfi_flash.flash" --boot="$SOPC_KIT_NIOS2/components/altera_nios2/boot_loader_cfi.srec" --base=0x0 --end=0x4000000 --reset=0x0 --verbose 

#
# Programming File: "..\flash/My_First_NiosII_cfi_flash.flash" To Device: cfi_flash
#
$SOPC_KIT_NIOS2/bin/nios2-flash-programmer "../flash/My_First_NiosII_cfi_flash.flash" --base=0x0 --sidp=0x4081018 --id=0x0 --timestamp=1355109429 --device=1 --instance=0 '--cable=USB-Blaster on localhost [USB-0]' --program --verbose 

