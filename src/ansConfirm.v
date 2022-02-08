module ansConfirm(
 input [31:0] datain,
 input [2:0] Loadop,
 input [31:0] addr,
 output reg [31:0] dataout
); 
	always @ (*)begin
		case(Loadop)
		3'b001:begin//LB
		case(addr[1:0])
			2'b00:dataout={{24{datain[7]}},datain[7:0]};
			2'b01:dataout={{24{datain[15]}},datain[15:8]};
			2'b10:dataout={{24{datain[23]}},datain[23:16]};
			2'b11:dataout={{24{datain[31]}},datain[31:24]};
		endcase
		end
		3'b010:begin//LBU
		case(addr[1:0])
			2'b00:dataout={{24'b0},datain[7:0]};
			2'b01:dataout={{24'b0},datain[15:8]};
			2'b10:dataout={{24'b0},datain[23:16]};
			2'b11:dataout={{24'b0},datain[31:24]};
		endcase
		end
		3'b011:begin
			if(addr[1]) dataout={{16{datain[31]}},datain[31:16]};
			else dataout={{16{datain[15]}},datain[15:0]};
		end 
		3'b100:begin
			if(addr[1]) dataout={{16'b0},datain[31:16]};
			else dataout={{16'b0},datain[15:0]};
		end 
		default:dataout = datain;
		endcase
	end

endmodule 
