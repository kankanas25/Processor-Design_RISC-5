module pc_control(clock,opcode,mux_control,data_read0,data_read1,eq_flag,enable);
input [3:0] opcode;
input enable;
output reg [1:0] mux_control;
input [15:0] data_read0,data_read1;
input clock;
input eq_flag;

always @(opcode,eq_flag)
begin
if(enable)
begin
if (((opcode==4'b1000) && eq_flag) ||(opcode==4'b1001))
mux_control=2'b01;
else if(opcode==4'b1011)
mux_control=2'b00;
else if(opcode==4'b1010)
mux_control=2'b10;
else
mux_control=2'b11;
end
else
mux_control=2'bzz;
end
endmodule
