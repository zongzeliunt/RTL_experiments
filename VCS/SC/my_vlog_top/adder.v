module adder (
	ina,
	inb,
	outx

	);
	input [31:0] ina;
	input [31:0] inb;
	output [31:0] outx;

	assign outx = ina + inb;
endmodule
