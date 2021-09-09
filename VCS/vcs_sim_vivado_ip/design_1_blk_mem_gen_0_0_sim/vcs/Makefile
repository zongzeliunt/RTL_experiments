#:%s/^[ ]\+/\t/g
all:
	vlogan -work xpm -full64 -sverilog \
	"/home/ares/Tool/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" 
	vlogan -work xpm -full64 +v2k glbl.v 
	vcs -full64 -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -debug_pp +vcd+vcdpluson -sverilog \
	xpm.design_1_blk_mem_gen_0_0 xpm.glbl -o design_1_blk_mem_gen_0_0_simv \
	-f flist.f \
	+define+VCS_SIM 



	#vlogan -work xil_defaultlib -full64 +v2k glbl.v 
	#vcs -full64 -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -debug_pp +vcd+vcdpluson -sverilog \
	#xil_defaultlib.design_1_blk_mem_gen_0_0 xil_defaultlib.glbl -o design_1_blk_mem_gen_0_0_simv \
	#-f flist.f \
	#+define+VCS_SIM 

run:
	./design_1_blk_mem_gen_0_0_simv -ucli -do simulate.do

opendve:
	dve -full64 -vpd waveforms.vpd

clean:
	if [ -e csrc ]; then rm -r csrc; fi
	if [ -e simv ]; then rm simv; fi
	if [ -e simv.daidir ]; then rm -r simv.daidir; fi
	if [ -e vnc_logs ]; then rm -r vnc_logs; fi
	if [ -e ucli.key ]; then rm ucli.key; fi
	if [ -e waveforms.vpd ]; then rm waveforms.vpd; fi
	if [ -e DVEfiles ]; then rm -r DVEfiles; fi
