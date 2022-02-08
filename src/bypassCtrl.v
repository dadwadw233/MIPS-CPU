module bypassCtrl(
	input [4:0] EXoutrd,
	input [4:0] MEMoutrd,
	input [4:0] IDoutrs,//1
	input [4:0] IDoutrt,//2
	input EXoutRegWrite,
	input MemoutRegWrite,
	input RegDst,
	input [4:0] IFoutrs,
	input [4:0] IFoutrt,
	output reg [1:0] forwardA,
	output reg [1:0] forwardB,
	output reg [1:0] forwardA_,
	output reg [1:0] forwardB_,
	input [4:0] currentaddr
);
	always @(IDoutrt or IDoutrs or EXoutrd)begin
		forwardA = 2'b00;
		forwardB = 2'b00;
		if(EXoutRegWrite&&EXoutrd!=0)begin
		if(EXoutrd == IDoutrs)begin
			forwardA = 2'b01;
		end
		if(EXoutrd == IDoutrt&&(IDoutrt!=currentaddr))begin
			forwardB = 2'b01;
		end
		end
		if(MemoutRegWrite&&MEMoutrd!=0)begin
		if(MEMoutrd == IDoutrs && forwardA!=2'b01)begin
			forwardA = 2'b10;
		end
		if(MEMoutrd == IDoutrt && forwardB!=2'b01&&(IDoutrt!=currentaddr))begin
			forwardB = 2'b10;
		end
		end
	end
	always@(IFoutrs or IFoutrt or MEMoutrd)begin
		forwardA_ = 2'b00;
		forwardB_ = 2'b00;
		if(MemoutRegWrite&&MEMoutrd!=0)begin
		if(MEMoutrd == IFoutrs )begin
			forwardA_ = 2'b10;
		end
		if(MEMoutrd == IFoutrt)begin
			forwardB_ = 2'b10;
		end
		end
	end

endmodule
