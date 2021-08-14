module PC_RA_plusImm(input [15:0] RA,input [15:0] imm_value,output [15:0] PC_value);

assign PC_value=RA+imm_value;

endmodule
