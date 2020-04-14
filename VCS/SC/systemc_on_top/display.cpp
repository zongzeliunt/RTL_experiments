/*********************************************************************
 * SYNOPSYS CONFIDENTIAL                                             *
 *                                                                   *
 * This is an unpublished, proprietary work of Synopsys, Inc., and   *
 * is fully protected under copyright and trade secret laws. You may *
 * not view, use, disclose, copy, or distribute this file or any     *
 * information contained herein except pursuant to a valid written   *
 * license from Synopsys.                                            *
 *********************************************************************/

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
 
    display.cpp -- 
 
    Original Author: John Bartholomew. Synopsys, Inc. 
 
******************************************************************************/
 
/******************************************************************************
 
    MODIFICATION LOG - modifiers, enter your name, affliation and
    changes you are making here:
 
    Modifier Name & Affiliation:
    Description of Modification:
    
 
******************************************************************************/

#include <systemc.h>
#include "display.h"

void display::entry(){

  cout << "Cycle " << i << " for values A=" << value1.read() << " B=" << value2.read() << endl;
  cout << "Results: A+B=" << add_result.read() << " A-B=" << sub_result.read() << " A*B=" << mult_result.read() << endl << endl;

  // Stop after 100 cycles
  i++;
  if (i == 100) {
    cout << "Simulation of " << i << endl;
    sc_stop();
  }
}
// EOF
