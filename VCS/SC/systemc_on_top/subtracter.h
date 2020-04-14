#ifndef _subtracter_h
#define _subtracter_h
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

#include "systemc.h"

SC_MODULE(subtracter)
{
 public:
  sc_in<int> ina;
  sc_in<int> inb;
  sc_out<int> outx;

  SC_CTOR(subtracter):ina("ina"),inb("inb"), outx("outx")
    
    {
      SC_METHOD(subtracter_action);
      sensitive << ina << inb;
  }

  void subtracter_action() {
      outx.write(inb.read() - ina.read());
  }
};
#endif

