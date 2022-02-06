module _32bitMux(
input [31:0]A,
input [31:0]B,
input s,
output [31:0]result
);
assign result = (s==1)?A:((s==0)?B:31'bz);
endmodule

module _5bitMux(
input [4:0]A,
input [4:0]B,
input s,
output [4:0]result
);
assign result = (s==1)?A:((s==0)?B:5'bz);
endmodule

module sigCtrlMux(
input RegDst_,
input RegWrite_,
input ALUSrc_,
input MemRead_,
input MemWrite_,
input MentoReg_,
input Branch_,
input [1:0] ALUOp_,
output reg RegDst,
output reg RegWrite,
output reg ALUSrc,
output reg MemRead,
output reg MemWrite,
output reg MentoReg,
output reg Branch,
output reg [1:0] ALUOp,
input riskSig
);
always @(*)begin
	if(riskSig)begin
		 RegDst <= 1'b0;
		 RegWrite <= 1'b0;
		 ALUSrc <= 1'b0;
		 MemRead <= 1'b0;
		 MemWrite <= 1'b0;
		 MentoReg <= 1'b0;
		 Branch <= 1'b0;
		 ALUOp <= 2'b0;
	end
	else begin
		 RegDst <= RegDst_;
		 RegWrite <= RegWrite_;
		 ALUSrc <= ALUSrc_;
		 MemRead <= MemRead_;
		 MemWrite <= MemWrite_;
		 MentoReg <= MentoReg_;
		 Branch <= Branch_;
		 ALUOp <= ALUOp_;
	end
end
endmodule