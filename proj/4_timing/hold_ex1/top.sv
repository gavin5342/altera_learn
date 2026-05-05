module top (
	input wire clk,
	input wire reset_in,
	input wire	in_ex1,
	output logic out_ex1
	);
	
//reset
	wire ninit_done;
	wire comb_rst = ninit_done | reset_in;
	logic [1:0] reset_sh;
	logic reset;
	
	rst_rel the_rst_rel (
		.ninit_done(ninit_done)
	);
	
	always_ff @(posedge clk or posedge comb_rst) begin : rst_pulse_extend
		if (comb_rst) begin
			reset_sh <= 2'd3;
		end else begin
			reset_sh[0] <= 1'b0;
			reset_sh[1] <= reset_sh[0];
			reset <= reset_sh[1];
		end
	end
	
	//hold illustration
	
	
	wire clk0;
	wire clk90;
	logic [1:0] the_reg_ex1;

	the_pll the_pll_inst (
		.refclk(clk),
		.rst(reset),
		.outclk_0(clk0),
		.outclk_1(clk90)
		);
	
	//source clk to pll output - incorrect compensation mode
	always_ff @(posedge clk) begin
		the_reg_ex1[0] <= in_ex1;
	end
	
	always_ff @(posedge clk0) begin
		the_reg_ex1[1] <= the_reg_ex1[0];
		out_ex1 <= the_reg_ex1;
	end
	
	/*
		
	logic [3:0][1023:0] reg_bank;

	always_ff @(posedge clk0) begin
		reg_bank[0] <= in_vec;
		reg_bank[3:1] <= reg_bank[2:0];
	end
	
	always_ff @(posedge clk90) begin
		out_vec <= reg_bank[3];
	end
	*/
	
endmodule