module PC_Plus_Immediate(PC_out, PC_in, Imm_in);

output [15:0] PC_out;
input [15:0] PC_in, Imm_in;

assign PC_out = PC_in + Imm_in;

endmodule
