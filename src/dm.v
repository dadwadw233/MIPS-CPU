module dm_4k( addr, din, MemRead, MemWrite, clk, Saveop, dout, rst, laddr);
   input  [11:2] addr;
   input  [31:0] din;
   input         MemRead;
   input 		 MemWrite;
   input         clk;
   input         rst;
   input  [1:0]  laddr;
   input  [1:0]  Saveop;
   output [31:0] dout;  
   reg [31:0] dmem[1023:0];
   integer i;
   always @(posedge clk) begin
		if(rst)begin
			for(i = 0;i<=1023;i=i+1)begin
				dmem[i]=32'b0;
			end
		end
		else if (MemWrite)begin
			case(Saveop)
			2'b10:begin
			if(laddr[1])dmem[addr][31:16]<=din[15:0];
			else dmem[addr][15:0]<=din[15:0];
			end
			2'b01:begin
			case(laddr)
			2'b00:dmem[addr][7:0]<=din[7:0];
			2'b01:dmem[addr][15:8]<=din[7:0];
			2'b10:dmem[addr][23:16]<=din[7:0];
			2'b11:dmem[addr][31:24]<=din[7:0];
			endcase
			end
			2'b00:dmem[addr] <= din;
			default:dmem[addr] <= din;
			endcase
	    end
   end // end always
   assign dout = MemRead?dmem[addr]:31'bz;
endmodule    

