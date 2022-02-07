module PC(
input [31:0] NPC,
input rst,
input clk,
output reg[31:0] PC,
input PCwrite,
input branchCtrl,
input jumpCtrl
);
always @( posedge clk)begin
	if(rst||branchCtrl||jumpCtrl)begin
		PC<=32'h0000_3000;
	end
	else if(PCwrite)begin
		PC<=PC;
	end
	else begin
		PC<=NPC;
	end
end
endmodule

