#:%s/^[ ]\+/\t/g
all : comp run 

clean :
	if [ -e csrc ]; then rm -r csrc; fi
	if [ -e simv ]; then rm simv; fi
	if [ -e simv.daidir ]; then rm -r simv.daidir; fi
	if [ -e vnc_logs ]; then rm -r vnc_logs; fi
	if [ -e ucli.key ]; then rm ucli.key; fi
	if [ -e waveforms.vpd ]; then rm waveforms.vpd; fi
	if [ -e inter.vpd ]; then rm inter.vpd; fi
	if [ -e DVEfiles ]; then rm -r DVEfiles; fi
	if [ -e AN.DB ]; then rm -r AN.DB; fi
	if [ -e run_debug.log ]; then rm -r run_debug.log; fi
	if [ -e .vlogansetup.args ]; then rm .vlogansetup.args; fi
	if [ -e .vlogansetup.env ]; then rm .vlogansetup.env ; fi





clean1 :
	\rm -fr csrc AN.DB DVEfiles/ *.vpd 
	\rm -fr simv* *.log DEFAULT.DB AN.DB/

comp : clean
	vlogan -full64 -sysc -cpp g++-4.8 -sc_model adder -sc_portmap the.map adder.v
	syscsim -full64 -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -sysc -cflags -g -debug_access+all  -timescale=1ps/1ps  stimulus.cpp display.cpp top.cpp main.cpp  -l comp_debug.log

run :
	./simv -l run_debug.log  -gui -i systemc_on_top.tcl


