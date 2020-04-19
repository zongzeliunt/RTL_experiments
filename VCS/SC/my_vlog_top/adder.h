#include "systemc.h"
SC_MODULE(adder)
{
public:
	sc_in<sc_lv<32> > ina;
	sc_in<sc_lv<32> > inb;
	sc_out<sc_lv<32> > outx;
	
	void sc_add_action(); 
	
	SC_CTOR(adder) {
		SC_METHOD(sc_add_action);
			sensitive << ina << inb;
	}
};
