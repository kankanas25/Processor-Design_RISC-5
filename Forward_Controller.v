module Forward_Controller
(
mux_controller_A,
mux_controller_B,

src1_ID_RF,
src2_ID_RF,
dest_EX,
dest_M,
dest_WB,
wb_IDEX_out,
wb_EXMem_out,wb_MemWb_out);

output reg [1:0] mux_controller_A, mux_controller_B;
input [2:0] src1_ID_RF, src2_ID_RF, dest_EX, dest_M, dest_WB;

input wb_IDEX_out,wb_EXMem_out,wb_MemWb_out;
initial
begin
	mux_controller_A = 2'b00;
	mux_controller_B = 2'b00;
end

always @ (src1_ID_RF, dest_EX, dest_M, dest_WB,wb_IDEX_out,wb_EXMem_out,wb_MemWb_out)
begin
	if(src1_ID_RF == dest_EX && wb_IDEX_out)
		mux_controller_A <= 2'b01;
		
	else if(src1_ID_RF == dest_M && wb_EXMem_out)
		mux_controller_A <= 2'b10;
		
	else if(src1_ID_RF == dest_WB && wb_MemWb_out)
		mux_controller_A <= 2'b11;
		
	else
		mux_controller_A <= 2'b00;
end

always @ (src2_ID_RF, dest_EX, dest_M, dest_WB, wb_IDEX_out,wb_EXMem_out,wb_MemWb_out)
begin
	if(src2_ID_RF == dest_EX && wb_IDEX_out)
		mux_controller_B <= 2'b01;
		
	else if(src2_ID_RF == dest_M && wb_EXMem_out)
		mux_controller_B <= 2'b10;
		
	else if(src2_ID_RF == dest_WB && wb_MemWb_out)
		mux_controller_B <= 2'b11;
		
	else
		mux_controller_B <= 2'b00;
end

endmodule
