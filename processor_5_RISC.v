module processor_5_RISC(clock, reset);
input clock,reset;

wire [15:0] pc_out,pc_in,pc_plus1,Instruction_in,Instruction_out,Instruction_IDEX_out;
wire [15:0] pc_out_IF,PC_plus1_out_IF,PC_plus1_out_IDRF,PC_plus1_out_memWB;
wire valid_in_IF,valid_out_IF;

wire valid_out_IDEX,valid_out_EXMEM,valid_out_memwb;

wire [1:0] Mem;
wire [3:0] Ex;
wire [2:0] WB; 
wire [2:0] src1,src2;
wire [2:0] dest;
wire [5:0] Imm_6;
wire [8:0] Imm_9;
wire imm_control;
wire carry,zero,carry_in,zero_in;
wire [3:0] opcode_out;
wire enable;

wire [15:0] data_write,sign_ext_out,data_mem_mux,WB_forward;
wire [2:0] data_read0_address, data_read1_address;
wire clock, reg_write_enable;
wire [15:0] data_read0, data_read1;
wire [2:0] src1_out_IDEX,src2_out_IDEX;

wire [15:0] sign_ext_9, sign_ext_6,sign_ext_6_IDEX,out_shiftorD2;
wire [15:0] zero_pad_out;

wire [1:0] mux_controller_A, mux_controller_B;
wire [2:0] dest_EX, dest_mem, dest_WB;

wire  [2:0] wb_IDEX_out,wb_EXMem_out,wb_MemWb_out;

wire [15:0] ALU_out_ex,mem_data,WB_data_out,data_D1,data_D2,out_shift_orsignorD2,mux_ex_out;
wire [15:0] PC_plus_imm,PC_RAplus_Imm,mux_ex_out2;

wire [1:0] mem_IDEX_out;
wire [3:0] Ex_IDEX_out;
wire [15:0] data1_IDEX_out,data2_IDEX_out,zero_pad_IDEX_out;

wire [15:0] RB_shifted;
wire [15:0] alu_busb;

wire [15:0] PC_plus1_out_EXMEM,Memory_data_write_out_EX_M;
wire [1:0] Memory_out_EX_M;
wire [15:0] ALU_out_EXMEM;
wire [15:0] Zero_pad_out_EX_M;
wire eq_flag;

wire and1_output;
wire [15:0] mem_read_data;
wire [15:0] mem_memWB_data_out;

wire [15:0] ALU_out_MEMWB;
wire [15:0] zero_paded_memwb;
wire [1:0] pc_mux;
// IF stage------//
PC pc_block(pc_in,pc_out,clock,reset);

PC_plus1_adder pc_inc(pc_out,pc_plus1,clock,reset);

Instruction_Memory insm(pc_out,Instruction_in);


// ----ID-RF Stage----//

IF_ID_reg inter_reg1(pc_out,pc_plus1,valid_in_IF,Instruction_in,pc_out_IF,
PC_plus1_out_IF,valid_out_IF,Instruction_out,clock,reset);

decode ins_decode(Instruction_out,Mem,WB,Ex,src1,src2,dest,Imm_6,Imm_9,
imm_control);

RegisterFile RF(data_read0, data_read1,WB_forward,Instruction_out[11:9],
Instruction_out[8:6],dest_WB,clock,reg_write_enable);


Sign_Extenter_9bit SE1(sign_ext_9,Instruction_out[8:0]);
Sign_Extenter_6bit SE2(sign_ext_6,Instruction_out[5:0]);

branch_valid branch_inst(Instruction_out[15:12],valid_out_IF,valid_in_IF,
data_D1,data_D2);

mux_2to1 muxinst2(sign_ext_9,sign_ext_6,imm_control,sign_ext_out);

zero_padded zeroinst(zero_pad_out,Instruction_out[8:0]);

Forward_Controller forcont(mux_controller_A, mux_controller_B,src1,src2,
dest_EX, dest_mem, dest_WB, wb_IDEX_out[2],wb_EXMem_out[2],wb_MemWb_out[2]);

mux_4to1 muxinst3(data_read0,mux_ex_out,data_mem_mux,WB_forward,data_D1,mux_controller_A);
mux_4to1 muxinst4(data_read1,mux_ex_out,data_mem_mux,WB_forward,data_D2,mux_controller_B);

PC_Plus_Immediate PCinst1(PC_plus_imm,pc_out_IF,sign_ext_out);
PC_RA_plusImm PCinst2(data_D1,sign_ext_9,PC_RAplus_Imm);

comparator comp1(data_D1,data_D2,eq_flag);
pc_control pcinst3(clock,Instruction_out[15:12],pc_mux,data_D1,data_D2,eq_flag,enable);
mux_4to1 mux6(PC_RAplus_Imm,PC_plus_imm,data_D2,pc_plus1,pc_in,pc_mux);


// excecution stage----//
ID_EX_reg inte_reg2(WB,Mem,Ex,data_D1,data_D2,PC_plus1_out_IF,zero_pad_out,
dest,src1,src2,sign_ext_6,valid_out_IF,Instruction_out[15:12],
wb_IDEX_out,mem_IDEX_out,Ex_IDEX_out,
data1_IDEX_out,data2_IDEX_out,zero_pad_IDEX_out,dest_EX,PC_plus1_out_IDRF,
clock,reset,src1_out_IDEX,src2_out_IDEX,sign_ext_6_IDEX,opcode_out,
valid_out_IDEX);

one_bit_shift RB_shift(data2_IDEX_out,RB_shifted);
mux_2to1 muxinst5(data2_IDEX_out,RB_shifted,(Ex_IDEX_out[1]&Ex_IDEX_out[0]),out_shiftorD2);
mux_2to1 muxin6(out_shiftorD2,sign_ext_6_IDEX,(Ex_IDEX_out[3]&Ex_IDEX_out[2]),out_shift_orsignorD2);

load_RAW lw(src1,
src2,
opcode_out,
Instruction_out[15:12],
dest_EX,enable,valid_out_IF,
valid_out_IDEX,
clock,
reset);

ALU_with_CCR aluinst(ALU_out_ex,data1_IDEX_out,out_shift_orsignorD2,Ex_IDEX_out[2:0],clock,reset,carry,zero,carry_in,zero_in);

mux_2to1 mux2to1_instance3(ALU_out_ex, zero_pad_IDEX_out, 
(wb_IDEX_out[2] & wb_IDEX_out[1] & wb_IDEX_out[0]),mux_ex_out);

// Memory stage-----//

Ex_Mem_reg reginst3(PC_plus1_out_EXMEM,wb_EXMem_out,Memory_out_EX_M,
Memory_data_write_out_EX_M,ALU_out_EXMEM,Zero_pad_out_EX_M,dest_mem,valid_out_EXMEM,
PC_plus1_out_IDRF,wb_IDEX_out,mem_IDEX_out,
data2_IDEX_out,ALU_out_ex,
zero_pad_IDEX_out,dest_EX,valid_out_IDEX,clock,reset);

and and_inst1(and1_output,valid_out_EXMEM,Memory_out_EX_M[1]);


data_memory dm_inst(Memory_out_EX_M[0],and1_output,Memory_data_write_out_EX_M,
mem_read_data,ALU_out_EXMEM,clock,reset);

mux_4to1 muxinst5_mem
(mem_read_data,16'b0,ALU_out_EXMEM,Zero_pad_out_EX_M,data_mem_mux,wb_EXMem_out[1:0]);

// WB stage-----//
M_WB_reg intr_reg4(PC_plus1_out_memWB,wb_MemWb_out,mem_memWB_data_out,ALU_out_MEMWB,
zero_paded_memwb,dest_WB,valid_out_memwb,PC_plus1_out_EXMEM,wb_EXMem_out,mem_read_data,
ALU_out_EXMEM,Zero_pad_out_EX_M,dest_mem,valid_out_EXMEM,clock,reset);

and and_inst2(reg_write_enable,valid_out_memwb,wb_MemWb_out[2]);

mux_4to1 mux_inst5(mem_memWB_data_out,PC_plus1_out_memWB,ALU_out_MEMWB,zero_paded_memwb
,WB_forward,wb_MemWb_out[1:0]);
endmodule
