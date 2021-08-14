module Sign_Extenter_6bit(out_16, in_6);

output [15:0] out_16;
input [5:0] in_6;

assign out_16 = {{10{in_6[5]}},in_6[5:0]};

endmodule
