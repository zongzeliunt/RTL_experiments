module adder(ina, inb, outx);
	input [31:0] ina;
	input [31:0] inb;
	output [31:0] outx;

	reg [31:0] outx_reg;

	always @(ina or inb) begin
	  	outx_reg <= ina + inb;
	end
	
	assign outx = outx_reg;

endmodule
