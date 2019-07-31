`timescale 1ns / 1ps

module uart_top (
	input clk_p,
	input clk_n,
	input rx,
	input rst,
	output led_0,
	output led_1,
	output led_2,
	output led_3,
	output led_4,
	output led_5,
	output led_6,
	output led_7,
	output tx
);


//assign tx = rx;
wire clk;


IBUFGDS #(
 .DIFF_TERM("FALSE"),
 .IBUF_LOW_PWR("TRUE"),
 .IOSTANDARD("DEFAULT")
 ) IBUFGDS_inst (
    .O(clk),
    .I(clk_p),
    .IB(clk_n)
);



reg rx_bus_ready;
wire rx_bus_valid;
wire [7:0] rx_bus;

wire tx_bus_ready;
reg [7:0] tx_bus;
reg tx_bus_valid;

reg [3:0] send_count;

  uart_rx 
    (.i_Clock(clk),
     .i_Rx_Serial(rx),
     .o_Rx_DV(rx_bus_valid),
     .o_Rx_Byte(rx_bus)
     );

led_driver led_driver (
	.reset(rst),
	.clk(clk),
	.data(rx_bus),
	.data_valid(rx_bus_valid),
	.led_0(led_0),
	.led_1(led_1),
	.led_2(led_2),
	.led_3(led_3),
	.led_4(led_4),
	.led_5(led_5),
	.led_6(led_6),
	.led_7(led_7)
);

  uart_tx
  (.i_Clock(clk),
   .i_Tx_DV(rx_bus_valid),
   .i_Tx_Byte(rx_bus + 1),
   .o_Tx_Active(),
   .o_Tx_Serial(tx),
   .o_Tx_Done()
   );



/*
always @( posedge clk_p ) begin
    if (rst == 1)   begin
		tx_bus <= 8'b0000_1000;
		tx_bus_valid <= 1;
	end
	else begin
		tx_bus <= 8'b0;
		tx_bus_valid <= 0;
	end
end
*/

/*
always @( posedge clk_p ) begin
    if (rst == 1)   begin
		rx_bus_ready <= 1;
	end
end



always @( posedge clk_p ) begin
    if (rst == 1)   begin
		tx_bus <= 0;
		tx_bus_valid <= 0;
	end
	else begin
		if (rx_bus_valid == 1) begin
			tx_bus <= rx_bus;
			tx_bus_valid <= 1;
		end
		else begin
			tx_bus <= 0;
			tx_bus_valid <= 0;
		end
	end
end
*/

endmodule
