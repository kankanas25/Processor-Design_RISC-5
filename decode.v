module decode(Instruction,Mem,WB,Ex,src1,src2,dest,Imm_6,Imm_9,
imm_control);
input [15:0] Instruction;
output reg [1:0] Mem;
output reg [3:0] Ex;
output reg [2:0] WB; 
//output reg [3:0] src1,src2;//extra 1 bit to signify whether to consider the src for operation
output reg [2:0] src1,src2;
output reg [2:0] dest;
output reg [5:0] Imm_6;
output reg [8:0] Imm_9;
output reg imm_control;


wire [3:0] opcode;
wire [1:0] condition;

assign opcode=Instruction[15:12];
assign condition=Instruction[1:0];

initial
begin
	WB = 3'b000;
end
always @(opcode,condition,Instruction)
begin

case (opcode)
4'b0000://ADI
begin
   Mem=2'b00;
	WB=3'b110;
//	src1={1'b1,Instruction[11:9]};
//	src2={1'b0,Instruction[8:6]};//Don't care
	
	src1=Instruction[11:9];
	src2=Instruction[8:6];
	dest=Instruction[8:6];
	Imm_6=Instruction[5:0];
	Imm_9=Instruction[8:0];
	imm_control=1'b1;//selecting 6 bit immediate value. why this 1?
	Ex=4'b1111;

end
4'b0001://ADD,ADC,ADZ,ADL
begin
	Mem=2'b00;
	WB=3'b110;
//	src1={1'b1,Instruction[11:9]};
//	src2={1'b1,Instruction[8:6]};
	src1=Instruction[11:9];
	src2=Instruction[8:6];
	
	dest=Instruction[5:3];
	Imm_6=Instruction[5:0];
	Imm_9=Instruction[8:0];
	imm_control=1'b0;//no imm value required
		if(condition==2'b00)//ADD
		Ex<=4'b0000;
		else if(condition==2'b01)//ADZ
		Ex<=4'b0001;
		else if(condition==2'b10)//ADC
		Ex<=4'b0010;
		else //ADL
		Ex<=4'b0011;
end

4'b0010:// NDU,NDC,NDZ
begin
	Mem=2'b00;
	WB=3'b110;
//	src1={1'b1,Instruction[11:9]};
//	src2={1'b1,Instruction[8:6]};
	
	src1=Instruction[11:9];
	src2=Instruction[8:6];
	dest=Instruction[5:3];
	Imm_6=Instruction[5:0];
	Imm_9=Instruction[8:0];
	imm_control=1'b0;
		if(condition==2'b00)//NDU
		Ex=4'b0100;
		else if(condition==2'b10)//NDC
		Ex=4'b0101;
		else if(condition==2'b01)//NDZ
		Ex=4'b0110;
		else
		Ex=4'bzzzz;
end

4'b0011://LHI
begin
   Mem=2'b00;
	WB=3'b111;
//	src1={1'b0,Instruction[11:9]};// Don't care,does not go to ALU for any op
//	src2={1'b0,Instruction[8:6]};//Don't care
	
	src1=Instruction[11:9];
	src2=Instruction[8:6];
	
	dest=Instruction[11:9];//src1 is destination
	Imm_6=Instruction[5:0];
	Imm_9=Instruction[8:0];
	imm_control=1'b0;//
	Ex=4'b1001;

end

4'b0100://LW
begin
Mem=2'b01;
	WB=3'b100;
//	src1={1'b1,Instruction[11:9]};
//	src2={1'b0,Instruction[8:6]};//Don't care
	
	src1=Instruction[11:9];
	src2=Instruction[8:6];//Don't care
	
	dest=Instruction[8:6];//src2 is destination
	Imm_6=Instruction[5:0];
	Imm_9=Instruction[8:0];
	imm_control=1'b0;//
	Ex=4'b1111;
end

4'b0101://SW
begin
Mem=2'b10;
	WB=3'b000;
//	src1={1'b1,Instruction[11:9]};
//	src2={1'b0,Instruction[8:6]};//Don't care
	
	src1=Instruction[11:9];
	src2=Instruction[8:6];//Don't care
	
	dest=Instruction[8:6];//Don't care
	Imm_6=Instruction[5:0];
	Imm_9=Instruction[8:0];
	imm_control=1'b0;//
	Ex=4'b1111;
end

4'b1000://BEQ
begin
Mem=2'b00;
	WB=3'b000;
//	src1={1'b1,Instruction[11:9]};
//	src2={1'b1,Instruction[8:6]};
	
	
	src1=Instruction[11:9];
	src2=Instruction[8:6];
	
	dest=Instruction[8:6];//Don't care
	Imm_6=Instruction[5:0];
	Imm_9=Instruction[8:0];
	imm_control=1'b1;//
	Ex=4'b0000;
end

4'b1001://JAL
begin
Mem=2'b00;
	WB=3'b101;
//	src1={1'b0,Instruction[11:9]};//Don't care
//	src2={1'b0,Instruction[8:6]};//Don't care
	
	src1=Instruction[11:9];//Don't care
	src2=Instruction[8:6];//Don't care
	
	dest=Instruction[11:9];
	Imm_6=Instruction[5:0];
	Imm_9=Instruction[8:0];
	imm_control=1'b0;//
	Ex=4'b0000;
end

4'b1010://JLR
begin
Mem=2'b00;
	WB=3'b101;
//	src1={1'b0,Instruction[11:9]};//Don't care
//	src2={1'b0,Instruction[8:6]};//Don't care
	
	src1=Instruction[11:9];//Don't care
	src2=Instruction[8:6];//Don't care
	
	dest=Instruction[11:9];
	Imm_6=Instruction[5:0];
	Imm_9=Instruction[8:0];
	imm_control=1'b0;//
	Ex=4'b0000;
end

4'b1011://JRI
begin
Mem=2'b00;
	WB=3'b000;
//	src1={1'b0,Instruction[11:9]};//Don't care
//	src2={1'b0,Instruction[8:6]};//Don't care
	
	src1=Instruction[11:9];//Don't care
	src2=Instruction[8:6];//Don't care
	
	dest=Instruction[11:9];
	Imm_6=Instruction[5:0];
	Imm_9=Instruction[8:0];
	imm_control=1'b0;//
	Ex=4'b0000;
end
default:
begin
	Mem=2'b00;
	WB=3'b000;
//	src1={1'b0,Instruction[11:9]};//Don't care
//	src2={1'b0,Instruction[8:6]};//Don't care
	
	
	src1=Instruction[11:9];//Don't care
	src2=Instruction[8:6];//Don't care
	
	dest=Instruction[8:6];//Don't care
	Imm_6=Instruction[5:0];
	Imm_9=Instruction[8:0];
	imm_control=1'b0;//
	Ex=4'b1111;
end

endcase
end


endmodule
