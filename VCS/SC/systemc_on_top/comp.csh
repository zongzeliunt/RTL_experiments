#!/bin/csh -f

./clean.csh

# Build the models.
vlogan -cpp g++ -sysc -sc_model adder -sc_portmap the.map adder.v
vlogan -cpp g++ -sysc -sc_model multiplier -sc_portmap the.map multiplier.v

syscan -cpp g++ stimulus.cpp display.cpp subtracter.cpp top.cpp main.cpp

# Build the design with the given models.
vcs -sysc sc_main -cpp g++ -cc gcc -timescale=1ps/1ps   -l comp.log 

