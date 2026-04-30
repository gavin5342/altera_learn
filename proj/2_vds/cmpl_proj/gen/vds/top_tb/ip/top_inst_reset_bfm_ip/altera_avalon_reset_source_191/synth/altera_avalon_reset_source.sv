// (C) 2001-2026 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $File: //acds/rel/26.1/ip/iconnect/verification/altera_avalon_reset_source/altera_avalon_reset_source.sv $
// $Revision: #1 $
// $Date: 2026/02/05 $
// $Author: psgswbuild $
//------------------------------------------------------------------------------
// Reset generator

`timescale 1ps / 1ps

module altera_avalon_reset_source (
				   clk,
				   reset
				   );
   input  clk;
   output reset;

   parameter ASSERT_HIGH_RESET = 1;    // reset assertion level is high by default
   parameter INITIAL_RESET_CYCLES = 0; // deassert after number of clk cycles
   
// synthesis translate_off
   import verbosity_pkg::*;
   
   logic reset    = ASSERT_HIGH_RESET ? 1'b0 : 1'b1; 
  
   string message = "*uninitialized*";

   int 	  clk_ctr = 0;
   
   always @(posedge clk) begin
      clk_ctr <= clk_ctr + 1;
   end

   always @(*) 
     if (clk_ctr == INITIAL_RESET_CYCLES)
       reset_deassert();

   
   function automatic void __hello();
      $sformat(message, "%m: - Hello from altera_reset_source");
      print(VERBOSITY_INFO, message);            
      $sformat(message, "%m: -   $Revision: #1 $");
      print(VERBOSITY_INFO, message);            
      $sformat(message, "%m: -   $Date: 2026/02/05 $");
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   ASSERT_HIGH_RESET = %0d", ASSERT_HIGH_RESET);      
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   INITIAL_RESET_CYCLES = %0d", INITIAL_RESET_CYCLES);      
      print(VERBOSITY_INFO, message);      
      print_divider(VERBOSITY_INFO);      
   endfunction

   function automatic string get_version();  // public
      // Return BFM version as a string of three integers separated by periods.
      // For example, version 9.1 sp1 is encoded as "9.1.1".      
      string ret_version = "19.1";
      return ret_version;
   endfunction
   
   task automatic reset_assert();  // public
      $sformat(message, "%m: Reset asserted");
      print(VERBOSITY_INFO, message);       
     
      if (ASSERT_HIGH_RESET > 0) begin
	 reset = 1'b1;
      end else begin
	 reset = 1'b0;
      end
   endtask

   task automatic reset_deassert();  // public
      $sformat(message, "%m: Reset deasserted");
      print(VERBOSITY_INFO, message);       
      
      if (ASSERT_HIGH_RESET > 0) begin      
	 reset = 1'b0;
      end else begin
	 reset = 1'b1;
      end
   endtask
   
   initial begin
      __hello();
      if (INITIAL_RESET_CYCLES > 0) 
	reset_assert();
   end
// synthesis translate_on

endmodule

`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "YTu29eqC0KhfAXeRYUICwrAy8f9dNBV8Yu+dcGvIzwUfS9I5ptCmbZm2uCuZOPVBwtVKcWxCI/+NeoaHntIaySHYiXfBS0rjxyGQ1PvQXHCWij1r9uR37Xhl/QPx0bCXnHcqTISdKzkt8Ln8KkNYH7nrnMsVsPv0qdFfytVvHaZA2ymERVJWzYTBStzr1wFRdvdc4EFdV8tOn6e9D/1x/55lNPxUJFwXEnW21qrq43kraxZprhdkpU/gB9waxeRdI4ntc40ZOBVqYsQ2NVPdJ7dtrLusc4YIf9fyr3ZWAvHHPkf5I9BT2dLmtdBxlgBBbl2ILZJhpLEPo+XbHbiNqDaOvePfsnJpaYVhqnrQUq8zRUkyC8rXVtopVm3BPbXCsesRW7JeOow7UF9QwuJ/6JRpP00ckpZM+XpmMDjwBfZOvcMS4UXADBXI47aA704Fh5q06r69FeJWgErj1oXVf5L+CZUtBPMV7P/66kG7+T6bAS7O1JhUp48WQKy4KUzXevLfbL3G7QtR/QbkGAS+ydp5suBMmexpHonlBeTEIhPVm/7YDTXqSdNchT8wDBR18awHfRkwj+fPUOq/hQsE4RaJtGM6QYndMdeNQsFOl+ER9lqaJvT1i1HqZRPuP2VgVlUWHAs8SIyXwsm1XFt1sSWvRTDNnYxciRJ36UvHwiMwNg4LRMZ/8UMtHzC5VvB8Wr5dC7aF2MgRG1afOOAbEKgIsf7zGfOYWyAFcGQ2sTlG0LcO+GmFwbKFSnsD/IHNFfBHg0DwWdKyV2ErsXXM+b6JVM+A2tTEVDbsdgiz07qJ0RSMV0yMoQEJ6qhQX9kihxxhb9deLvGxp+pKwgsK4bu584OlvCybSctyOBJZdvWnE1w3Bwk+4J/R2bifmRuXq+FZ96/ufvvQ2sdXXj7EwO9y5LY+yRTiZMF90YJuZ/ABndw+eItle6LOEE7c2a6Dt3j+5krpkeM5HQtj8khRMJeOm53dZi3RmoLTaQdUt4CDMyVd09cvDGVSaPvurIJ0"
`endif