# FPGA Software

INTRODUCTION
------------
This document describes the Software Layout structure for the FGPA used for the GPS HW Project.


TOPOLOGY
--------

sw/fpga/src		              This is the top level source folder
sw/fpga/src/chip_freq_NCO   This is the source folder for the Numerically controlled oscillator for the FPGA
sw/fpga/src/db              This is a folder containing results from compilations
sw/fgpa/src/grebox_tmp      This is a folder containing a text file for project arguments
sw/fpga/src/incremental_db  This is a folder containing incremental results from compilations
sw/fpga/src/nios_cpu        This is the source folder for the NIOS Soft CPU for the FPGA
sw/fpga/src/output_files    This is the folder to contain the SOF image file of the build FPGA software
sw/fpga/src/software        This is the source folder containing the C code that is run on NIOS Soft CPU

BUILD INSTRUCTIONS
--------

Products needed:
- Quartus 16.1 Standard
- DE2i-150 Development Kit

1. Open up the FPGA project file GPS.qpf
2. In the project navigator, open up the files view.
3. Open up the nios_cpu.qsys file, this will open a new window for Altera's QSYS editor
4. In the bottom right corner, click on Generate HDL.  This will bring up a window of its status and can be closed when finished.
5. Back in the main Quartus window, click on Processing pull down menu and click on Start Compilation
6. The result of this compilation will produce the SOF file needed to load onto the FPGA.
7. Next Click on the Tools pull down menu and open up NIOS II Software Build Tools for Eclipse
8. This will open up the C Code projects used on the NIOS II Soft CPU
9. Right-click on the gps_nios_bsp project in the Project Explorer view, expand the NIOS II sub-menu and click on Generate BSP
10. Click on the Project pull down menu from the tool bar and click Build All.  This will build both projects
11. Click on the NIOS II pull down menu from the tool bar and click Quartus Prime Programmer
12. Click Add File..., navigate to the output SOF file in the output_files folder
13. Click OK on the notifications about the file being time limited.
14. Make sure the checkbox under Program/Configure is checked and hit Start
NOTE:  DO NOT CLOSE THE PROGRAMMER WINDOW 
15. The project can now be run on the FPGA with the Play button or from the Run pull down menu
16. If the play button does not work, the connection may need to be refreshed.  To do this, go the run configurations window from the Run pull down menu
17. Click on the Target Connection tab and hit Refresh Connections
