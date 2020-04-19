/*********************************************************************
 * SYNOPSYS CONFIDENTIAL                                             *
 *                                                                   *
 * This is an unpublished, proprietary work of Synopsys, Inc., and   *
 * is fully protected under copyright and trade secret laws. You may *
 * not view, use, disclose, copy, or distribute this file or any     *
 * information contained herein except pursuant to a valid written   *
 * license from Synopsys.                                            *
 *********************************************************************/

//****************************************************************************
// Copyright (c) 1996-2003 Synopsys, Inc.    ALL RIGHTS RESERVED
// 
// The contents of this file are subject to the restrictions and limitations
// set forth in the SystemC(TM) Open Community License Software Download and
// Use License Version 1.1 (the "License"); you may not use this file except
// in compliance with such restrictions and limitations. You may obtain
// instructions on how to receive a copy of the License at
// http://www.systemc.org/. Software distributed by Original Contributor
// under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF
// ANY KIND, either express or implied. See the License for the specific
// language governing rights and limitations under the License.
//
//***************************************************************************/
`define W 31

module my_top();

parameter PERIOD = 20;

reg clock;

reg [`W:0] value1;
reg [`W:0] value2;

wire [`W:0] add_wire;
wire [`W:0] sub_wire;
wire [`W:0] mult_wire;

integer counter;
integer direction;
integer cycle;

// SystemC model
sc_add add1(value1, value2, add_wire);

// SystemC model
sc_subtracter sub1(value2, value1, sub_wire);

// Verilog model
v_mult mult1(value1, value2, mult_wire);



initial begin
  value1 = 32'b010;  // starts at 2
  value2 = 32'b000;  // starts at 0
  counter = 0;
  direction = 1;
  cycle = 0;
end

// clock generator
always begin
  clock = 1'b0;
  #PERIOD
  forever begin
   #(PERIOD/2) clock = 1'b1;
   #(PERIOD/2) clock = 1'b0;
  end
end

// stimulus generator
always @(posedge clock) begin
  value1 <= counter+2;
  value2 <= 32'b010; // stays at 2 after here.

  if (direction == 1) // incrementing...
     if (counter == 9) begin
        counter = counter - 1;
        direction = 0;
     end
     else
        counter = counter + 1;
  else // decrementing...
     if (counter == 0) begin
        counter = counter + 1;
        direction = 1;
     end
     else
        counter = counter - 1;
end

// display generator
always @(posedge clock) begin

  $display("Cycle %d for values A=%d and B=%d", cycle, value1, value2);
  $display("Results: A+B=%d A-B=%d A*B=%d", add_wire, sub_wire, mult_wire);

  // end after 100 cycles are executed
  cycle = cycle + 1;
  if (cycle == 100)
     $finish;

end


endmodule
