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
 
    stimulus.cpp -- 
 
    Original Author: John Bartholomew. Synopsys, Inc. 
 
******************************************************************************/
 
/******************************************************************************
 
    MODIFICATION LOG - modifiers, enter your name, affliation and
    changes you are making here:
 
    Modifier Name & Affiliation:
    Description of Modification:
    
******************************************************************************/

#include <systemc.h>
#include "stimulus.h"

void stimulus::entry() {

  // On each rising clock edge, we'll write a new
  // value to both outputs. After ten edges, reverse 
  // the counter and decrement back to zero.

  // This test is set up to run for 100 cycles.

  // Vary value1 from 2 to 11, hold value 2 at 2
  value1.write(counter+2);
  value2.write(2);

  // adjust counter value, and check for direction flip
  if (direction == 1) { // incrementing...
    if (counter == 9) {
      counter--;
      direction = 0;  
    }
    else 
      counter++;  // increment for next time 'round...
  }
  else {  // decrementing
    if (counter == 0) {
      counter++;
      direction = 1;  
    }
    else 
      counter--;  // increment for next time 'round...
  }
}


