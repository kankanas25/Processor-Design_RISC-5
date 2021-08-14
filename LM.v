module LM(Imm_field,ra_address,Imm_9bit,clock,data);
input [7:0] Imm_field;
output [8:0] Imm_9bit;
input [2:0] ra_address;
input clock;
input [15:0] data;
reg [2:0] reg_number [7:0];
assign Imm_9bit={1'b0,Imm_field};

reg [15:0] regfile [7:0];
integer i;
always @(posedge clock)
begin
for(i=0;i<8;i=i+1)
begin
if(Imm_9bit[i]==1'b1)
begin
reg_number[i]<=i;
regfile[i]<=data;
end
else
begin
reg_number[i]<=1'b0;
regfile[i]<=regfile[i];
end
end

end

endmodule
