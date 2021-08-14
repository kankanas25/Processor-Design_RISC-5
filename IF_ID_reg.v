module IF_ID_reg(PC_in,PC_plus_1_in,valid_in,
Instruction_in,PC_out,PC_plus_1_out,valid_out,
Instruction_out,clk,flush);

input [15:0] PC_in;
input [15:0] PC_plus_1_in;
input [15:0] Instruction_in;
input clk;
input flush;
input valid_in;

output reg [15:0] PC_out;
output reg [15:0] PC_plus_1_out;
output reg [15:0] Instruction_out;
output reg valid_out;

initial
begin
PC_out=16'b0;
PC_plus_1_out=16'b0;
Instruction_out=16'b0;
valid_out=1'b0;
end

always @(posedge clk)
begin

if(flush)
begin
PC_out<=16'b0;
PC_plus_1_out<=16'b0;
Instruction_out<=16'b0;
valid_out<=1'b0;
end
else
begin
PC_out<=PC_in;
PC_plus_1_out<=PC_plus_1_in;
Instruction_out<=Instruction_in;
valid_out<=valid_in;

end
end
endmodule
