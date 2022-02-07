module npcCalculation(
	input [31:0] Imm,
	input [31:0] PC,
	input [31:0] regOutA,
	input [25:0] instr_index,
	input jumpReg,
	input jump,
	output reg [31:0] NPC
);

always@(*)begin
	if(jumpReg)begin
		NPC=regOutA;
	end
	else if (jump)begin
		NPC={PC[31:28],instr_index,2'b0};
	end
	else 
		NPC=PC+4+{Imm[29:0],2'b0};

end


endmodule
