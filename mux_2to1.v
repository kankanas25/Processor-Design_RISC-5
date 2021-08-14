module mux_2to1(in_data1,in_data2,sel,out_data);
input [15:0] in_data1;
input [15:0] in_data2;
input sel;
output reg [15:0] out_data;

always @(sel,in_data1,in_data2)
begin
case(sel)
1'b0:out_data=in_data1;
1'b1:out_data=in_data2;
default:out_data=16'b0;
endcase
end
endmodule
