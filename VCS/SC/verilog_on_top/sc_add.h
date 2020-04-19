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
#ifndef _sc_add_h
#define _sc_add_h

#include "systemc.h"

SC_MODULE(sc_add)
{
 public:
  sc_in<sc_lv<32> > ina;
  sc_in<sc_lv<32> > inb;
  sc_out<sc_lv<32> > outx;

  SC_CTOR(sc_add):ina("ina"), inb("inb"), outx("outx") {
      SC_METHOD(sc_add_action);
      sensitive << ina << inb;
  }

  void sc_add_action();
};
#endif

