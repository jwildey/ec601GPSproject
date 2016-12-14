# ec601GPSproject

INTRODUCTION
------------
This is a DIY GPS receiver project.  This project has an analog portion to it which is intended to have an antennae tuned to
to the GPS frequency and then perform some amplification and filtering to the signal.  The output of the analog circuitry is
then going to be input into an FPGA (Altera IV) on a DE2i-150 Development Kit.  The software on the FPGA is intended to perform
some digital signal processing on the incoming signal and indentify visible satellites, track their location in the bitsream
and calculate the receivers position base on the satellite navigation data.


TOPOLOGY
--------

documentation/ This folder contains all documention for the development kit and past projects used for examples
hw/            This folder contains all documentation for the analog ciruitry design
sw/            This folder contains all the source code developed for the project

