module PC(
input [31:0] NPC,
input rst,
input clk,
output reg[31:0] PC,
input PCwrite,
input branchCtrl,
input jumpCtrl,
input PCsrc
);

always @( posedge clk)begin
	if(rst)begin
		PC<=32'h0000_3000;
	end
	else if(PCwrite)begin
		PC<=PC;
	end
	else if(PCsrc)begin
		PC<=NPC;
	end
	else PC<=PC+4;
end
endmodule

