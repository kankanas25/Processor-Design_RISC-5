module one_bit_shift(In_data, Out_data);
input [15:0] in_data;
output [15:0] Out_data;

assign Out_data=in_data<<1;

endmodule
