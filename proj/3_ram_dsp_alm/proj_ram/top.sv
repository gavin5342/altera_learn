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

module dc_sdp_ram_be #(
	parameter int ADDRW = 6,
	parameter int BYTEW = 8,
	parameter int NUMBYTES = 4,
	parameter bit MLAB = 1
)(
	input		wire			rdclk,	
	input		wire			wrclk,	
	input		wire			we,	
	input		wire [ADDRW-1:0]	rdaddr,
	input		wire [ADDRW-1:0]	wraddr,
	input		wire  [NUMBYTES-1:0] be,
	output	logic [NUMBYTES-1:0][BYTEW-1:0]	rddata,
	input 	wire [NUMBYTES-1:0][BYTEW-1:0]	wrdata	
	);
	
	localparam int WORDS = 1 << ADDRW ;	
	localparam int IN_LAT = 2;
	localparam int OUT_LAT = 2;
	
	(* ramstyle = "MLAB" *) logic [NUMBYTES-1:0][BYTEW-1:0] the_mem_mlab [WORDS];
	(* ramstyle = "M20K" *) logic [NUMBYTES-1:0][BYTEW-1:0] the_mem_m20k [WORDS];
	logic [NUMBYTES-1:0][BYTEW-1:0] rddata_int;
	logic [NUMBYTES-1:0][BYTEW-1:0] wrdata_int;
	logic [NUMBYTES-1:0] be_int;
	logic [ADDRW-1:0] wraddr_int;
	logic [ADDRW-1:0] rdaddr_int;
	logic we_int;
	
	// Quartus Prime SystemVerilog Template
	//
	// Hyper-Pipelining Module Instantiation

	hyperpipe # (
			.CYCLES         ( OUT_LAT),
			.PACKED_WIDTH   (NUMBYTES*BYTEW)
		) hp_rddata (
			.clk      (rdclk),
			.din      (rddata_int ),
			.dout     (rddata)
		);

	hyperpipe # (
			.CYCLES         ( IN_LAT),
			.PACKED_WIDTH   (NUMBYTES)
		) hp_be (
			.clk      (wrclk),
			.din      (be ),
			.dout     (be_int)
		);		
		
	hyperpipe # (
			.CYCLES         ( IN_LAT),
			.PACKED_WIDTH   (1)
		) hp_we (
			.clk      (wrclk),
			.din      (we ),
			.dout     (we_int)
		);				
		
	hyperpipe # (
			.CYCLES         ( IN_LAT),
			.PACKED_WIDTH   (NUMBYTES*BYTEW)
		) hp_wrdata (
			.clk      (wrclk),
			.din      (wrdata),
			.dout     (wrdata_int)
		);		
		
	hyperpipe # (
			.CYCLES         ( IN_LAT),
			.PACKED_WIDTH   (ADDRW)
		) hp_wraddr (
			.clk      (wrclk),
			.din      (wraddr),
			.dout     (wraddr_int)
		);	
		
	hyperpipe # (
			.CYCLES         ( IN_LAT),
			.PACKED_WIDTH   (ADDRW)
		) hp_rdaddr (
			.clk      (rdclk),
			.din      (rdaddr),
			.dout     (rdaddr_int)
		);	
	
	generate
	if (MLAB) begin
		always_ff @(posedge wrclk) begin
			if(we_int) begin
				for (int i = 0; i < NUMBYTES; i++) begin
					if (be_int[i]) begin
						the_mem_mlab[wraddr_int][i] <= wrdata_int[i];
					end
				end
			end
		end
		
		always_ff @(posedge rdclk) begin
			rddata_int <= the_mem_mlab[rdaddr_int];
		end
	end else begin
		always_ff@(posedge wrclk) begin
			if(we_int) begin
				for (int i = 0; i < NUMBYTES; i++) begin
					if (be_int[i]) begin
						the_mem_m20k[wraddr_int][i] <= wrdata_int[i];
					end
				end
			end
		end
		
		always_ff @(posedge rdclk) begin
			rddata_int <= the_mem_m20k[rdaddr_int];
		end
	end
	endgenerate
	
endmodule : dc_sdp_ram_be

module dc_sdp_ram_be_mixed #(
	parameter int ADDRW = 6,
	parameter int BYTEW = 8,
	parameter int NUMBYTES = 4,
	parameter bit MLAB = 1
)(
	input		wire			rdclk,	
	input		wire			wrclk,	
	input		wire			we,	
	input		wire [ADDRW-1:0]	rdaddr,
	input		wire [ADDRW-1:0]	wraddr,
	input		wire  [NUMBYTES-1:0] be,
	output	logic [NUMBYTES-1:0][BYTEW-1:0]	rddata,
	input 	wire [NUMBYTES-1:0][BYTEW-1:0]	wrdata	
	);
	
	localparam int WORDS = 1 << ADDRW ;	
	localparam int IN_LAT = 2;
	localparam int OUT_LAT = 2;
	
	(* ramstyle = "MLAB" *) logic [NUMBYTES-1:0][BYTEW-1:0] the_mem_mlab [WORDS];
	(* ramstyle = "M20K" *) logic [NUMBYTES-1:0][BYTEW-1:0] the_mem_m20k [WORDS];
	logic [NUMBYTES-1:0][BYTEW-1:0] rddata_int;
	logic [NUMBYTES-1:0][BYTEW-1:0] wrdata_int;
	logic [NUMBYTES-1:0] be_int;
	logic [ADDRW-1:0] wraddr_int;
	logic [ADDRW-1:0] rdaddr_int;
	logic we_int;
	
	// Quartus Prime SystemVerilog Template
	//
	// Hyper-Pipelining Module Instantiation

	hyperpipe # (
			.CYCLES         ( OUT_LAT),
			.PACKED_WIDTH   (NUMBYTES*BYTEW)
		) hp_rddata (
			.clk      (rdclk),
			.din      (rddata_int ),
			.dout     (rddata)
		);

	hyperpipe # (
			.CYCLES         ( IN_LAT),
			.PACKED_WIDTH   (NUMBYTES)
		) hp_be (
			.clk      (wrclk),
			.din      (be ),
			.dout     (be_int)
		);		
		
	hyperpipe # (
			.CYCLES         ( IN_LAT),
			.PACKED_WIDTH   (1)
		) hp_we (
			.clk      (wrclk),
			.din      (we ),
			.dout     (we_int)
		);				
		
	hyperpipe # (
			.CYCLES         ( IN_LAT),
			.PACKED_WIDTH   (NUMBYTES*BYTEW)
		) hp_wrdata (
			.clk      (wrclk),
			.din      (wrdata),
			.dout     (wrdata_int)
		);		
		
	hyperpipe # (
			.CYCLES         ( IN_LAT),
			.PACKED_WIDTH   (ADDRW)
		) hp_wraddr (
			.clk      (wrclk),
			.din      (wraddr),
			.dout     (wraddr_int)
		);	
		
	hyperpipe # (
			.CYCLES         ( IN_LAT),
			.PACKED_WIDTH   (ADDRW)
		) hp_rdaddr (
			.clk      (rdclk),
			.din      (rdaddr),
			.dout     (rdaddr_int)
		);	
	
	generate
	if (MLAB) begin
		always_ff @(posedge wrclk) begin
			if(we_int) begin
				for (int i = 0; i < NUMBYTES; i++) begin
					if (be_int[i]) begin
						the_mem_mlab[wraddr_int][i] <= wrdata_int[i];
					end
				end
			end
		end
		
		always_ff @(posedge rdclk) begin
			rddata_int <= the_mem_mlab[rdaddr_int];
		end
	end else begin
		always_ff@(posedge wrclk) begin
			if(we_int) begin
				for (int i = 0; i < NUMBYTES; i++) begin
					if (be_int[i]) begin
						the_mem_m20k[wraddr_int][i] <= wrdata_int[i];
					end
				end
			end
		end
		
		always_ff @(posedge rdclk) begin
			rddata_int <= the_mem_m20k[rdaddr_int];
		end
	end
	endgenerate
	
endmodule : dc_sdp_ram_be_mixed


module top (
	input		wire			rdclk,
	input		wire			wrclk,
	input		wire			rst,
	input		wire [5:0]	rdaddr,
	input		wire [5:0]	wraddr,
	input		wire [3:0]	be,
	output	logic [31:0]	rddata_sp,
	input 	wire [31:0]	wrdata_sp,
	output	logic [31:0]	rddata_dp,
	input 	wire [31:0]	wrdata_dp,	
	output	wire	[3:0]		test_out
	);
	
	parameter bit MLAB=0;
	
	logic [5:0] rdaddr_reg;
	
	always_ff @(posedge rdclk or posedge rst) begin
		if (rst) begin
			rdaddr_reg <= 6'h0;
		end else begin
			rdaddr_reg <= rdaddr;
		end
	end		
	
	ram_be #(
		.ADDRW(6),
		.BYTEW(8),
		.NUMBYTES(4),
		.MLAB(MLAB)
	) ram_be_inst (
		.clk(rdclk),
		.we(1'b1),
		.be(be),
		.rdaddr(rdaddr_reg),
		.wraddr(wraddr),
		.rddata(rddata_sp),
		.wrdata(wrdata_sp)
	);
	
	dc_sdp_ram_be #(
		.ADDRW(6),
		.BYTEW(8),
		.NUMBYTES(4),
		.MLAB(MLAB)
	) dc_sdp_ram_be_inst (
		.rdclk(rdclk),
		.wrclk(wrclk),
		.we(1'b1),
		.be(be),
		.rdaddr(rdaddr_reg),
		.wraddr(wraddr),
		.rddata(rddata_dp),
		.wrdata(wrdata_dp)
	);		
	
endmodule


























