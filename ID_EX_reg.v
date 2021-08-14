module ID_EX_reg(WB_in,Mem_in,Ex_in,data_read1_in,data_read2_in,
PC_plus_1_in,Zero_pad_in_ID_EX,
Dest_in_ID_EX,src1_in,src2_in,sign_ext6_in,
valid_in,opcode_in,
WB_out,Mem_out,Ex_out, data_read1_out,data_read2_out,Zero_pad_out_ID_EX,
Dest_out_ID_EX,
PC_plus_1_out,clock,reset,src1_out,
src2_out,sign_ext6_out,opcode_out,valid_out);

input [2:0] WB_in;
input [1:0] Mem_in;
input [3:0] Ex_in;
input [15:0] data_read1_in,data_read2_in,PC_plus_1_in,Zero_pad_in_ID_EX;
input clock,reset;
input [2:0] Dest_in_ID_EX;
input [3:0] src1_in,src2_in;
input [15:0] sign_ext6_in;
input [3:0] opcode_in;
input valid_in;

output reg [2:0] WB_out;
output reg [1:0] Mem_out;
output reg [3:0] Ex_out;
output reg [15:0] data_read1_out,data_read2_out,PC_plus_1_out,Zero_pad_out_ID_EX;
output reg [2:0] Dest_out_ID_EX;
output reg [3:0] src1_out,src2_out;
output reg [15:0] sign_ext6_out;
output reg [3:0] opcode_out;
output reg valid_out;

initial
begin

WB_out=3'b0;
Mem_out=2'b0;
Ex_out= 4'b0;
data_read1_out=16'b0;
data_read2_out=16'b0;
PC_plus_1_out=16'b0;
Zero_pad_out_ID_EX = 16'b0;
Dest_out_ID_EX = 3'b0;
src1_out=4'b0;
src2_out=4'b0;
sign_ext6_out=16'b0;
valid_out=1'b0;
opcode_out=4'b0;
end


always @(posedge clock)
begin

if(reset)
begin
WB_out<=3'b0;
Mem_out<=2'b0;
Ex_out<= 4'b0;
data_read1_out<=16'b0;
data_read2_out<=16'b0;
PC_plus_1_out<=16'b0;
src1_out<=4'b0;
src2_out<=4'b0;
Zero_pad_out_ID_EX <= 16'b0;
Dest_out_ID_EX <= 3'b0;
sign_ext6_out<=16'b0;
valid_out<=1'b0;
opcode_out<=4'b0;
end
else
begin
WB_out<=WB_in;
Mem_out<=Mem_in;
Ex_out<=Ex_in;
data_read1_out<=data_read1_in;
data_read2_out<=data_read2_in;
PC_plus_1_out<=PC_plus_1_in;
Zero_pad_out_ID_EX <= Zero_pad_in_ID_EX;
Dest_out_ID_EX <= Dest_in_ID_EX;
src1_out<=src1_in;
src2_out<=src2_in;
sign_ext6_out<=sign_ext6_in;
valid_out<=valid_in;
opcode_out<=opcode_in;
end
end
endmodule


