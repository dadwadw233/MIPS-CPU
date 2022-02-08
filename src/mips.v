module mips(clk, rst);
	input   clk;
	input   rst;

// PCmux
	wire [31:0] NPC;
	wire [31:0] PCmuxout;
	wire PCsrc;
// PC
	wire [31:0] PC;
	wire pipelineCtrl;
	wire branchCtrl;//stall pipeline
	wire jumpCtrl;
//im
	wire [31:0] im_dout;
	
// adder (cal PC+4)
	//wire [31:0] adder;
	//assign adder = PC+4;
//reg IFtoID
	wire [63:0] IFout;
	wire IFtoIDWrite;//stall pipeline

//RF
	//wire [4:0] addrA;
	//wire [4:0] addrB;//from IFout
	wire [31:0] DataIn;//from the ansConfirm
	wire [70:0] MEMout;
	wire [31:0] RegOutA;
	wire [31:0] RegOutB;

//Regoutmux
	wire [31:0] A;
	wire [31:0] B;
//CTRL
	wire RegDst_;
	wire RegWrite_;
	wire ALUSrc_;
	wire MemRead_;
	wire MemWrite_;
	wire MentoReg_;
	wire Branch;
	wire [3:0] ALUOp_;
	wire [2:0] Loadop_;
    wire [1:0] Saveop_;
	wire EXTOp;
	wire ALUjumplink_;
	wire jumpReg;
	wire jump;
// CRTLmux
	wire RegDst;
	wire RegWrite;
	wire ALUSrc;
	wire MemRead;
	wire MemWrite;
	wire MentoReg;
	wire [3:0] ALUOp;
	wire [2:0] Loadop;
    wire [1:0] Saveop;
	wire riskSig;//from riskdetection

// EXT
	wire [31:0] ImmOut;
//riskDetection
	wire [158:0] IDout;
	wire [1:0] jumpType;
//Jumpmux
	wire [4:0] ConfirmedRd;
//branchCal

//npcCalculation
	
//IDtoEX

//Datamux
	wire [31:0] DatamuxOut;
//bypassCtrl
	wire [1:0] forwardA;
	wire [1:0] forwardB;
	wire [1:0] forwardA_;
	wire [1:0] forwardB_;
	wire [109:0] EXout;
	
//ALUmux
	wire [31:0] dataA;
	wire [31:0] dataB;
	
//ALU
	wire [31:0] ALUResult;

//add mux
	wire [4:0] Regadd;
//EXtoMEM

//dm
	wire [31:0] dout;

//MEMtoWB

//MEMmux
	
	
//ansConfirm
	wire [31:0] confirmAns;
	
//_32bitMux U_PCmux(.A(NPC),.B(PC+4),.s(PCsrc),.result(PCmuxout));	

PC U_PC(.NPC(NPC),.rst(rst),.clk(clk),.PC(PC),.PCwrite(pipelineCtrl),.branchCtrl(branchCtrl),.jumpCtrl(jumpCtrl),.PCsrc(PCsrc));
	
im_4k U_IM ( 
      .addr(PC[11:2]) , .dout(im_dout)
   );

IFtoID U_Reg1(
		.clk(clk),.IFtoIDWrite(pipelineCtrl),.im_dout(im_dout),.adder(PC+4),.IFout(IFout),.branchCtrl(branchCtrl),.PCsrc(PCsrc)
   );

RF U_RF(
		.RegA(IFout[25:21]),.RegB(IFout[20:16]),.WriteReg(MEMout[4:0]),.DataIn(DataIn),.RegWrite(MEMout[70]),.rst(rst),.clk(clk),.RegOutA(RegOutA),.RegOutB(RegOutB)
	);

Regoutmux U_RegoutmuxA(RegOutA,forwardA_,DataIn,A);
Regoutmux U_RegoutmuxB(RegOutB,forwardB_,DataIn,B);
CTRL U_CTRL(
	.funcode(IFout[31:26]),
	.rt(IFout[20:16]),
	.specialcode(IFout[5:0]),
	.RegDst(RegDst_),
	.RegWrite(RegWrite_),
	.ALUSrc(ALUSrc_),
	.MemRead(MemRead_),
	.MemWrite(MemWrite_),
	.MentoReg(MentoReg_),
	.Branch(Branch),
	.ALUOp(ALUOp_),
	.Loadop(Loadop_),
	.Saveop(Saveop_),
	.EXTOp(EXTOp),
	.ALUjumplink(ALUjumplink_),
	.jumpReg(jumpReg),
	.jump(jump)
	);

sigCtrlMux U_sigCtrlMux(
	RegDst_,
	RegWrite_,
	ALUSrc_,
	MemRead_,
	MemWrite_,
	MentoReg_,
	ALUOp_,
	Loadop_,
	Saveop_,
	ALUjumplink_,
	RegDst,
	RegWrite,
	ALUSrc,
	MemRead,
	MemWrite,
	MentoReg,
	ALUOp,
	Loadop,
	Saveop,
	ALUjumplink,
	riskSig	
	);

EXT U_EXT(IFout[15:0],EXTOp,ImmOut);

riskDetection U_riskDetection(
	IFout[31:26],
	IFout[5:0],
	IFout[25:21],
	IFout[20:16],
	IFout[15:11],
	IDout[155],
    pipelineCtrl,
	branchCtrl,
	jumpCtrl,
	jumpType,
	riskSig
);

Jumpmux U_Jumpmux(IFout[15:11],jumpType,ConfirmedRd);

branchCal U_branchCal(ALUOp_,Branch,jump,RegOutA,RegOutB,PCsrc);

npcCalculation U_NPC(ImmOut,IFout[63:32]-4,RegOutA,IFout[25:0],jumpReg,jump,PCsrc,NPC,IFout[25:21],Regadd,EXout[4:0],ALUResult);

IDtoEX U_IDtoEX(
	clk,
	RegDst,
	RegWrite,
	ALUSrc,
	MemRead,
	MemWrite,
	MentoReg,
	ALUOp,
	ALUjumplink,
	Loadop,
	Saveop,
	IFout,
	A,
	B,
	ImmOut,
	IFout[25:21],
	IFout[20:16],
	ConfirmedRd,
	IDout
	);
	
_32bitMux U_Datamux(
		.A(IDout[46:15]),.B(IDout[78:47]),.s(IDout[156]),.result(DatamuxOut)
	);

_5bitMux U_addmux(.A(IDout[4:0]),.B(IDout[9:5]),.s(IDout[158]),.p(IDout[157]),.result(Regadd));
bypassCtrl U_bypass(
	EXout[4:0],
	MEMout[4:0],
	IDout[14:10],//1
	IDout[9:5],//2
	EXout[109],
	MEMout[70],
	IDout[158],
	IFout[25:21],
	IFout[20:16],
	forwardA,
	forwardB,
	forwardA_,
	forwardB_,
	Regadd
	);
	
	
ALUmux U_ALUmux1(forwardA,IDout[110:79],EXout[68:37],DataIn,dataA);
ALUmux_ U_ALUmux2(forwardB,DatamuxOut,EXout[68:37],DataIn,IDout[152:149],dataB);

ALU U_ALU(
	dataA,
	dataB,
	IDout[152:149],
	IDout[20:15],
	IDout[26:21],
	IDout[46:15],
	IDout[148],
	IDout[142:111],
	ALUResult
	);
	//U_ALUmux
	wire [31:0] din;
	wire [31:0] confirmEXout;
EXoutmux U_EXoutmux(EXout[108],EXout[68:37],confirmAns,confirmEXout);
ALUmux U_ALUmux3(forwardB,IDout[78:47],confirmEXout,DataIn,din);

EXtoMEM U_EXtoMEM(
	clk,
	IDout[157],//109
	IDout[155],//108
	IDout[154],//107
	IDout[153],//106
	IDout[147:145],//105:103
	IDout[144:143],//102:101
	IDout[142:111],//100:69
	ALUResult,//68:37
	din,//36:5
	Regadd,//4:0
	EXout
);
dm_4k U_DM(EXout[48:39], EXout[36:5], EXout[108], EXout[107], clk, EXout[102:101], dout, rst, EXout[38:37]
);

ansConfirm U_ansConfirm(dout,EXout[105:103],EXout[68:37],confirmAns);

MEMtoWB U_MEMtoWB(
	clk,
	EXout[109],//70
	EXout[106],//69
	EXout[68:37],//68:37
	confirmAns,//36:5
	EXout[4:0],//4:0
	MEMout
);

_32bitMux U_MEMmux(.A(MEMout[36:5]),.B(MEMout[68:37]),.s(MEMout[69]),.result(DataIn));

endmodule 