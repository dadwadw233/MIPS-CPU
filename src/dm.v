module dm_4k( addr, din, MemRead, MemWrite, clk, dout );
   
   input  [11:2] addr;
   input  [31:0] din;
   input         MemRead;
   input 		 MemWrite;
   input         clk;
   output [31:0] dout;
     
   reg [31:0] dmem[1023:0];
   
   always @(posedge clk) begin
      if (MemWrite)
         dmem[addr] <= din;
   end // end always
   
   assign dout = MemRead?dmem[addr]:31'bz;
    
endmodule    

