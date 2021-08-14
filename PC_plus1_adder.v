module PC_plus1_adder(input [15:0] PC_in,output reg [15:0] PC_out,input clock,input reset);
initial
begin
	PC_out =16'b0;
end

always @(PC_in,reset)
begin
	if(reset)
		PC_out <= 16'b0;
	else
		PC_out<= PC_in + 1;
end

endmodule
