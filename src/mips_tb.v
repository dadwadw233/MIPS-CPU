`timescale 1ps/1ps
module mips_tb();
    
   reg clk, rst;
   mips U_MIPS(
      .clk(clk), .rst(rst)
   );

    
   initial begin
      $readmemh( "code.txt" , U_MIPS.U_IM.imem ) ;
      //$monitor("PC = 0x%8X, IR = 0x%8X", U_MIPS.U_PC.PC, U_MIPS.instr ); 
      clk = 1 ;
      rst = 0 ;
      #90 ;
      rst = 1 ;
      #90 ;
      rst = 0 ;
#100000;
   end
   
   always
	   #(50) clk = ~clk;
   
endmodule

