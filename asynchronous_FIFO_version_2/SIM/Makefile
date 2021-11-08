#:%s/^[ ]\+/\t/g
all:
	vcs -full64 -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -debug_pp +vcd+vcdpluson -sverilog \
    -f flist.f \
    +define+VCS_SIM 

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
