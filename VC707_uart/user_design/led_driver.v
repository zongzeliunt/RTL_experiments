`timescale 1ns / 1ps

module led_driver(
        reset,
        clk,
		data,
		data_valid,
        led_0,
        led_1,
        led_2,
        led_3,
        led_4,
        led_5,
        led_6,
        led_7
    );
    input reset, clk;
   	input [7:0] data;
	input data_valid;	
    output led_0;
    output led_1;
    output led_2;
    output led_3;
    output led_4;
    output led_5;
    output led_6;
    output led_7;

    reg [0:31] clk_counter;
    reg [0:0] flap;
	reg led_0, led_1, led_2, led_3, led_4, led_5, led_6;
    
    localparam MAX = 32'd200_000_000;
    
    assign led_7 = reset | flap;
    
    always@(posedge clk)    begin
        if (reset) begin
            flap <= 0;
            clk_counter <= 17'd0;
        end
        else begin
          if (clk_counter == MAX) begin
               clk_counter <= 32'd0;
               if (flap == 'b1)
                    flap <= 'b0;
               else
                    flap <= 'b1;
          end
          else begin
            clk_counter <= clk_counter + 1'b1;  
          end
       end
    end

    always@(posedge clk)    begin
        if (reset) begin
			led_0 <= 0;
			led_1 <= 0;
			led_2 <= 0;
			led_3 <= 0;
			led_4 <= 0;
			led_5 <= 0;
			led_6 <= 0;
        end
		else begin
			if (data_valid == 1) begin
				led_0 <= data[0];
				led_1 <= data[1];
				led_2 <= data[2];
				led_3 <= data[3];
				led_4 <= data[4];
				led_5 <= data[5];
				led_6 <= data[6];
			end
		end
	end

endmodule

