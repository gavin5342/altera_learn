// Quartus Prime SystemVerilog Template
//
// Hyper-Pipelining Module

(* altera_attribute = "-name AUTO_SHIFT_REGISTER_RECOGNITION off" *) 
module hyperpipe 
	#(parameter int
		CYCLES = 1,
		PACKED_WIDTH = 1
) 
(
	input clk,
	input [PACKED_WIDTH-1:0] din,
	output [PACKED_WIDTH-1:0] dout
);

	generate if (CYCLES == 0) begin : GEN_COMB_INPUT
		assign dout = din;
	end
	else begin : GEN_REG_INPUT
		integer i;
		reg [PACKED_WIDTH-1:0] R_data [CYCLES-1:0];
          
		always_ff@(posedge clk) 
		begin
			R_data[0] <= din;
			for(i = 1; i < CYCLES; i = i + 1)
				R_data[i] <= R_data[i-1];
		end
		assign dout = R_data[CYCLES-1];
	end
	endgenerate

endmodule : hyperpipe


module ram_be #(
	parameter int ADDRW = 6,
	parameter int BYTEW = 8,
	parameter int NUMBYTES = 4,
	parameter bit MLAB = 1
)(
	input		wire			clk,	
	input		wire			we,	
	input		wire [ADDRW-1:0]	rdaddr,
	input		wire [ADDRW-1:0]	wraddr,
	input		wire  [NUMBYTES-1:0] be,
	output	logic [NUMBYTES-1:0][BYTEW-1:0]	rddata,
	input 	wire [NUMBYTES-1:0][BYTEW-1:0]	wrdata	
	);
	
	localparam int WORDS = 1 << ADDRW ;	
	
	(* ramstyle = "MLAB" *) logic [NUMBYTES-1:0][BYTEW-1:0] the_mem_mlab [WORDS];
	(* ramstyle = "M20K" *) logic [NUMBYTES-1:0][BYTEW-1:0] the_mem_m20k [WORDS];
	logic [NUMBYTES-1:0][BYTEW-1:0] rddata_int;
	
	// Quartus Prime SystemVerilog Template
	//
	// Hyper-Pipelining Module Instantiation

	hyperpipe # (
			.CYCLES         ( 5),
			.PACKED_WIDTH   (NUMBYTES*BYTEW)
		) hp (
			.clk      (clk),
			.din      (rddata_int ),
			.dout     (rddata)
		);


	
	generate
	if (MLAB) begin
		always_ff@(posedge clk)
		begin
			if(we) begin
				for (int i = 0; i < NUMBYTES; i++) begin
					if (be[i]) begin
						the_mem_mlab[wraddr][i] <= wrdata[i];
					end
				end
			end
			rddata_int <= the_mem_mlab[rdaddr];
		end
	end else begin
		always_ff@(posedge clk)
		begin
			if(we) begin
				for (int i = 0; i < NUMBYTES; i++) begin
					if (be[i]) begin
						the_mem_m20k[wraddr][i] <= wrdata[i];
					end
				end
			end
			rddata_int <= the_mem_m20k[rdaddr];
		end
	end
	endgenerate
	
endmodule : ram_be


module top (
	input		wire			rdclk,
	input		wire			wrclk,
	input		wire			rst,
	input		wire [5:0]	rdaddr,
	input		wire [5:0]	wraddr,
	input		wire [3:0]	be,
	output	logic [31:0]	rddata,
	input 	wire [31:0]	wrdata,
	output	wire	[3:0]		test_out
	);
	
	ram_be #(
		.ADDRW(6),
		.BYTEW(8),
		.NUMBYTES(4),
		.MLAB(1)
	) ram_be_inst (
		.clk(rdclk),
		.we(1'b1),
		.be(be),
		.rdaddr(rdaddr),
		.wraddr(wraddr),
		.rddata(rddata),
		.wrdata(wrdata)
	);
	
endmodule


























