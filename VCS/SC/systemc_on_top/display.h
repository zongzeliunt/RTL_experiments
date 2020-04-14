#ifndef display_h_INCLUDED
#define display_h_INCLUDED 1
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
 
    display.h -- 
 
    Original Author: John Bartholomew. Synopsys, Inc. 
 
******************************************************************************/
 
/******************************************************************************
 
    MODIFICATION LOG - modifiers, enter your name, affliation and
    changes you are making here:
 
    Modifier Name & Affiliation:
    Description of Modification:
    
******************************************************************************/
#include <systemc.h>

SC_MODULE(display) {


  sc_in<bool>  clock;
  sc_in<int>   value1;
  sc_in<int>   value2;
  sc_in<int>   add_result;
  sc_in<int>   sub_result;
  sc_in<int>   mult_result;

  int i;
  
  SC_CTOR(display): 
    clock ("Clock")
    , value1("value1")
    , value2("value2")
    ,add_result("add_Result")
    , sub_result("Sub_result")
    , mult_result("Mult_Result")

    {
      SC_METHOD(entry);
      sensitive << clock.pos();
      i = 0;
    }

  void entry();
};

#endif /* !display_h_INCLUDED */
