module branch_valid(opcode,valid_out_IFID,valid_in,read_data0,read_data1);
input [3:0] opcode;
input valid_out_IFID;
input [15:0] read_data0,read_data1;
output reg valid_in;


always @(opcode,read_data0,read_data1,valid_out_IFID)
begin
case(opcode)
4'b1000://BEQ
begin
if(valid_out_IFID && read_data0==read_data1)
valid_in<=1'b0;
else if(valid_out_IFID && read_data0!=read_data1)
valid_in<=1'b1;
//else if (!valid_out_IFID)
//valid_in<=1'b1;
end

4'b1001://JAL
begin
if(valid_out_IFID)
valid_in<=1'b0;
else
valid_in<=1'b1;
end

4'b1010://JLR
begin
if(valid_out_IFID)
valid_in<=1'b0;
else
valid_in<=1'b1;
end

4'b1011://JRI
begin
if(valid_out_IFID)
valid_in<=1'b0;
else
valid_in<=1'b1;
end

default://
valid_in<=1'b1;

endcase
end

endmodule

