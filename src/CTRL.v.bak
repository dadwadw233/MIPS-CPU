`include "definition.v"
module CTRL(
	input [5:0] funcode,
	input [20:16] rt,
	input [5:0] specialcode,
	output reg RegDst,
	output reg RegWrite,
	output reg ALUSrc,
	output reg MemRead,
	output reg MemWrite,	
	output reg MentoReg,
	output reg Branch,
	output reg [3:0] ALUOp,
	output reg [2:0] Loadop,
    output reg [1:0] Saveop,
	output reg EXTOp,
	output reg ALUjumplink,
	output reg jumpReg
);

always @(funcode)begin
	case(funcode)
	6'b000000:begin 
	RegDst=1;
	RegWrite = 1;
	end
	`JAL:begin
	RegDst=1;
	RegWrite = 1;
	end
	`LW,`LB,`LBU,`LH,`LHU,`LUI,`ADDI,`ADDIU,`ANDI,`ORI,`SLTI,`SLTIU,`XORI:begin
	RegDst=0;
	RegWrite = 1;
	end
	default:begin
	RegWrite = 0;
	RegDst=1'bz;
	end
	endcase
end	

always @(funcode)begin
	case(funcode)
	`SB,`SW,`SH,`LW,`LB,`LBU,`LH,`LHU,`LUI,`ADDI,`ADDIU,`ANDI,`ORI,`SLTI,`SLTIU,`XORI:ALUSrc=1;
	`ADD,`ADDU,`AND,`DIV,`DIVU,`MULT,`MULTU,`NOR,`OR,`SLL,`SLLV,`SLT,`SLTU,`SRA,`SRAV,`SRL,`SRLV,`SUB,`SUBU,`XOR:ALUSrc=0;
	default:ALUSrc=1'bz;
	endcase
end

always @(funcode)begin
	case(funcode)
		`BEQ,`BGEZ,`BGTZ,`BLEZ,`BLTZ,`BNE:Branch=1;
		default:Branch=0;
	endcase
end

always @(funcode)begin
	case(funcode)
		`LB,`LBU,`LH,`LHU,`LW:MemRead =1;
		default:MemRead = 0;
	endcase
end

always @(funcode)begin
	case(funcode)
		`SB,`SH,`SW:MemWrite = 1;
		default:MemWrite = 0;
	endcase
end

always @(funcode)begin
	case(funcode)
		`LB,`LBU,`LH,`LHU,`LW:MentoReg =1;
		default:MentoReg =0;
	endcase
end

always @(funcode)begin
	case(funcode)
		6'b000000:ALUOp=4'b0000;//normal calculate
		6'b000001:begin
			if(rt==`BGEZ) ALUOp =4'b0010;//branch greater equal
			else ALUOp = 4'b0101;// branch lower
		end
		`BEQ:ALUOp=4'b0001;//branch equal
		`BGTZ:ALUOp = 4'b0011;//Branch greater
		`BLEZ:ALUOp = 4'b0100;//branch lower equal
		`BNE:ALUOp = 4'b0110;//branch not equal
		`LB,`LBU,`LH,`LHU,`LW,`SB,`SH,`SW:ALUOp = 4'b0111;//load op
		`LUI:ALUOp = 4'b1000;//load imm
		`ADDI,`ADDIU:ALUOp = 4'b1001;//add imm
		`ANDI:ALUOp = 4'b1010;//and imm
		`ORI:ALUOp = 4'b1011;//or imm
		`XORI:ALUOp = 4'b1100;//xor imm
		`SLTI:ALUOp = 4'b1101;
		`SLTIU:ALUOp = 4'b1110;
		default:ALUOp = 4'b1111;//no calculate
	endcase
end

always @(funcode)begin
	case (funcode)
	`LB:Loadop=3'b001;
	`LBU:Loadop=3'b010;
	`LH:Loadop=3'b011;
	`LHU:Loadop=3'b100;
	`LW:Loadop = 3'b000;
	default:Loadop = 3'b111;//assign address as 'z'
	endcase
end

always @(funcode)begin
	case(funcode)
	`SB:Saveop = 2'b01;
	`SH:Saveop = 2'b10;
	`SW:Saveop = 2'b00;
	default:Saveop = 2'b11;
	endcase
end 

always @(funcode)begin
	case(funcode)
	`ANDI,`ORI,`XORI:EXTOp = 0;
	default:EXTOp = 1;
	endcase
end

always @(funcode)begin
	case(funcode)
	`JAL:ALUjumplink = 1;
	6'b000000:begin
		if(specialcode==`JALR)
		ALUjumplink = 1;
		else ALUjumplink = 0;
	end
	default:ALUjumplink = 0;
	endcase
end

always @(funcode)begin
	case(specialcode)
	`JR,`JALR:jumpReg=1;
	default:jumpReg=0;
	endcase
end
endmodule