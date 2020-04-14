#ifndef TOP_H
#define TOP_H
#include <systemc.h>
#include "stimulus.h"
#include "display.h"
#include "adder.h"
#include "multiplier.h"
#include "subtracter.h"

SC_MODULE(sc_top) 
{
  SC_CTOR(sc_top) :
    clock("CLK", 20, SC_PS, .5, 0.0, SC_PS),
    value1("value1"),
    value2("value2"),
    add_out("outputadd"),
    sub_out("outputsub"),
    mult_out("outputmult"),

    adder_inst( "adder_inst"),
    subtracter_inst( "subtracter_inst"),
    multiplier_inst( "multiplier_inst"),
    stimulus_inst("stimulus_inst"),
    display_inst("display_inst")
    
    {
      stimulus_inst.clock(clock);
      stimulus_inst.value1(value1);
      stimulus_inst.value2(value2); 
      
      adder_inst.ina(value1);
      adder_inst.inb(value2);
      adder_inst.outx(add_out);
      
      subtracter_inst.ina(value1);
      subtracter_inst.inb(value2);
      subtracter_inst.outx(sub_out);
      
      multiplier_inst.ina(value1);
      multiplier_inst.inb(value2);
      multiplier_inst.outx(mult_out);
      
      display_inst.clock(clock);
      display_inst.value1(value1);
      display_inst.value2(value2); 
      display_inst.add_result(add_out);
      display_inst.sub_result(sub_out);
      display_inst.mult_result(mult_out);
    
    }

    sc_clock         clock;
    sc_signal<int>   value1;
    sc_signal<int>  value2;
    sc_signal<int> add_out;
    sc_signal<int> sub_out;
    sc_signal<int> mult_out;

    adder  adder_inst;
    subtracter  subtracter_inst;
    multiplier  multiplier_inst;
    stimulus stimulus_inst;
    display  display_inst;

};


#endif
