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
                if (in) next_state = S1; 		// Fix for bug found in v1.0
                else 	next_state = S10;
            end
            
            S10 : begin
                if (in) next_state = S101;
                else 	next_state = IDLE;
            end
            
            S101 : begin
                if (in) next_state = S1011;
		else 	next_state = S10; 		// Fix for bug found in v1.1
            end
            
            S1011: begin
                if (in) next_state = S1; 		// Fix for bug found in v1.2
                // Designer forgot again that if next input is 0
                // then pattern still matches "10" and should
                // go to S10 instead of IDLE.
                else next_state = S10; 		// Fix for bug found in v1.3
            end
        endcase
    end
endmodule
