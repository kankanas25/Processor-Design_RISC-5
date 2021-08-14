module mux3bit_2to1(Instruction,reg_destsel,dest_out);
input [15:0] Instruction;
input [1:0] reg_destsel;
output reg [2:0] dest_out;

wire [2:0] inp1,inp2,inp3;
assign inp1=Instruction[11:9];
assign inp2=Instruction[8:6];
assign inp3=Instruction[5:3];

always @(Instruction,reg_destsel,inp1,inp2,inp3)
begin
case(reg_destsel)
2'b00:dest_out=inp1;
2'b01:dest_out=inp2;
2'b10:dest_out=inp3;
2'b11:dest_out=3'bzzz;
default:dest_out=inp3;
endcase

end

endmodule
