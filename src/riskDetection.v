`include "definition.v"
module riskDetection(
input [5:0] funcode,
input [5:0] specialcode,
input [4:0] IFoutrs,
input [4:0] IFoutrt,
input [4:0] IDoutrt,
input IDoutMemRead,
output reg pipelineCtrl,
output reg branchCtrl,
output reg jumpCtrl,
output reg [1:0] jumpType
);
	always @(*)begin
		case(funcode)
		6'b000001,`BEQ,`BGTZ,`BLEZ,`BNE:begin
			branchCtrl=1;
			jumpCtrl=0;
			pipelineCtrl=0;
			jumpType=2'b00;
		end
		
		`J,`JAL:begin
			branchCtrl=0;
			jumpCtrl=1;
			pipelineCtrl=0;
			if(funcode==`JAL)
			jumpType=2'b01;
			else jumpType=2'b11;
		end
		
		6'b000000:begin
			if(specialcode==`JR)begin
			branchCtrl=0;
			jumpCtrl=1;
			pipelineCtrl=0;
			jumpType=2'b00;
			end
			else if(specialcode==`JALR)begin
			branchCtrl=0;
			jumpCtrl=1;
			pipelineCtrl=0;
			jumpType=2'b10;
			end
			else begin
			if(IDoutMemRead&&((IDoutrt==IFoutrs)||(IDoutrt==IFoutrt)))begin
			branchCtrl=0;
			jumpCtrl=0;
			pipelineCtrl=1;
			jumpType=2'b00;
			end
			else begin
			branchCtrl=0;
			jumpCtrl=0;
			pipelineCtrl=0;
			jumpType=2'b00;
			end
			end
		end
		default:begin
			if(IDoutMemRead&&((IDoutrt==IFoutrs)||(IDoutrt==IFoutrt)))begin
			branchCtrl=0;
			jumpCtrl=0;
			pipelineCtrl=1;
			jumpType=2'b00;
			end
			else begin
			branchCtrl=0;
			jumpCtrl=0;
			pipelineCtrl=0;
			jumpType=2'b00;
			end
		end
		endcase
	end
endmodule
