module top (
	input wire clk,
	input wire reset_in,
	input wire	in_ex1,
	output logic [23:0] count
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
	
	// naive 16-bit count
	always_ff @(posedge clk) begin
		if (reset) begin
			count <= 24'd0;
		end else begin
			if (count < ((2**24) - 24'd1)) begin
				count <= count + 24'd1;
			end else begin
				count <= 24'd0;
			end
		end
	end

	
endmodule