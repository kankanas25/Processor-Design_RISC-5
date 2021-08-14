module Branch_targetMux(branch_control_sel,HB,clock,reset);

output reg branch_control_sel;
input HB,clock,reset;


always @(posedge clock)
begin
if(reset)
branch_control_sel<=1'b0;
else if(HB)
branch_control_sel<=1'b1;
end
endmodule
