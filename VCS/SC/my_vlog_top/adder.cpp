#include "adder.h"
	
void adder::sc_add_action() {
	outx.write(ina.read().get_word(0) + inb.read().get_word(0));
}
	
