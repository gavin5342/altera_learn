// Quartus Prime SystemVerilog Template
// Quartus Prime Verilog Template
//
// Hyper-Pipelining Module

(* altera_attribute = "-name AUTO_SHIFT_REGISTER_RECOGNITION off" *) 
module hyperpipe 
#(parameter CYCLES = 1, parameter WIDTH = 1) 
(
	input clk,
	input [WIDTH-1:0] din,
	output [WIDTH-1:0] dout
);

	generate if (CYCLES==0) begin : GEN_COMB_INPUT
		assign dout = din;
	end 
	else begin : GEN_REG_INPUT  
		integer i;
		reg [WIDTH-1:0] R_data [CYCLES-1:0];
        
		always @ (posedge clk) 
		begin   
			R_data[0] <= din;      
			for(i = 1; i < CYCLES; i = i + 1) 
            	R_data[i] <= R_data[i-1];
		end
		assign dout = R_data[CYCLES-1];
	end
	endgenerate  

endmodule//


// DSP wrapper for 27 by 27 unsigned multiplication. LATENCY specifies exactly how many registers will be packed into the DSP.
// FAMILY is by default "AUTO" where Quartus will attempt to use the relevant dsp for the current FAMILY.
// The range of valid latencies depends on the FAMILY.

module mult27 #(
    parameter LATENCY = 5,
    parameter AX_WIDTH = 27,
    parameter AY_WIDTH = 27,
    parameter RESULT_A_WIDTH = 54
) (
    input wire clk,
    input wire [AX_WIDTH-1:0] ax,
    input wire [AY_WIDTH-1:0] ay,
    output logic [RESULT_A_WIDTH-1:0] resulta
);

	logic [AX_WIDTH-1:0] ax_reg;
	logic [AX_WIDTH-1:0] ay_reg;
	
	logic [RESULT_A_WIDTH-1:0] result_int;
	
	hyperpipe # (
			.CYCLES  (LATENCY),
			.WIDTH   (RESULT_A_WIDTH)
		) hp (
			.clk      (clk),
			.din      (result_int),
			.dout     (resulta)
		);

	
	always_ff @(posedge clk) begin
		ax_reg <= ax;
		ay_reg <= ay;
		result_int <= ax_reg * ay_reg;
	end

endmodule

module top #(
    parameter LATENCY = 5,
    parameter AX_WIDTH = 27,
    parameter AY_WIDTH = 27,
    parameter RESULT_A_WIDTH = 54
) (
    input wire clk,
    input wire [AX_WIDTH-1:0] ax,
    input wire [AY_WIDTH-1:0] ay,
    output logic [RESULT_A_WIDTH-1:0] resulta
);
	mult27 #(
		.LATENCY(LATENCY),
		.AX_WIDTH(AX_WIDTH),
		.AY_WIDTH(AY_WIDTH),
		.RESULT_A_WIDTH(RESULT_A_WIDTH)
	)(
		.clk(clk),
		.ax(ax),
		.ay(ay),
		.resulta(resulta)
	);

endmodule


