INTRODUCTION
------------
This document describes the Software Layout CSCI structure for COSS and is based on the Software Architecture Layered Design.


TOPOLOGY
--------

sw/src		This is the top level source folder containing the 5 CSCs
sw/inc		This is the top level include folder for all CSC public interfaces
sw/src/hal	This is the hardware abstraction layer containing the interface drivers
sw/src/dev	This is the device abstraction layer containing the device abstractions (e.g. LN251)
sw/src/img	This is the image pipeline and contains all the CUDA kernel code
sw/src/app	This is the application layer containing all the Navigation and Object Tracking CSUs
sw/src/rms	This is the main application and scheduling CSC.

