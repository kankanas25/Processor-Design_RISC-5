module zero_padded(out_16,in_9);
input [8:0] in_9;
output [15:0] out_16;

assign out_16={in_9,{7{1'b0}}};

endmodule
