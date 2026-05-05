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
	
	//hold illustration - placement
	logic [1:0] the_reg_ex1;

	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			the_reg_ex1 <= 2'h0;
			out_ex1 <= 1'b0;
		end else begin
			the_reg_ex1[0] <= in_ex1;
			the_reg_ex1[1] <= the_reg_ex1[0];
			out_ex1 <= the_reg_ex1[1];
		end
	end

	
endmodule