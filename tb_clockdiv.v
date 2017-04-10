`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:36:14 03/24/2017
// Design Name:   clockdiv
// Module Name:   C:/Users/Jerin/Documents/CSM152A/Final Project/sudoku-regular/NERP_demo/tb_clockdiv.v
// Project Name:  NERP_demo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clockdiv
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_clockdiv;

	// Inputs
	reg clk;
	reg clr;

	// Outputs
	wire dclk;
	wire segclk;
	wire clk1hz;
	
	reg [24:0] counter = 0;
	// Instantiate the Unit Under Test (UUT)
	clockdiv uut (
		.clk(clk), 
		.clr(clr), 
		.dclk(dclk), 
		.segclk(segclk), 
		.clk1hz(clk1hz)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;


	end
	
	always begin
		#1 clk = !clk;
		if (counter == 25'b1111111111111111111111111) begin
			clr = 1;
			counter = 0;
		end
		else
			counter = counter + 1;
	end
	
      
endmodule

