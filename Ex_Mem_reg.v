module Ex_Mem_reg
(
PC_plus1_out_EX_M,
WB_out_EX_M,
Memory_out_EX_M,
Memory_data_write_out_EX_M,
ALU_out,
Zero_pad_out_EX_M,
Dest_out_EX_M,
valid_out,

PC_plus1_in_EX_M,
WB_in_EX_M,
Memory_in_EX_M,
Memory_data_write_in_EX_M,
ALU_in,
Zero_pad_in_EX_M,
Dest_in_EX_M,
valid_in,
clock,
reset
);

output reg [15:0] PC_plus1_out_EX_M;
output reg [2:0] WB_out_EX_M;
output reg [1:0] Memory_out_EX_M;
output reg [15:0] ALU_out, Memory_data_write_out_EX_M, Zero_pad_out_EX_M;
output reg [2:0] Dest_out_EX_M;
output reg valid_out;



input [15:0] PC_plus1_in_EX_M;
input [2:0] WB_in_EX_M;
input [1:0] Memory_in_EX_M;
input [15:0] ALU_in, Memory_data_write_in_EX_M, Zero_pad_in_EX_M;
input [2:0] Dest_in_EX_M;
input clock;
input reset;
input valid_in;

initial
begin
	PC_plus1_out_EX_M = 16'b0;
	WB_out_EX_M = 3'b0;
	Memory_out_EX_M = 2'b0;
	ALU_out = 16'b0;
	Memory_data_write_out_EX_M =16'b0;
	Zero_pad_out_EX_M = 16'b0;
	Dest_out_EX_M = 3'b0;
end

always @(posedge clock)
begin
	if(! reset)
		begin
			PC_plus1_out_EX_M <= PC_plus1_in_EX_M;
			WB_out_EX_M <= WB_in_EX_M;
			Memory_out_EX_M <= Memory_in_EX_M;
			ALU_out <= ALU_in;
			Memory_data_write_out_EX_M <= Memory_data_write_in_EX_M;
			Zero_pad_out_EX_M <= Zero_pad_in_EX_M;
			Dest_out_EX_M <= Dest_in_EX_M;
			valid_out<=valid_in;
			
		end
	else
		begin
			PC_plus1_out_EX_M <= 16'b0;
			WB_out_EX_M <= 3'b0;
			Memory_out_EX_M <= 2'b0;
			ALU_out <= 16'b0;
			Memory_data_write_out_EX_M <=16'b0;
			Zero_pad_out_EX_M <= 16'b0;
			Dest_out_EX_M <= 3'b0;
			valid_out<=1'b0;
			
		end
end

endmodule

