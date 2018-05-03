`timescale 10ns / 100 ps

module vga_controller
	#(parameter h_size = 800,
	  parameter h_synctime = 80,
	  parameter h_porch = 80,
	  
	  parameter v_size = 600,
	  parameter v_synctime = 1,
	  parameter v_porch = 46)
	  
	  (input reset,
	   input clk,
		inout hsync,
		inout vsync,
		output [2:0] rgb);
	
	
	reg h_period = h_size + h_synctime + h_porch;
	reg v_period = v_size + v_synctime + v_porch;
	reg [10:0] h_counter;
	reg [9:0]  v_counter;
	
	always @(clk, reset) begin
		if (reset == 1) begin
			h_counter = 0;
		end
		else begin
			if (clk == 1) begin
				if (h_counter < h_period) begin
					h_counter = h_counter + 1;
				end
				else begin
						h_counter = 0;
				end
			end
		end
	end 
	
	always @(h_sync,reset) begin
		if(reset == 1) begin
			v_counter = 0;
		end
		else begin
			if(hsync == 1) begin
				if(v_counter < v_period) begin
					v_counter = v_counter = 1;
				end
				else begin
					v_counter = 0;
				end
			end
		end
	end
	
	always @(clk, reset) begin
		if(reset == 1) begin
			h_sync = 0;
		end
		
	end

endmodule
