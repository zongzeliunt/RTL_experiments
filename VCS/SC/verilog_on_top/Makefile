#all : comp run comp_debug  run_debug  
all : comp run  

clean :
	\rm -rf csrc AN.DB simv* *.log DEFAULT.DB   DVEfiles/ *.vpd ucli.key .vlogansetup.args .vlogansetup.env


comp : clean
	syscan  -full64 -cpp g++-4.8 -cc gcc-4.8 -sysc=2.3 sc_add.cpp:sc_add 
	syscan  -full64 -cpp g++-4.8 -cc gcc-4.8 -sysc=2.3 sc_subtracter.cpp:sc_subtracter 
	vcs  -full64 -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -sysc=2.3 top.v multiplier.v -timescale=1ps/1ps -l comp.log
run :
	./simv  -l run.log 


comp_debug  : clean 
	\rm -rf csrc AN.DB simv*  DEFAULT.DB   DVEfiles/ *.vpd
	syscan -full64 -cpp g++-4.8 -cc gcc-4.8 -sysc=2.3 sc_add.cpp:sc_add -cflags "-g"
	syscan -full64 -cpp g++-4.8 -cc gcc-4.8 -sysc=2.3 sc_subtracter.cpp:sc_subtracter -cflags "-g"
	vcs -full64 -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -sysc=2.3 -debug_access+all  top.v multiplier.v -timescale=1ps/1ps -l comp_debug.log 
run_debug :
	./simv -gui -l run_debug.log -i verilog_on_top.tcl





