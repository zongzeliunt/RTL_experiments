all : comp run 

clean :
	\rm -fr csrc AN.DB DVEfiles/ *.vpd 
	\rm -fr simv* *.log DEFAULT.DB AN.DB/

clean1 :
	\rm -fr csrc AN.DB DVEfiles/ *.vpd 
	\rm -fr simv* *.log DEFAULT.DB AN.DB/

comp : clean
	vlogan -full64 -sysc -cpp g++-4.8 -sc_model adder -sc_portmap the.map adder.v
	syscsim -full64 -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -sysc -cflags -g -debug_access+all  -timescale=1ps/1ps  stimulus.cpp display.cpp top.cpp main.cpp  -l comp_debug.log

run :
	./simv -l run_debug.log  -gui -i systemc_on_top.tcl


