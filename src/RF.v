module RF(
	input [4:0] RegA,
	input [4:0] RegB,
	input [4:0] WriteReg,
	input [31:0] DataIn,
	input RegWrite,
	input rst,
	input clk,
	output  [31:0] RegOutA,
	output  [31:0] RegOutB
);
reg [31:0] RF[31:0];
assign RegOutA = RF[RegA];
assign RegOutB = RF[RegB];
integer i;
always @(posedge clk or posedge rst)begin
	if(rst)begin
			for (i = 0;i<=31;i=i+1)begin
				if(i==28)
					RF[i] <= 32'h0000_1800; 
				else if(i == 29)
					RF[i]<=32'h0000_2ffc;
				else  
				RF[i] <= 32'h0000_0000; 
			end
	end
	else if(RegWrite&&WriteReg!=5'b0)begin
		$display("$wr=%d datain%h",WriteReg,DataIn);
		RF[WriteReg]<=DataIn;
	end
end
endmodule

