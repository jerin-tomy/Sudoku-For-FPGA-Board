`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:33:19 03/24/2017
// Design Name:   NERP_demo_top
// Module Name:   C:/Users/Jerin/Documents/CSM152A/Final Project/sudoku-regular/NERP_demo/tb.v
// Project Name:  NERP_demo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: NERP_demo_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb;

	// Inputs
	reg clk;
	reg clr;
	reg btns;
	reg btnu;
	reg btnl;
	reg btnd;
	reg btnr;

	// Outputs
	wire [7:0] seg;
	wire [3:0] an;
	wire [2:0] red;
	wire [2:0] green;
	wire [1:0] blue;
	wire hsync;
	wire vsync;
	wire led;

	// Instantiate the Unit Under Test (UUT)
	NERP_demo_top uut (
		.clk(clk), 
		.clr(clr), 
		.btns(btns), 
		.btnu(btnu), 
		.btnl(btnl), 
		.btnd(btnd), 
		.btnr(btnr), 
		.seg(seg), 
		.an(an), 
		.red(red), 
		.green(green), 
		.blue(blue), 
		.hsync(hsync), 
		.vsync(vsync), 
		.led(led)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;
		btns = 0;
		btnu = 0;
		btnl = 0;
		btnd = 0;
		btnr = 0;

	end
	always @* begin
		clk = ~clk;
		#1;
	end
      
endmodule

