module PC(input [15:0] PC_in,output reg [15:0] PC_out, input clock,input reset);
initial
begin
PC_out=16'b0;
end
always @(posedge clock)
begin
if(reset)
PC_out<=16'b0;
else
PC_out<=PC_in;
end
endmodule
