`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:49:36 03/19/2013 
// Design Name: 
// Module Name:    clockdiv 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clockdiv(
	input wire clk,		//master clock: 100MHz
	input wire clr,		//asynchronous reset
	output wire dclk,		//pixel clock: 25MHz
	output wire segclk,	//7-segment clock: 381.47Hz
	output wire clk1hz
	);

// 17-bit counter variable
reg [16:0] q = 0;
reg [31:0] sec =0;
reg clk1hz_reg = 0;
// Clock divider --
// Each bit in q is a clock signal that is
// only a fraction of the master clock.
always @(posedge clk or posedge clr)
begin
	// reset condition
	if (clr == 1) begin
		q <= 0;
		sec <=0;
	end
	// increment counter by one
	else begin
		q <= q + 1;
		if (sec != 50000000-1) begin
			sec <=sec+32'b1;
			clk1hz_reg <= clk1hz;
		end
		else begin
			sec <= 0;
			clk1hz_reg <= ~clk1hz;
		end
	end
end

// 100Mhz ÷ 2^17 = 381.47Hz
assign segclk = q[16];
assign clk1hz = clk1hz_reg;
// 100Mhz ÷ 2^2 = 25MHz
assign dclk = q[1];

endmodule
