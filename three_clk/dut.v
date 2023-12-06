module three(clkin, clkout);
input clkin;//定义输入端口
output clkout;//定义输出端?

reg [1:0] step1, step;

always @(posedge clkin)
begin
    case (step)
        2'b00: step<=2'b01;
        2'b01: step<=2'b10;
        2'b10: step<=2'b00;
        default :step<=2'b00;
    endcase
end

always @(negedge clkin)
begin
    case (step1)
        2'b00: step1<=2'b01;
        2'b01: step1<=2'b10;
        2'b10: step1<=2'b00;
        default :step1<=2'b00;
    endcase
end

assign clkout=~(step[1]|step1[1]);
endmodule
