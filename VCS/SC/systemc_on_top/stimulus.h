#ifndef stimulus_h_INCLUDED
#define stimulus_h_INCLUDED 1
/******************************************************************************
    Copyright (c) 1996-2003 Synopsys, Inc.    ALL RIGHTS RESERVED
 
  The contents of this file are subject to the restrictions and limitations
  set forth in the SystemC(TM) Open Community License Software Download and
  Use License Version 1.1 (the "License"); you may not use this file except
  in compliance with such restrictions and limitations. You may obtain
  instructions on how to receive a copy of the License at
  http://www.systemc.org/. Software distributed by Original Contributor
  under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF
  ANY KIND, either express or implied. See the License for the specific
  language governing rights and limitations under the License.
 
******************************************************************************/
/******************************************************************************
 
    stimulus.h -- 
 
    Original Author: John Bartholomew. Synopsys, Inc. 
 
******************************************************************************/
#include <systemc.h>
 
/******************************************************************************
 
    MODIFICATION LOG - modifiers, enter your name, affliation and
    changes you are making here:
 
    Modifier Name & Affiliation:
    Description of Modification:
    
******************************************************************************/

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
