module Instruction_Memory(address,instruction);
input [15:0] address;
output [15:0] instruction;

reg [15:0] instmem[0:31];

initial
begin

instmem[0] = 16'b1111111111111111;	//NOP
instmem[1] = 16'b0011001100000001;	// LHI R1											(LHI r1,128)
instmem[2] = 16'b0011010000010010;//LHI R2
instmem[3]=	16'b0001001010101000;// store R2 value to the location 
//instmem[4]= 16'b0100001011011000;//load from that location R3
//instmem[5]=16'b0001001011101000;//ADD
//instmem[6]=16'b0011110000001111;
//instmem[7]=16'b0011100000001011;

//instmem[3]=16'b1001001010110001;	
//instmem[4]=16'b0001001010011000;								//(LHI r2,128)
//instmem[4] = 16'b1000001010011011;	// Branch if [reg1] == [reg2] to PC+Immediate=3+2 		(BEQ r1,r2,2) # It will jump to 5th location , 2cycles will be wasted
//instmem[3] = 16'b0001001010011000;	// (ADD r1,r2,r3) 
//instmem[4] = 16'b0001001010100011;  //ADL r4=r1+(r2<<1)
//instmem[5]=16'b0011101000001111;//LHI to r5
//instmem[6]=16'b0010100101110000;//nand r4 and r5
//instmem[7]= 16'b0000001010110010;//adi 
//instmem[4]=16'b0001001010011000;//store
//instmem[5]=16'b0001001011110000;//load

// instmem[6]=16'b0101001010110100;
// instmem[7]=16'b0100001000110100;

end

assign instruction=instmem[address];


endmodule
