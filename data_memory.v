module data_memory(Mem_read,Mem_write,Mem_write_data,Mem_read_data,Mem_add,clock,reset);
input Mem_read,Mem_write;
input [15:0] Mem_write_data,Mem_add;
output reg [15:0] Mem_read_data;
input clock,reset;
parameter mem_size=512;
reg [15:0] datamem [mem_size-1:0];
integer i;
always @(posedge clock)
begin
if(reset)
begin
for(i=0;i<mem_size-1;i=i+1)
datamem[i]<=16'b0;
end
else
begin
if(Mem_write)
datamem[Mem_add]<=Mem_write_data;
end
end
always @(Mem_read,Mem_add)
begin
if(Mem_read)
Mem_read_data=datamem[Mem_add];
else
Mem_read_data=16'bz;

end

endmodule


