module RegisterFile
(data_read0, 
data_read1, 
data_write, 
data_read0_address, 
data_read1_address, 
data_write_address, 
clock,
reg_write_enable);
//,PC);

input [15:0] data_write;
input [2:0] data_read0_address, data_read1_address, data_write_address;
input clock, reg_write_enable;
output [15:0] data_read0, data_read1;
//output [15:0] PC;
reg [15:0] regfile [7:0];
integer i;
initial
begin
for (i = 0; i < 7; i = i + 1) begin
            regfile[i] = 16'b0;
end
end

always @(posedge clock)
begin
if(reg_write_enable)
regfile[data_write_address]<=data_write;
end
//assign PC=regfile[7];

assign data_read0=regfile[data_read0_address];
assign data_read1=regfile[data_read1_address];

endmodule
