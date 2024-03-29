module ALU_with_CCR(
out_alu, bus_a, bus_b, alu_control, clock, reset,carry,zero,carry_in,zero_in
);

output [15:0] out_alu;
input [15:0] bus_a, bus_b;
input [2:0] alu_control;
input clock, reset;
output carry,zero,carry_in,zero_in;
wire carry_temp, zero_temp,zero_out, carry_out, ccr_enable_temp;
assign carry=carry_temp;
assign zero=zero_temp;
assign carry_in=carry_out;
assign zero_in=zero_out;
ALU alu_instance(out_alu, carry_temp, zero_temp, ccr_enable_temp, bus_a, bus_b, carry_out, zero_out, alu_control);
CCR ccr_instance(carry_out, zero_out, carry_temp, zero_temp, ccr_enable_temp, clock, reset);

endmodule
