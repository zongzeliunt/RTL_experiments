#ifndef stimulus_h_INCLUDED
#define stimulus_h_INCLUDED 1
#include <systemc.h>

SC_MODULE(stimulus) {

  sc_in<bool>  clock;
  sc_out<int>  value1;
  sc_out<int>  value2;
 
  int counter;
  int direction;  // 1 = increment, 0 = decrement

  SC_CTOR(stimulus) : clock("Clock"), value1 ("Value1"), value2("Value2")
  {
      SC_METHOD(entry);
      sensitive << clock.pos();
      counter = 0;
      direction = 0;
  }  
  void entry();
};
#endif /* !stimulus_h_INCLUDED */
