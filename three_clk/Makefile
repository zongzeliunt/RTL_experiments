#:%s/^[ ]\+/\t/g

TOP_TB:= three

VCS_CMD = vcs -full64 -LDFLAGS -Wl,--no-as-needed -debug_pp +vcd+vcdpluson -sverilog \
	-f flist.f -debug_access -R -l  $(TOP_TB).log +lint=all\
	+define+VCS_SIM 


all:
	$(VCS_CMD)	

openverdi:
	verdi -base -f flist.f -ssf $(TOP_TB)_tb.fsdb &

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
	if [ -e simv.vdb ]; then rm -r simv.vdb; fi
	rm -rf  *.fsdb.*  *.out verdiLog *.fsdb *.log novas.* *.vpd
