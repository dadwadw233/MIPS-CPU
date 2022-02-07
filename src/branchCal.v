module branchCal(
	input [3:0] ALUop,
	input branch,
	input jump,
	input [31:0] RegoutA,
	input [31:0] RegoutB,
	output reg PCsrc
);
	always @(*)begin
		if(branch)begin
			case(ALUop)
			4'b0010:begin
				if(RegoutA>=0)PCsrc =1;
				else PCsrc = 0;
			end
			4'b0101:begin
				if(RegoutA<0)PCsrc =1;
				else PCsrc = 0;
			end
			4'b0001:begin
				if(RegoutA==RegoutB)PCsrc =1;
				else PCsrc = 0;
			end
			4'b0011:begin
				if(RegoutA>0)PCsrc =1;
				else PCsrc = 0;
			end
			4'b0100:begin
				if(RegoutA<=0)PCsrc =1;
				else PCsrc = 0;
			end
			4'b0110:begin
				if(RegoutA!=RegoutB)PCsrc =1;
				else PCsrc = 0;
			end
			default:PCsrc = 0;
			endcase
		end
		else if (jump)begin
			PCsrc = 1;
		end
		else PCsrc = 0;
	end
endmodule
