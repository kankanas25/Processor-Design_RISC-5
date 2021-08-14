module comparator(RA,RB,eq_flag);
input [15:0] RA,RB;
output reg eq_flag;
always @(RA,RB)
begin
if(RA==RB)
eq_flag=1'b1;
else
eq_flag=1'b0;
end
endmodule

