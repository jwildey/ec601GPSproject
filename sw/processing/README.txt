INTRODUCTION
------------
This document describes the Software Layout structure for GPS and is based on the Software Architecture Layered Design.


TOPOLOGY
--------

sw/src		  This is the top level source folder
sw/inc	  	This is the top level include folder for all public interfaces
sw/src/hal	This is the hardware abstraction layer containing the interface drivers
sw/src/dev	This is the device abstraction layer containing the device abstractions
sw/src/app	This is the application layer
sw/src/rms	This is the main application and scheduling

BUILD INSTRUCTIONS
--------

Products needed:
- GCC
- GNU Make

There is currently only a build spec for a linux target.  To start, open a terminal window and navigate to the sw/processing
folder. An entire makefile project was made to make the build process easier and the only thing necessary to build the software
is to type 'make' at the top level of the software source.
