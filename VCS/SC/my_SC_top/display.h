#ifndef display_h_INCLUDED
#define display_h_INCLUDED 1
#include <systemc.h>

SC_MODULE(display) {


  sc_in<bool>  clock;
  sc_in<int>   value1;
  sc_in<int>   value2;
  sc_in<int>   add_result;

  int i;
  
  SC_CTOR(display): 
    clock ("Clock"), 
	value1("value1"),
	value2("value2"),
	add_result("add_Result")

    {
      SC_METHOD(entry);
      sensitive << clock.pos();
      i = 0;
    }

  void entry();
};

#endif /* !display_h_INCLUDED */
