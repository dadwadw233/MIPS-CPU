module npcCalculation(
	input [31:0] Imm,
	input [31:0] PC,
	input [31:0] regOutA,
	input [25:0] instr_index,
	input jumpReg,
	input jump,
	input PCsrc,
	output reg [31:0] NPC,
	input [4:0] jumprs,
	input [4:0] IDoutadd,
	input [4:0] EXoutadd,
	input [31:0] EXans//if last order is 'lw' we will get the addr rather than ans
	// [31:0] Memans
	
);

always@(*)begin
	if(jumpReg)begin
		if(jumprs==IDoutadd) NPC=EXans;
		//else if(jumprs == EXoutadd) NPC = Memans;
		else NPC=regOutA;
	end
	else if (jump)begin
		NPC={PC[31:28],instr_index,2'b0};
	end
	else if(PCsrc) 
		NPC=PC+4+{Imm[29:0],2'b0};
end


endmodule
