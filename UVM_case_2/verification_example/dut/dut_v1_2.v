module det_1011 ( input clk,
                  input rstn,
                  input in,
                  output out );
    
    parameter IDLE 	= 0,
    			S1 		= 1,
    			S10 	= 2,
    			S101 	= 3,
    			S1011 	= 4;
    
    reg [2:0] cur_state, next_state;
    
    assign out = cur_state == S1011 ? 1 : 0;
    
    always @ (posedge clk) begin
        if (!rstn)
            	cur_state <= IDLE;
         else 
         	cur_state <= next_state;
    end
    
    always @ (cur_state or in) begin
        case (cur_state)
            IDLE : begin
                if (in) next_state = S1;
                else next_state = IDLE;
            end
            
            S1: begin
                if (in) next_state = S1;// Fix for bug found in v1.0
                else 	next_state = S10;
            end
            
            S10 : begin
                if (in) next_state = S101;
                else 	next_state = IDLE;
            end
            
            S101 : begin
                if (in) next_state = S1011;
                // Designer assumed that if next input is 0, 
                // then pattern fails to match and should
                // restart. But he forgot that S101 followed
                // by 0 actually matches part of the pattern
                // which is "10" and only "11" is remaining
                // So it should actually go back to S10
		else 	next_state = S10; // Fix for bug found in v1.1
            end
            
            S1011: begin
             	next_state = IDLE;
            end
        endcase
    end
endmodule
