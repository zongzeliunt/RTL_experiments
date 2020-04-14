#!/bin/csh -f

./clean.csh



# Build the models.
vlogan -cpp g++ -sysc -sc_model adder -sc_portmap the.map adder.v
vlogan -cpp g++ -sysc -sc_model multiplier -sc_portmap the.map multiplier.v
syscan -cpp g++ -cflags -g stimulus.cpp display.cpp subtracter.cpp top.cpp main.cpp

# Build the design with the given models.
vcs -cpp g++ -cc gcc -sysc -cflags -g -debug_access+all  -timescale=1ps/1ps  sc_main  -l comp_debug.log

