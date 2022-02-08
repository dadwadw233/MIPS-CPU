module _32bitMux(
input [31:0]A,
input [31:0]B,
input s,
output [31:0]result
);
assign result = (s==1)?A:((s==0)?B:31'bz);
endmodule

module _5bitMux(
input [4:0]A,//rd
input [4:0]B,//rt
input s,
input p,
output [4:0]result
);
assign result = (p==1)?((s==1)?A:((s==0)?B:5'bz)):5'b00000;
endmodule

module sigCtrlMux(
input RegDst_,
input RegWrite_,
input ALUSrc_,
input MemRead_,
input MemWrite_,
input MentoReg_,
input [3:0] ALUOp_,
	input [2:0] Loadop_,
    input [1:0] Saveop_,
	input ALUjumplink_,
output reg RegDst,
output reg RegWrite,
output reg ALUSrc,
output reg MemRead,
output reg MemWrite,
output reg MentoReg,
output reg [3:0] ALUOp,
	output reg [2:0] Loadop,
    output reg [1:0] Saveop,
	output reg ALUjumplink,
input riskSig
);
always @(*)begin
	if(riskSig)begin
		 RegDst = 1'b0;
		 RegWrite = 1'b0;
		 ALUSrc = 1'b0;
		 MemRead = 1'b0;
		 MemWrite = 1'b0;
		 MentoReg = 1'b0;
		 ALUOp = 4'b1111;
		 Loadop = 3'b000;
		 Saveop = 2'b00;
		 ALUjumplink =  1'b0;
	end
	else begin
		 RegDst = RegDst_;
		 RegWrite = RegWrite_;
		 ALUSrc = ALUSrc_;
		 MemRead = MemRead_;
		 MemWrite = MemWrite_;
		 MentoReg = MentoReg_;
		 ALUOp = ALUOp_;
		 Loadop = Loadop_;
		 Saveop = Saveop_;
		 ALUjumplink = ALUjumplink_;
	end
end
endmodule

module ALUmux(
	input [1:0]ctrl,
	input [31:0]source,
	input [31:0]aluAns,
	input [31:0]memAns,
	output reg [31:0] out
);
always @(*)begin
	case(ctrl)
		2'b00:out=source;
		2'b01:out=aluAns;
		2'b10:out=memAns;
		default:out=source;
	endcase
end
endmodule

module ALUmux_(
	input [1:0]ctrl,
	input [31:0]source,
	input [31:0]aluAns,
	input [31:0]memAns,
	input [3:0] ALUOp,
	output reg [31:0] out
);
always @(*)begin
	if(ALUOp!=4'b0111)begin
	case(ctrl)
		2'b00:out=source;
		2'b01:out=aluAns;
		2'b10:out=memAns;
		default:out=source;
	endcase
	end
	else out = source;
end
endmodule


module Jumpmux(
	input [4:0] source,//[15:11](rd)
	input [1:0] jumpType,
	output reg [4:0] out
);
always @(*)begin
	if(jumpType==2'b01)
		out = 5'b11111;
	else 
		out = source;
end
endmodule


module Regoutmux(
	input [31:0] data,
	input [1:0] s,
	input [31:0]memAns,
	output reg [31:0] Data
);
	always @(*)begin
		case(s)
		2'b00:Data=data;
		2'b10:Data=memAns;
		default:Data=data;
		endcase
	end
endmodule

module EXoutmux(
	input MemRead,
	input [31:0] EXout,
	input [31:0] Memout,
	output reg [31:0] confirmEXout
);
	always @(*)begin
		if(MemRead) confirmEXout = Memout;
		else confirmEXout = EXout;
	end
	
endmodule
