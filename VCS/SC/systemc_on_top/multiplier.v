/*********************************************************************
 * SYNOPSYS CONFIDENTIAL                                             *
 *                                                                   *
 * This is an unpublished, proprietary work of Synopsys, Inc., and   *
 * is fully protected under copyright and trade secret laws. You may *
 * not view, use, disclose, copy, or distribute this file or any     *
 * information contained herein except pursuant to a valid written   *
 * license from Synopsys.                                            *
 *********************************************************************/

module multiplier(ina, inb, outx);
input [31:0] ina;
input [31:0] inb;
output [31:0] outx;

reg [31:0] outx_reg;

always @(ina or inb) begin
  outx_reg <= ina * inb;
end

assign outx = outx_reg;

endmodule
