module load_RAW(IF_ID_src1,
IF_ID_src2,
ID_RF_opcode,
IF_ID_opcode,
ID_RF_dest,mux_enable,valid_in,
Valid_out_ID_RF,enable,
clock,
reset);


output reg  mux_enable;
output reg valid_in;
output reg enable;

input [2:0] IF_ID_src1, IF_ID_src2;
input [2:0] ID_RF_dest;
input [3:0] ID_RF_opcode, IF_ID_opcode;
input Valid_out_ID_RF;
input clock,reset;

always @(IF_ID_src1, IF_ID_src2, ID_RF_dest, ID_RF_opcode, IF_ID_opcode, 
Valid_out_ID_RF)

begin
case(ID_RF_opcode)
0100://LW
begin
if(((IF_ID_src1 == ID_RF_dest)  || (IF_ID_src2 == ID_RF_dest)) && (IF_ID_opcode == 4'b0000 || IF_ID_opcode == 4'b0001 || IF_ID_opcode == 4'b0010 
			|| IF_ID_opcode == 4'b1000 ) && Valid_out_ID_RF) //checking load and next instruction dependency
			begin
				mux_enable = 1'b0;
				valid_in =1'b0;
			
			end
			else
			begin
				mux_enable = 1'b1;
				valid_in =1'b1;
				
			end
		end
default:
begin
mux_enable =2'b1;
valid_in =1'b1;
end

endcase
end
endmodule

