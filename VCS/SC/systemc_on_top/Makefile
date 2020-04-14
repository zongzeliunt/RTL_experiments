all : comp run comp_debug run_debug

## by calling 'clean' in two rules, results that it is called only once.
## however, for the second build 'comp_debug' the old results are still 
## there. By calling explictly a different clean target removes the 
## intermediate files again. Especially needed for SystemC-on-top designs,
## elaborating with different options. 

clean :
	\rm -fr csrc AN.DB DVEfiles/ *.vpd 
	\rm -fr simv* *.log DEFAULT.DB AN.DB/

clean1 :
	\rm -fr csrc AN.DB DVEfiles/ *.vpd 
	\rm -fr simv* *.log DEFAULT.DB AN.DB/

comp : clean
	vlogan -cpp g++ -sysc -sc_model adder -sc_portmap the.map adder.v
	vlogan -cpp g++ -sysc -sc_model multiplier -sc_portmap the.map multiplier.v
	syscsim -cpp g++ -cc gcc -sysc -timescale=1ps/1ps  stimulus.cpp display.cpp subtracter.cpp top.cpp main.cpp -l comp.log 	

run :
	simv -l run.log 


comp_debug : clean1
	# Build the models.
	vlogan -cpp g++ -sysc -sc_model adder -sc_portmap the.map adder.v
	vlogan -cpp g++ -sysc -sc_model multiplier -sc_portmap the.map multiplier.v
	# Build the design with the given models.
	syscsim -cpp g++ -cc gcc -sysc -cflags -g -debug_access+all  -timescale=1ps/1ps  stimulus.cpp display.cpp subtracter.cpp top.cpp main.cpp  -l comp_debug.log

run_debug:
	# Execute the simulation
	./simv -l run_debug.log  -gui -i systemc_on_top.tcl



