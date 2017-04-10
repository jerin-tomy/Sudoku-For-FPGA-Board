`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:28:25 03/19/2013 
// Design Name: 
// Module Name:    NERP_demo_top 
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
module NERP_demo_top(
	input wire clk,			//master clock = 50MHz
	input wire clr,			//right-most switch for reset
	input wire btns,			//center button for select
	input wire btnu,			//upper button for movement
	input wire btnl,			//left button for movement
	input wire btnd,			//lower button for movement
	input wire btnr,			//right button for movement
	output reg [7:0] seg,	//7-segment display LEDs
	output reg [3:0] an,	//7-segment display anode enable
	output wire [2:0] red,	//red vga output - 3 bits
	output wire [2:0] green,//green vga output - 3 bits
	output wire [1:0] blue,	//blue vga output - 2 bits
	output wire hsync,		//horizontal sync out
	output wire vsync,			//vertical sync out
	output wire led
	);

// 7-segment clock interconnect
wire segclk;

// VGA display clock interconnect
wire dclk;

wire clk_1hz;
wire clk_1hz_d;

wire up, down, left, right, choose;

wire [323:0] flat_grid;
reg[3:0] my_grid[8:0][8:0];


clockdiv U1(
	.clk(clk),
	.clr(clr),
	.segclk(segclk),
	.dclk(dclk),
	.clk1hz(clk_1hz)
);
	
edge_debouncer btn_sel(
	.clk(clk),
	.low_freq_clk(segclk),
	.btn(btns),
	.btn_out(choose)
);

edge_debouncer btn_up(
	.clk(clk),
	.low_freq_clk(segclk),
	.btn(btnu),
	.btn_out(up)
);

edge_debouncer btn_down(
	.clk(clk),
	.low_freq_clk(segclk),
	.btn(btnd),
	.btn_out(down)
);

edge_debouncer btn_left(
	.clk(clk),
	.low_freq_clk(segclk),
	.btn(btnl),
	.btn_out(left)
);

edge_debouncer btn_right(
	.clk(clk),
	.low_freq_clk(segclk),
	.btn(btnr),
	.btn_out(right)
);

edge_debouncer debounce_clock(
    .clk(clk),
    .low_freq_clk(segclk),
    .btn(clk_1hz),
    .btn_out(clk_1hz_d)
);
//---------------------------GRID ASSIGNMENT---------------------------------------//
	
//top left is [0][0] bottom right is [8][8]
wire [3:0]template_grid[8:0][8:0];

assign template_grid[0][0] = 4'd4;
assign template_grid[0][1] = 4'd3;
assign template_grid[0][2] = 4'd5;
assign template_grid[0][3] = 4'd2;
assign template_grid[0][4] = 4'd6;
assign template_grid[0][5] = 4'd9;
assign template_grid[0][6] = 4'd7;
assign template_grid[0][7] = 4'd8;
assign template_grid[0][8] = 4'd1;
assign template_grid[1][0] = 4'd6;
assign template_grid[1][1] = 4'd8;
assign template_grid[1][2] = 4'd2;
assign template_grid[1][3] = 4'd5;
assign template_grid[1][4] = 4'd7;
assign template_grid[1][5] = 4'd1;
assign template_grid[1][6] = 4'd4;
assign template_grid[1][7] = 4'd9;
assign template_grid[1][8] = 4'd3;
assign template_grid[2][0] = 4'd1;
assign template_grid[2][1] = 4'd9;
assign template_grid[2][2] = 4'd7;
assign template_grid[2][3] = 4'd8;
assign template_grid[2][4] = 4'd3;
assign template_grid[2][5] = 4'd4;
assign template_grid[2][6] = 4'd5;
assign template_grid[2][7] = 4'd6;
assign template_grid[2][8] = 4'd2;
assign template_grid[3][0] = 4'd8;
assign template_grid[3][1] = 4'd2;
assign template_grid[3][2] = 4'd6;
assign template_grid[3][3] = 4'd1;
assign template_grid[3][4] = 4'd9;
assign template_grid[3][5] = 4'd5;
assign template_grid[3][6] = 4'd3;
assign template_grid[3][7] = 4'd4;
assign template_grid[3][8] = 4'd7;
assign template_grid[4][0] = 4'd3;
assign template_grid[4][1] = 4'd7;
assign template_grid[4][2] = 4'd4;
assign template_grid[4][3] = 4'd6;
assign template_grid[4][4] = 4'd8;
assign template_grid[4][5] = 4'd2;
assign template_grid[4][6] = 4'd9;
assign template_grid[4][7] = 4'd1;
assign template_grid[4][8] = 4'd5;
assign template_grid[5][0] = 4'd9;
assign template_grid[5][1] = 4'd5;
assign template_grid[5][2] = 4'd1;
assign template_grid[5][3] = 4'd7;
assign template_grid[5][4] = 4'd4;
assign template_grid[5][5] = 4'd3;
assign template_grid[5][6] = 4'd6;
assign template_grid[5][7] = 4'd2;
assign template_grid[5][8] = 4'd8;
assign template_grid[6][0] = 4'd5;
assign template_grid[6][1] = 4'd1;
assign template_grid[6][2] = 4'd9;
assign template_grid[6][3] = 4'd3;
assign template_grid[6][4] = 4'd2;
assign template_grid[6][5] = 4'd6;
assign template_grid[6][6] = 4'd8;
assign template_grid[6][7] = 4'd7;
assign template_grid[6][8] = 4'd4;
assign template_grid[7][0] = 4'd2;
assign template_grid[7][1] = 4'd4;
assign template_grid[7][2] = 4'd8;
assign template_grid[7][3] = 4'd9;
assign template_grid[7][4] = 4'd5;
assign template_grid[7][5] = 4'd7;
assign template_grid[7][6] = 4'd1;
assign template_grid[7][7] = 4'd3;
assign template_grid[7][8] = 4'd6;
assign template_grid[8][0] = 4'd7;
assign template_grid[8][1] = 4'd6;
assign template_grid[8][2] = 4'd3;
assign template_grid[8][3] = 4'd4;
assign template_grid[8][4] = 4'd1;
assign template_grid[8][5] = 4'd8;
assign template_grid[8][6] = 4'd2;
assign template_grid[8][7] = 4'd5;
assign template_grid[8][8] = 4'd9;




wire win_flag;
wire lose_flag;

wire [3:0] ones;
wire [3:0] tens;
wire [3:0] hundreds;

wire [3:0] h_ones;
wire [3:0] h_tens;
wire [3:0] h_hundreds;


reg [1:0] cycle = 2'b00;




assign led = choose;


wire [31:0] select;
// Make the board logic
board_logic board(
	.clk(clk),
	.up(up),
	.left(left),
	.down(down),
	.right(right),
	.choose(choose),
    .clr(clr),
    .win_flag(win_flag),
    .lose_flag(lose_flag),
	.flat_grid(flat_grid),
	.select_out(select)
);

// VGA controller
vga640x480 U3(
	.dclk(dclk),
	.clr(clr),
	.flat_grid(flat_grid),
	.hsync(hsync),
	.vsync(vsync),
	.red(red),
	.green(green),
	.blue(blue),
	.select(select)
	);
//---------------------------------------CHECK IF WON-----------------------------------------//

integer i_loop;
integer j_loop;
always @* begin
	for(i_loop=0; i_loop<9; i_loop=i_loop+1) begin
		for(j_loop=0; j_loop<9; j_loop=j_loop+1) begin
			my_grid[i_loop][j_loop] = flat_grid[(i_loop*9+j_loop)*4 +: 4];
		end		
	end
end
reg has_won;

always@(posedge clk) begin
    if (clr) begin
        has_won = 0;
    end
	else if (
		my_grid[0][0] == template_grid[0][0] && 
		my_grid[0][1] == template_grid[0][1] &&
		my_grid[0][2] == template_grid[0][2] &&
		my_grid[0][3] == template_grid[0][3] &&
		my_grid[0][4] == template_grid[0][4] &&
		my_grid[0][5] == template_grid[0][5] &&
		my_grid[0][6] == template_grid[0][6] &&
		my_grid[0][7] == template_grid[0][7] &&
		my_grid[0][8] == template_grid[0][8] &&
		my_grid[1][0] == template_grid[1][0] && 
		my_grid[1][1] == template_grid[1][1] &&
		my_grid[1][2] == template_grid[1][2] &&
		my_grid[1][3] == template_grid[1][3] &&
		my_grid[1][4] == template_grid[1][4] &&
		my_grid[1][5] == template_grid[1][5] &&
		my_grid[1][6] == template_grid[1][6] &&
		my_grid[1][7] == template_grid[1][7] &&
		my_grid[1][8] == template_grid[1][8] &&
		my_grid[2][0] == template_grid[2][0] && 
		my_grid[2][1] == template_grid[2][1] &&
		my_grid[2][2] == template_grid[2][2] &&
		my_grid[2][3] == template_grid[2][3] &&
		my_grid[2][4] == template_grid[2][4] &&
		my_grid[2][5] == template_grid[2][5] &&
		my_grid[2][6] == template_grid[2][6] &&
		my_grid[2][7] == template_grid[2][7] &&
		my_grid[2][8] == template_grid[2][8] &&
		my_grid[3][0] == template_grid[3][0] && 
		my_grid[3][1] == template_grid[3][1] &&
		my_grid[3][2] == template_grid[3][2] &&
		my_grid[3][3] == template_grid[3][3] &&
		my_grid[3][4] == template_grid[3][4] &&
		my_grid[3][5] == template_grid[3][5] &&
		my_grid[3][6] == template_grid[3][6] &&
		my_grid[3][7] == template_grid[3][7] &&
		my_grid[3][8] == template_grid[3][8] &&
		my_grid[4][0] == template_grid[4][0] && 
		my_grid[4][1] == template_grid[4][1] &&
		my_grid[4][2] == template_grid[4][2] &&
		my_grid[4][3] == template_grid[4][3] &&
		my_grid[4][4] == template_grid[4][4] &&
		my_grid[4][5] == template_grid[4][5] &&
		my_grid[4][6] == template_grid[4][6] &&
		my_grid[4][7] == template_grid[4][7] &&
		my_grid[4][8] == template_grid[4][8] &&
		my_grid[5][0] == template_grid[5][0] && 
		my_grid[5][1] == template_grid[5][1] &&
		my_grid[5][2] == template_grid[5][2] &&
		my_grid[5][3] == template_grid[5][3] &&
		my_grid[5][4] == template_grid[5][4] &&
		my_grid[5][5] == template_grid[5][5] &&
		my_grid[5][6] == template_grid[5][6] &&
		my_grid[5][7] == template_grid[5][7] &&
		my_grid[5][8] == template_grid[5][8] &&
		my_grid[6][0] == template_grid[6][0] && 
		my_grid[6][1] == template_grid[6][1] &&
		my_grid[6][2] == template_grid[6][2] &&
		my_grid[6][3] == template_grid[6][3] &&
		my_grid[6][4] == template_grid[6][4] &&
		my_grid[6][5] == template_grid[6][5] &&
		my_grid[6][6] == template_grid[6][6] &&
		my_grid[6][7] == template_grid[6][7] &&
		my_grid[6][8] == template_grid[6][8] &&
		my_grid[7][0] == template_grid[7][0] && 
		my_grid[7][1] == template_grid[7][1] &&
		my_grid[7][2] == template_grid[7][2] &&
		my_grid[7][3] == template_grid[7][3] &&
		my_grid[7][4] == template_grid[7][4] &&
		my_grid[7][5] == template_grid[7][5] &&
		my_grid[7][6] == template_grid[7][6] &&
		my_grid[7][7] == template_grid[7][7] &&
		my_grid[7][8] == template_grid[7][8] &&
		my_grid[8][0] == template_grid[8][0] && 
		my_grid[8][1] == template_grid[8][1] &&
		my_grid[8][2] == template_grid[8][2] &&
		my_grid[8][3] == template_grid[8][3] &&
		my_grid[8][4] == template_grid[8][4] &&
		my_grid[8][5] == template_grid[8][5] &&
		my_grid[8][6] == template_grid[8][6] &&
		my_grid[8][7] == template_grid[8][7] &&
		my_grid[8][8] == template_grid[8][8]) begin
			has_won = 1;
	end	
	else begin
		has_won = 0;
	end
end
assign win_flag = has_won;

timer time_left(.clk_high(clk), .clk(clk_1hz_d), .clr(clr), .win_flag(win_flag), .lose_flag(lose_flag), .sec_u(ones), .sec_t(tens), 
    .sec_h(hundreds), .h_sec_u(h_ones), .h_sec_t(h_tens), .h_sec_h(h_hundreds));

// for displaying
wire [7:0] segMin10;
wire [7:0] segMin1;
wire [7:0] segSec10;
wire [7:0] segSec1;

wire [7:0] h_segSec1;
wire [7:0] h_segSec10;
wire [7:0] h_segMin1;

seven_segment get_Unit_Seconds(.digit(ones),.seven_seg(segSec1));
seven_segment get_Tens_Seconds(.digit(tens),.seven_seg(segSec10));
seven_segment get_Hundred_Seconds(.digit(hundreds),.seven_seg(segMin1));
seven_segment get_Thousand_Seconds(.digit(4'b1111),.seven_seg(segMin10));


seven_segment get_High_Units(.digit(h_ones),.seven_seg(h_segSec1));
seven_segment get_High_Tens(.digit(h_tens),.seven_seg(h_segSec10));
seven_segment get_High_Hundreds(.digit(h_hundreds),.seven_seg(h_segMin1));


always@(posedge segclk) begin
    if (win_flag || lose_flag) begin
        if(cycle == 2'b00) begin
            an <= 4'b1110;
            if(clk_1hz) begin
                seg <= segSec1;
            end
            else begin
                seg <= h_segSec1;
            end
            cycle<=cycle+2'b01;
        end
        else if (cycle == 1) begin
            an <= 4'b1101;
            if(clk_1hz) begin
                seg <= segSec10;
            end
            else begin
                seg <= h_segSec10;
            end
            cycle<=cycle+2'b01;
                
        end
        else if (cycle == 2) begin
            an <= 4'b1011;
            if(clk_1hz) begin
                seg <= segMin1;
            end
            else begin
                seg <= h_segMin1;
            end
            cycle<=cycle+2'b01;
        end
        else begin
            cycle <= 2'b00;
            an <= 4'b0111;
            seg<=segMin10;
        end
        
    end
    else begin
        if(cycle == 2'b00) begin
            an <= 4'b1110;
            seg <= segSec1;
            cycle<=cycle+2'b01;
        end
        else if(cycle == 1) begin
            an <= 4'b1101;
            seg <= segSec10;
            cycle<=cycle+2'b01;
        end
        else if(cycle == 2) begin
            an <= 4'b1011;
            seg <= segMin1;
            cycle<=cycle+2'b01;
        end 
        else begin
            cycle <= 2'b00;
            an <= 4'b0111;
            seg<=segMin10;
        end
    end
end


endmodule
