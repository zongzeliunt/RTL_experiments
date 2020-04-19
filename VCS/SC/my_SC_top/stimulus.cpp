
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


