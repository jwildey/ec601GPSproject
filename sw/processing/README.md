# Processing Software

INTRODUCTION
------------
This document describes the Software Layout structure for GPS and is based on the Software Architecture Layered Design.


TOPOLOGY
--------

sw/processing/src		  This is the top level source folder
sw/processing/inc	  	This is the top level include folder for all public interfaces
sw/processing/src/hal	This is the hardware abstraction layer containing the interface drivers
sw/processing/src/dev	This is the device abstraction layer containing the device abstractions
sw/processing/src/app	This is the application layer
sw/processing/src/rms	This is the main application and scheduling

BUILD INSTRUCTIONS
--------

Products needed:
- GCC
- GNU Make

There is currently only a build spec for a linux target.  To start, open a terminal window and navigate to the sw/processing
folder. An entire makefile project was made to make the build process easier and the only thing necessary to build the software
is to type 'make' at the top level of the software source.
