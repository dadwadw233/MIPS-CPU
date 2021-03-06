`include "definition.v"
module ALU(
	input [31:0] A,
	input [31:0] B,
	input [3:0] ALUop,
	input [5:0] calCode,
	input [4:0] s,
	input [31:0] extImm,
	input ALUjumplink,
	input [31:0] PCadd,
	output reg [31:0] ALUResult
);
always @(*)begin
	case(ALUop)
	4'b0000:begin
		case(calCode)
		`ADD,`ADDU:ALUResult = A+B;
		`AND:ALUResult = A&B;
		`NOR:ALUResult = ~(A|B);
		`OR:ALUResult = A|B;
		`SLL:ALUResult = B<<s;
		`SLLV:ALUResult = B<<A[4:0];
		`SLT:ALUResult = $signed(A)<$signed(B)?{31'b0,1'b1}:32'h0000_0000;
		`SLTU:ALUResult = {1'b0,A}<{1'b0,B}?{31'b0,1'b1}:32'h0000_0000;
		`SRA:ALUResult = $signed(B)>>>s;
		`SRAV:ALUResult = $signed(B)>>>A[4:0];
		`SRL:ALUResult = B>>s;
		`SRLV:ALUResult = B>>A[4:0];
		`SUB,`SUBU:ALUResult = A-B;
		`XOR:ALUResult = A^B;
		endcase
	end
	4'b0111:begin
		ALUResult = A+B;	
	end
	4'b1000:begin
		ALUResult = {extImm[15:0],16'b0};
	end
	4'b1001:begin
		ALUResult = A+B;
	end
	4'b1010:begin
		ALUResult = A&B;
	end
	4'b1011:begin
		ALUResult = A|B;
	end
	4'b1100:begin
		ALUResult = A^B;
	end
	4'b1101:begin
		ALUResult = $signed(A)<$signed(B)?{31'b0,1'b1}:32'h0000_0000;
	end
	4'b1110:begin
		ALUResult = {1'b0,A}<{1'b0,B}?{31'b0,1'b1}:32'h0000_0000;
	end
	default:
	begin
		if(ALUjumplink)
		ALUResult <= PCadd;
		else 
		ALUResult <= 32'bz;
	end
	endcase
end


endmodule
