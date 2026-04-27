module top_niosv (
		input  wire        clk,                         //                 clk.clk,    Clock Input
		input  wire        reset_reset,                 //               reset.reset,  Reset Input
		output wire [31:0] instruction_manager_awaddr,  // instruction_manager.awaddr
		output wire [2:0]  instruction_manager_awprot,  //                    .awprot
		output wire        instruction_manager_awvalid, //                    .awvalid
		input  wire        instruction_manager_awready, //                    .awready
		output wire [31:0] instruction_manager_wdata,   //                    .wdata
		output wire [3:0]  instruction_manager_wstrb,   //                    .wstrb
		output wire        instruction_manager_wvalid,  //                    .wvalid
		input  wire        instruction_manager_wready,  //                    .wready
		input  wire [1:0]  instruction_manager_bresp,   //                    .bresp
		input  wire        instruction_manager_bvalid,  //                    .bvalid
		output wire        instruction_manager_bready,  //                    .bready
		output wire [31:0] instruction_manager_araddr,  //                    .araddr
		output wire [2:0]  instruction_manager_arprot,  //                    .arprot
		output wire        instruction_manager_arvalid, //                    .arvalid
		input  wire        instruction_manager_arready, //                    .arready
		input  wire [31:0] instruction_manager_rdata,   //                    .rdata
		input  wire [1:0]  instruction_manager_rresp,   //                    .rresp
		input  wire        instruction_manager_rvalid,  //                    .rvalid
		output wire        instruction_manager_rready,  //                    .rready
		output wire [31:0] data_manager_awaddr,         //        data_manager.awaddr
		output wire [2:0]  data_manager_awprot,         //                    .awprot
		output wire        data_manager_awvalid,        //                    .awvalid
		input  wire        data_manager_awready,        //                    .awready
		output wire [31:0] data_manager_wdata,          //                    .wdata
		output wire [3:0]  data_manager_wstrb,          //                    .wstrb
		output wire        data_manager_wvalid,         //                    .wvalid
		input  wire        data_manager_wready,         //                    .wready
		input  wire [1:0]  data_manager_bresp,          //                    .bresp
		input  wire        data_manager_bvalid,         //                    .bvalid
		output wire        data_manager_bready,         //                    .bready
		output wire [31:0] data_manager_araddr,         //                    .araddr
		output wire [2:0]  data_manager_arprot,         //                    .arprot
		output wire        data_manager_arvalid,        //                    .arvalid
		input  wire        data_manager_arready,        //                    .arready
		input  wire [31:0] data_manager_rdata,          //                    .rdata
		input  wire [1:0]  data_manager_rresp,          //                    .rresp
		input  wire        data_manager_rvalid,         //                    .rvalid
		output wire        data_manager_rready          //                    .rready
	);
endmodule

