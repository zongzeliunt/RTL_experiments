#!/bin/csh -f

# remove previously compiled models (if any)
./clean.csh

# Build the models (could also have been executed from
# the same command line.  I.e.  syscan sc_add.cpp:sc_add sc_subtracter.cpp:sc_subtracter
syscan -cpp g++ sc_add.cpp:sc_add -cflags "-g"

syscan -cpp g++ sc_subtracter.cpp:sc_subtracter -cflags "-g"

# Build the design
vcs -cpp g++ -cc gcc -sysc -debug_access+all  top.v multiplier.v -timescale=1ps/1ps -l comp_debug.log 

