module top #(
	parameter int addr_width = 10,
	parameter int data_width = 8
)(
	input wire clk,
	input wire reset,
	input wire csn,
	input wire serial_in,
	output logic state_indicator,
	input wire [addr_width - 1:0] ram_read_addr,
	output logic [data_width - 1:0] ram_out
	);
	
	
	wire cs = ~csn;
	logic cs_del;
	logic [data_width - 1:0] datap;
	logic xfer_cmpl;
	
	bit [data_width - 1:0] mem [2**addr_width];
	logic [9:0] mem_ptr;
	
	always @(posedge clk) begin: shift_reg
		if (cs) begin
			datap[data_width-1:1] <= datap[data_width-2:0];
			datap[0] <= serial_in;
		end
	end
	
	always @(posedge clk) begin: xfer_det
		cs_del <= cs;
		if (cs_del && ~cs) begin //end of xfer
			xfer_cmpl <= 1'b1;
		end else begin
			xfer_cmpl <= 1'b0;
		end
	end
	
	enum {WAIT_FOR_KEY1, WAIT_FOR_KEY2, UNLOCK} lock_state;
	
	always @(posedge clk or posedge reset) begin: lock_fsm
		if (reset) begin
			lock_state <= WAIT_FOR_KEY1;
		end else begin
			if (xfer_cmpl) begin
				if (datap == (data_width)'('hBA)) begin
					lock_state <= WAIT_FOR_KEY2;
				end
				if (datap == (data_width)'('hBE)) begin
					lock_state <= UNLOCK;
				end
			end
		end
	end
	
	assign state_indicator =  (lock_state == UNLOCK) ? 1'b1 : 1'b0;
	
	always @(posedge clk or posedge reset) begin : memory_cnt
		if (reset) begin
			mem_ptr <= 10'd0;
		end else begin
			if (state_indicator && xfer_cmpl) begin
				if (mem_ptr < 10'd1023) begin
					mem_ptr <= mem_ptr + 10'd1;
				end else begin
					mem_ptr <= 10'd0;
				end
			end
		end
	end
	
	always @(posedge clk) begin: mem_blk
		if (xfer_cmpl) begin
			mem[mem_ptr] <= datap;
			ram_out <= mem[ram_read_addr];
		end
		
	end
	
endmodule