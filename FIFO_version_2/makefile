all:
	vcs -debug_pp +vcd+vcdpluson -sverilog fifo_tb_expect.sv fifo.v

dve:
	dve -vpd waveforms.vpd

clean:
	rm -r csrc simv.daidir
	rm ucli.key waveforms.vpd simv

