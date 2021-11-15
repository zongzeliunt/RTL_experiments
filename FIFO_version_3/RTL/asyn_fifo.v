`timescale 1 ns / 1 ps

module asyn_fifo #
(
    parameter integer DATA_BITS	= 10,
    parameter integer FIFO_LENGTH	= 16,
	parameter ADDR_BIT = 4,
    
    parameter RESET_VALUE = 0
)
(

    asyn_fifo_interface.rtl rtl_interface


);
    //wire

    //reg
	reg [DATA_BITS - 1 : 0] data_array[FIFO_LENGTH - 1: 0];
	reg flap;
	reg [ADDR_BIT - 1:0] write_addr;
	reg [ADDR_BIT - 1:0] read_addr;	


    //assign
	assign rtl_interface.output_data = data_array[read_addr];

	assign rtl_interface.full = (write_addr == read_addr && flap == 1) ? 1 : 0; 
	assign rtl_interface.empty = (write_addr == read_addr && flap == 0) ? 1 : 0; 

//data_array 
//{{{
always@(posedge rtl_interface.clk) begin
    if (rtl_interface.write == 1 && rtl_interface.full != 1) begin
        data_array[write_addr] <= rtl_interface.input_data;
    end
end 
//}}}

//write_addr
//{{{
always@(posedge rtl_interface.clk) begin
	if (rtl_interface.reset == RESET_VALUE) begin
		write_addr <= 0;
	end
	else begin
		if (rtl_interface.write == 1 && rtl_interface.full != 1) begin
			if (write_addr == FIFO_LENGTH - 1) begin
				write_addr <= 0;
			end
			else begin
				write_addr <= write_addr + 1;
			end
		end
	end
end 
//}}}

//read_addr
//{{{
always@(posedge rtl_interface.clk) begin
	if (rtl_interface.reset == RESET_VALUE) begin
		read_addr <= 0;
	end
	else begin
		if (rtl_interface.read == 1 && rtl_interface.empty != 1) begin
			if (read_addr == FIFO_LENGTH - 1) begin
				read_addr <= 0;
			end
			else begin
				read_addr <= read_addr + 1;
			end
		end

	end
end
//}}}

//flap
//flap == 0: write greater than read
//flap == 1: write less than read
//{{{
always@(posedge rtl_interface.clk) begin
	if (rtl_interface.reset == RESET_VALUE) begin
		flap <= 0;
	end
	else begin
		if (rtl_interface.write == 1 && rtl_interface.full != 1) begin
			//write
			if (write_addr == FIFO_LENGTH - 1) begin
				flap <= ~flap;
			end
		end
		if (rtl_interface.read == 1 && rtl_interface.empty != 1 ) begin
			//read
			if (read_addr == FIFO_LENGTH - 1) begin
				flap <= ~flap;
			end
		end
	end
end 
//}}}

endmodule



