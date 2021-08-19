#:%s/^[ ]\+/\t/g
UVM_HOME = /home/ares/Tool/vcs_install/1800.2-2020-1.1

TEST =/usr/bin/test
UVM_VERBOSITY=UVM_LOW
N_ERRS = 0
N_FATALS = 0
VCS = vcs -full64 -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -debug_pp\
    -sverilog \
    -full64 \
    -timescale=1ns/1ns \
	+vcd+vcdpluson \
    $(UVM_HOME)/src/dpi/uvm_dpi.cc -CFLAGS -DVCS \
    +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm.sv \
    -f flist.f \
    -P /home/ares/Tool/vcs_install/verdi/share/PLI/VCS/LINUX64/novas.tab \
    /home/ares/Tool/vcs_install/verdi/share/PLI/VCS/LINUX64/pli.a

SIMV = ./simv +UVM_VERBOSITY=$(UVM_VERBOSITY) -l vcs_sim.log

URG = urg -format test -dir sim.vdb

CHECK = \
    $(TEST)    \( `grep -c 'UVM_ERROR :    $(N_ERRS)' vcs_sim.log` -eq 1 \) -a \
                \( `grep -c 'UVM_FATAL :    $(N_FATALS)' vcs_sim.log` -eq 1 \)


all: clean comp

comp:
	$(VCS)

run:
	$(SIMV)
	$(CHECK)


clean:
	if [ -e csrc ]; then rm -r csrc; fi
	if [ -e simv ]; then rm simv; fi
	if [ -e simv.daidir ]; then rm -r simv.daidir; fi
	if [ -e vnc_logs ]; then rm -r vnc_logs; fi
	if [ -e ucli.key ]; then rm ucli.key; fi
	if [ -e waveforms.vpd ]; then rm waveforms.vpd; fi
	if [ -e DVEfiles ]; then rm -r DVEfiles; fi
	if [ -e novas_dump.log ]; then rm -r novas_dump.log; fi
	if [ -e novas.conf ]; then rm -r novas.conf; fi
	if [ -e novas.rc ]; then rm -r novas.rc; fi
	if [ -e verdiLog ]; then rm -r verdiLog; fi
	if [ -e waveforms.fsdb ]; then rm -r waveforms.fsdb; fi
	if [ -e vc_hdrs.h ]; then rm -r vc_hdrs.h; fi
	if [ -e vcs_sim.log ]; then rm -r vcs_sim.log; fi




openverdi:
	verdi -ssf waveforms.fsdb -nologo

opendve:
	dve -full64 -vpd waveforms.vpd
