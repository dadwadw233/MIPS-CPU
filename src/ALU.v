`include "definition.v"
module ALU(
	input [31:0] A,
	input [31:0] B,
	input [3:0] ALUop,
	input [5:0] calCode,
	input [4:0] s,
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
		//`SLL:ALUResult = {B[31-s:0],0};
		//`SLLV:ALUResult = {B[31-A:0],0};
		`SLT:ALUResult = A<B?{31'b0,1'b1}:32'h0000_0000;
		`SLTU:ALUResult = {1'b0,A}<{1'b0,B}?{31'b0,1'b1}:32'h0000_0000;
		//`SRA:
		//`SRAV:
		//`SRL:ALUResult = {B[31-s:0],0};
		//`SRLV:ALUResult = {B[31-A:0],0};
		`SUB,`SUBU:ALUResult = A-B;
		`XOR:ALUResult = A^B;
		endcase
	end
	
	endcase
end


endmodule
