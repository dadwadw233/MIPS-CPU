module bypassCtrl(
	input [4:0] EXoutrd,
	input [4:0] MEMoutrd,
	input [4:0] IDoutrs,//1
	input [4:0] IDoutrt,//2
	input EXoutRegWrite,
	input MenoutRegWrite,
	output reg [1:0] forwardA,
	output reg [1:0] forwardB
);
	always @(*)begin
		forwardA = 2'b00;
		forwardB = 2'b00;
		if(EXoutRegWrite&&EXoutrd!=0)begin
		if(EXoutrd == IDoutrs)begin
			forwardA = 2'b01;
		end
		if(EXoutrd == IDoutrt)begin
			forwardB = 2'b01;
		end
		end
		if(MenoutRegWrite&&MEMoutrd!=0)begin
		if(MEMoutrd == IDoutrs && forwardA!=2'b01)begin
			forwardA = 2'b10;
		end
		if(MEMoutrd == IDoutrt && forwardB!=2'b01)begin
			forwardB = 2'b10;
		end
		end
	end


endmodule