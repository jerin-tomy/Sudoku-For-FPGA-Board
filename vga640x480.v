`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    vga640x480 
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
module vga640x480(
	input wire dclk,			//pixel clock: 25MHz
	input wire clr,			//asynchronous reset
	input wire [323:0] flat_grid,
	output wire hsync,		//horizontal sync out
	output wire vsync,		//vertical sync out
	output reg [2:0] red,	//red vga output
	output reg [2:0] green, //green vga output
	output reg [1:0] blue,	//blue vga output
	input wire [31:0] select
	);

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 31; 		// end of vertical back porch
parameter vfp = 511; 	// beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

// registers for storing the horizontal & vertical counters
reg [9:0] hc;
reg [9:0] vc;

// Variables for looping
integer i;
integer j;
integer i_loop;
integer j_loop;
reg [23:0] counter;

// In grid, 0 -> nothing, 1 -> O, 2 -> X, 3 -> selecting
reg [3:0] grid[8:0][8:0];
always @* begin
	for(i_loop=0; i_loop<9; i_loop=i_loop+1) begin
		for(j_loop=0; j_loop<9; j_loop=j_loop+1) begin
			grid[i_loop][j_loop] = flat_grid[(i_loop*9+j_loop)*4 +: 4];
		end		
	end
end

// Horizontal & vertical counters --
// this is how we keep track of where we are on the screen.
// ------------------------
// Sequential "always block", which is a block that is
// only triggered on signal transitions or "edges".
// posedge = rising edge  &  negedge = falling edge
// Assignment statements can only be used on type "reg" and need to be of the "non-blocking" type: <=
always @(posedge dclk or posedge clr)
begin
	// reset condition
	if (clr == 1)
	begin
		hc <= 0;
		vc <= 0;
		counter <= 0;
	end
	else
	begin
		counter <= counter + 1;
		// keep counting until the end of the line
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
		
	end
end

// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;

// display 100% saturation colorbars
// ------------------------
// Combinational "always block", which is a block that is
// triggered when anything in the "sensitivity list" changes.
// The asterisk implies that everything that is capable of triggering the block
// is automatically included in the sensitivty list.  In this case, it would be
// equivalent to the following: always @(hc, vc)
// Assignment statements can only be used on type "reg" and should be of the "blocking" type: =
always @(*)
begin
	red = 0;
	blue = 0;
	green = 0;
	
	// Display for grid
	for(i = 0; i < 9; i=i+1) begin
		for(j = 0; j < 9; j=j+1) begin
			if(i != 0 && ((vbp + i*55 - 10 <= vc && vc < vbp + i*55) || (hbp + j*72 - 10 <= hc && hc < hbp + j*72))) begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b11;
			end
			else if(vbp+i*55 <= vc && vc < vbp+(i+1)*55-10 && hbp+j*72 <= hc && hc < hbp+(j+1)*72-10) begin
				if(i*9+j == select) begin
					// display select
					if(counter[23] == 1) begin
						red = 3'b111;
						green = 3'b111;
						blue = 2'b11;
					end
					else if(counter[23] == 0) begin
						if(grid[i][j] == 1) begin
							// Display red
							red = 3'b111;
							green = 3'b000;
							blue = 2'b00;
						end
						else if(grid[i][j] == 2) begin
							// Display orange
							red = 3'b111;
							green = 3'b100;
							blue = 2'b00;
						end
						else if(grid[i][j] == 3) begin
							// display yellow
							red = 3'b111;
							green = 3'b111;
							blue = 2'b00;
						end
						else if(grid[i][j] == 4) begin
							// display green
							red = 3'b000;
							green = 3'b111;
							blue = 2'b00;
						end
						else if(grid[i][j] == 5) begin
							// display green
							red = 3'b000;
							green = 3'b111;
							blue = 2'b11;
						end
						else if(grid[i][j] == 6) begin
							// display blue
							red = 3'b000;
							green = 3'b000;
							blue = 2'b11;
						end
						else if(grid[i][j] == 7) begin
							// display purple
							red = 3'b111;
							green = 3'b000;
							blue = 2'b11;
						end
						else if(grid[i][j] == 8) begin
							// display burgandy
							red = 3'b100;
							green = 3'b001;
							blue = 2'b01;
						end
						else if(grid[i][j] == 9) begin
							// display pink
							red = 3'b111;
							green = 3'b001;
							blue = 2'b10;
						end
						else begin
							// do nothing
						end
					end
					else begin
						// do nothing
					end
				end
				else begin
					if(grid[i][j] == 1) begin
						// Display red
						red = 3'b111;
						green = 3'b000;
						blue = 2'b00;
					end
					else if(grid[i][j] == 2) begin
						// Display orange
						red = 3'b111;
						green = 3'b100;
						blue = 2'b00;
					end
					else if(grid[i][j] == 3) begin
						// display yellow
						red = 3'b111;
						green = 3'b111;
						blue = 2'b00;
					end
					else if(grid[i][j] == 4) begin
						// display green
						red = 3'b000;
						green = 3'b111;
						blue = 2'b00;
					end
					else if(grid[i][j] == 5) begin
						// display green
						red = 3'b000;
						green = 3'b111;
						blue = 2'b11;
					end
					else if(grid[i][j] == 6) begin
						// display blue
						red = 3'b000;
						green = 3'b000;
						blue = 2'b11;
					end
					else if(grid[i][j] == 7) begin
						// display purple
						red = 3'b111;
						green = 3'b000;
						blue = 2'b11;
					end
					else if(grid[i][j] == 8) begin
						// display burgandy
						red = 3'b100;
						green = 3'b001;
						blue = 2'b01;
					end
					else if(grid[i][j] == 9) begin
						// display pink
						red = 3'b111;
						green = 3'b001;
						blue = 2'b10;
					end
					else begin
						// do nothing
					end
				end
			end
			else begin
				// do nothing - NOTE: dont set colors to black here. doesn't work
			end
		end
	end
	
end

endmodule
