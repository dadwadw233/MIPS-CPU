module IFtoID(
input clk,
input IFtoIDWrite,
input [31:0] im_dout,
input [31:0] adder,
output reg [63:0] IFout,
input branchCtrl,
input PCsrc
);
always @(posedge clk)begin
	if(PCsrc)begin
		IFout<=64'b0;
	end
	else if((IFtoIDWrite))begin
		IFout<=IFout;
	end
	else begin
		IFout<={adder,im_dout};
	end
end
endmodule 

module IDtoEX(
input clk,
input RegDst,//158
input RegWrite,//157
input ALUSrc,//156
input MemRead,//155
input MemWrite,//154
input MentoReg,//153
input [3:0] ALUOp,//152:149
input ALUjumplimk,//148
input [2:0] Loadop,//147:145
input [1:0] Saveop,//144:143
input [63:0] IFout,//142:111
input [31:0] RegOutA,//110:79
input [31:0] RegOutB,//78:47
input [31:0] EXTImm,//46:15
input [4:0] rs,//14:10
input [4:0] rt,//9:5
input [4:0] rd,//4:0
output reg [158:0]IDout
);
always @(posedge clk)begin
	IDout<={RegDst,RegWrite,ALUSrc,MemRead,MemWrite,MentoReg,ALUOp,ALUjumplimk,Loadop,Saveop,IFout[63:32],RegOutA,RegOutB,EXTImm,rs,rt,rd};
end
endmodule

module EXtoMEM(
input clk,
input RegWrite,//109
input MemRead,//108
input MemWrite,//107
input MentoReg,//106
input [2:0] Loadop,//105:103
input [1:0] Saveop,//102:101
input [31:0] ADDPC,//100:69
input [31:0] ALUresult,//68:37
input [31:0] dataB,//36:5
input [4:0] Regadd,//4:0
output reg [109:0] EXout
);
always @(posedge clk)begin
	EXout<={RegWrite,MemRead,MemWrite,MentoReg,Loadop,Saveop,ADDPC,ALUresult,dataB,Regadd};
end 

endmodule

module MEMtoWB(
input clk,
input RegWrite,//70
input MentoReg,//69
input [31:0] ALUdata,//68:37
input [31:0] MEMdata,//36:5
input [4:0] Regadd,//4:0
output reg [70:0] MEMout
);
always @(posedge clk)begin
		MEMout<={RegWrite,MentoReg,ALUdata,MEMdata,Regadd};
end
endmodule
