#include <systemc.h>
#include "display.h"

void display::entry(){

  cout << "Cycle " << i << " for values A=" << value1.read() << " B=" << value2.read() << endl;
  cout << "Results: A+B=" << add_result.read() << " Expect:" << value1.read() + value2.read() << endl;

  // Stop after 100 cycles
  i++;
  if (i == 100) {
    cout << "Simulation of " << i << endl;
    sc_stop();
  }
}
// EOF
