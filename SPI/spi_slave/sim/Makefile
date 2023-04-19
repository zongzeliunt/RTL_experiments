#:%s/^[ ]\+/\t/g
all:
	vcs -full64 -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -debug_pp +vcd+vcdpluson -sverilog \
	-P $(VERDI_HOME)/share/PLI/VCS/LINUX64/novas.tab $(VERDI_HOME)/share/PLI/VCS/LINUX64/pli.a \
	-f flist.f \
	+define+VCS_SIM 

centos:
	vcs -full64 -LDFLAGS -Wl,--no-as-needed -debug_pp +vcd+vcdpluson -sverilog \
	-P $(VERDI_HOME)/share/PLI/VCS/LINUX64/novas.tab $(VERDI_HOME)/share/PLI/VCS/LINUX64/pli.a \
	-f flist.f \
	+define+VCS_SIM 

opendve:
	dve -full64 -vpd waveforms.vpd

openverdi:
	verdi -ssf waveforms.fsdb --nologo

clean:
	if [ -e csrc ]; then rm -r csrc; fi
	if [ -e simv ]; then rm simv; fi
	if [ -e simv.daidir ]; then rm -r simv.daidir; fi
	if [ -e vnc_logs ]; then rm -r vnc_logs; fi
	if [ -e ucli.key ]; then rm ucli.key; fi
	if [ -e waveforms.vpd ]; then rm waveforms.vpd; fi
	if [ -e waveforms.fsdb ]; then rm waveforms.fsdb; fi
	if [ -e DVEfiles ]; then rm -r DVEfiles; fi
	if [ -e novas.conf ]; then rm -r novas.conf; fi
	if [ -e novas_dump.log ]; then rm -r novas_dump.log; fi
	if [ -e novas.rc ]; then rm -r novas.rc; fi
	if [ -e verdiLog ]; then rm -r verdiLog; fi
