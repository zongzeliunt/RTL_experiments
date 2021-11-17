`timescale 1 ns / 1 ps

module grey_converter #
(
    parameter DATA_BIT  = 4

)
(
    input  [DATA_BIT - 1 : 0] bin_input,
    output [DATA_BIT - 1 : 0] grey_output
);
    
	assign grey_output = (bin_input>>1) ^ bin_input;

endmodule
