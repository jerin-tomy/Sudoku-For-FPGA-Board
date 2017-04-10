`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   07:12:31 03/24/2017
// Design Name:   timer
// Module Name:   C:/Users/Jerin/Documents/CSM152A/Final Project/sudoku-regular/NERP_demo/tb_timer.v
// Project Name:  NERP_demo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: timer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_timer;

	// Inputs
	reg clk;
	reg clr;
	reg win_flag;
	
	wire clk1hz;
	wire dclk;
	wire segclk;
	
	// Outputs
	wire lose_flag;
	wire [3:0] sec_u;
	wire [3:0] sec_t;
	wire [3:0] sec_h;
	wire [3:0] h_sec_u;
	wire [3:0] h_sec_t;
	wire [3:0] h_sec_h;

	clockdiv uut1 (
		.clk(clk), 
		.clr(clr), 
		.dclk(dclk), 
		.segclk(segclk), 
		.clk1hz(clk1hz)
	);
	
	// Instantiate the Unit Under Test (UUT)
	timer uut2 (
		.clk_high(clk), 
		.clk(clk1hz), 
		.clr(clr), 
		.win_flag(win_flag), 
		.lose_flag(lose_flag), 
		.sec_u(sec_u), 
		.sec_t(sec_t), 
		.sec_h(sec_h), 
		.h_sec_u(h_sec_u), 
		.h_sec_t(h_sec_t), 
		.h_sec_h(h_sec_h)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;
		win_flag = 0;
	

	end
	
	always begin
		#1 clk = !clk;
	end
	
	
      
endmodule

