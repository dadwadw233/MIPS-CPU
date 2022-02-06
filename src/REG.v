module IFtoID(
input clk,
input IFtoIDWrite,
input [31:0] PC,
output reg [63:0] IFout 
);
always @(posedge clk)begin
	if(IFtoIDWrite)begin
		IFout<=IFout;
	end
	else begin
		IFout<={PC+4,PC};
	end
end
endmodule 

module IDtoEX(
input clk,
input RegDst,
input RegWrite,
input ALUSrc,
input MemRead,
input MemWrite,
input MentoReg,
input Branch,
input [3:0] ALUOp,
input [2:0] Loadop,
input [1:0] Saveop,
input [63:0] IFout,
input [31:0] RegOutA,
input [31:0] RegOutB,
input [31:0] EXTImm,
input [4:0] rs,
input [4:0] rt,
input [4:0] rd,
output reg [158:0]IDout
);
always @(posedge clk)begin
	IDout<={RegDst,RegWrite,ALUSrc,MemRead,MemWrite,MentoReg,Branch,ALUOp,Loadop,Saveop,IFout[63:32],RegOutA,RegOutB,EXTImm,rs,rt,rd};
end
endmodule

module EXtoMEM(
input clk,
input RegWrite,
input MemRead,
input MemWrite,
input MentoReg,
input Branch,
input [2:0] Loadop,
input [1:0] Saveop,
input [31:0] ADDPC,
input [31:0] ALUresult,
input [31:0] dataB,
input [4:0] Regadd,
output reg [110:0] EXout
);
always @(posedge clk)begin
	EXout<={RegWrite,MemRead,MemWrite,MentoReg,Branch,Loadop,Saveop,ADDPC,ALUresult,dataB,Regadd};
end 

endmodule

module MEMtoWB(
input clk,
input RegWrite,
input MentoReg,
input [31:0] ALUdata,
input [31:0] MEMdata,
input [4:0] Regadd,
output reg [70:0] MEMout
);
always @(posedge clk)begin
		MEMout<={RegWrite,MentoReg,ALUdata,MEMdata,Regadd};
end
endmodule
