#!/bin/csh -f

./clean.csh


syscan  -cpp g++   sc_add.cpp:sc_add 
syscan  -cpp g++   sc_subtracter.cpp:sc_subtracter 
vcs  -cpp g++ -cc gcc  -sysc top.v multiplier.v -timescale=1ps/1ps -l comp.log

