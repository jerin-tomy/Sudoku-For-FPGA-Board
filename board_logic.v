`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:12:53 03/08/2017 
// Design Name: 
// Module Name:    board_logic 
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
module board_logic(
	input wire clk,
	input wire up,
	input wire left,
	input wire down,
	input wire right,
	input wire choose,
    input wire clr,
    input wire win_flag,
    input wire lose_flag,
	output reg [323:0] flat_grid,
	output wire[31:0] select_out
    );
	 

	
	reg [3:0] my_grid[8:0][8:0];
	// Initialization
	integer i_loop;
	integer j_loop;
	
	initial begin
	//	flat_grid = 324'b0001001000110100010101100111100010010001;	
        
		my_grid[0][0] = 4'd0;
		my_grid[0][1] = 4'd0;
		my_grid[0][2] = 4'd0;
		my_grid[0][3] = 4'd2;
		my_grid[0][4] = 4'd6;
		my_grid[0][5] = 4'd0;
		my_grid[0][6] = 4'd7;
		my_grid[0][7] = 4'd0;
		my_grid[0][8] = 4'd1;
		my_grid[1][0] = 4'd6;
		my_grid[1][1] = 4'd8;
		my_grid[1][2] = 4'd0;
		my_grid[1][3] = 4'd0;
		my_grid[1][4] = 4'd7;
		my_grid[1][5] = 4'd0;
		my_grid[1][6] = 4'd0;
		my_grid[1][7] = 4'd9;
		my_grid[1][8] = 4'd0;
		my_grid[2][0] = 4'd1;
		my_grid[2][1] = 4'd9;
		my_grid[2][2] = 4'd0;
		my_grid[2][3] = 4'd0;
		my_grid[2][4] = 4'd0;
		my_grid[2][5] = 4'd4;
		my_grid[2][6] = 4'd5;
		my_grid[2][7] = 4'd0;
		my_grid[2][8] = 4'd0;
		my_grid[3][0] = 4'd8;
		my_grid[3][1] = 4'd2;
		my_grid[3][2] = 4'd0;
		my_grid[3][3] = 4'd1;
		my_grid[3][4] = 4'd0;
		my_grid[3][5] = 4'd0;
		my_grid[3][6] = 4'd0;
		my_grid[3][7] = 4'd4;
		my_grid[3][8] = 4'd0;
		my_grid[4][0] = 4'd0;
		my_grid[4][1] = 4'd0;
		my_grid[4][2] = 4'd4;
		my_grid[4][3] = 4'd6;
		my_grid[4][4] = 4'd0;
		my_grid[4][5] = 4'd2;
		my_grid[4][6] = 4'd9;
		my_grid[4][7] = 4'd0;
		my_grid[4][8] = 4'd0;
		my_grid[5][0] = 4'd0;
		my_grid[5][1] = 4'd5;
		my_grid[5][2] = 4'd0;
		my_grid[5][3] = 4'd0;
		my_grid[5][4] = 4'd0;
		my_grid[5][5] = 4'd3;
		my_grid[5][6] = 4'd0;
		my_grid[5][7] = 4'd2;
		my_grid[5][8] = 4'd8;
		my_grid[6][0] = 4'd0;
		my_grid[6][1] = 4'd0;
		my_grid[6][2] = 4'd9;
		my_grid[6][3] = 4'd3;
		my_grid[6][4] = 4'd0;
		my_grid[6][5] = 4'd0;
		my_grid[6][6] = 4'd0;
		my_grid[6][7] = 4'd7;
		my_grid[6][8] = 4'd4;
		my_grid[7][0] = 4'd0;
		my_grid[7][1] = 4'd4;
		my_grid[7][2] = 4'd0;
		my_grid[7][3] = 4'd0;
		my_grid[7][4] = 4'd5;
		my_grid[7][5] = 4'd0;
		my_grid[7][6] = 4'd0;
		my_grid[7][7] = 4'd3;
		my_grid[7][8] = 4'd6;
		my_grid[8][0] = 4'd7;
		my_grid[8][1] = 4'd0;
		my_grid[8][2] = 4'd3;
		my_grid[8][3] = 4'd0;
		my_grid[8][4] = 4'd1;
		my_grid[8][5] = 4'd8;
		my_grid[8][6] = 4'd0;
		my_grid[8][7] = 4'd0;
		my_grid[8][8] = 4'd0;
		
		/*
        my_grid[0][0] = 4'd4;
        my_grid[0][1] = 4'd3;
        my_grid[0][2] = 4'd5;
        my_grid[0][3] = 4'd2;
        my_grid[0][4] = 4'd6;
        my_grid[0][5] = 4'd9;
        my_grid[0][6] = 4'd7;
        my_grid[0][7] = 4'd8;
        my_grid[0][8] = 4'd1;
        my_grid[1][0] = 4'd6;
        my_grid[1][1] = 4'd8;
        my_grid[1][2] = 4'd2;
        my_grid[1][3] = 4'd5;
        my_grid[1][4] = 4'd7;
        my_grid[1][5] = 4'd1;
        my_grid[1][6] = 4'd4;
        my_grid[1][7] = 4'd9;
        my_grid[1][8] = 4'd3;
        my_grid[2][0] = 4'd1;
        my_grid[2][1] = 4'd9;
        my_grid[2][2] = 4'd7;
        my_grid[2][3] = 4'd8;
        my_grid[2][4] = 4'd3;
        my_grid[2][5] = 4'd4;
        my_grid[2][6] = 4'd5;
        my_grid[2][7] = 4'd6;
        my_grid[2][8] = 4'd2;
        my_grid[3][0] = 4'd8;
        my_grid[3][1] = 4'd2;
        my_grid[3][2] = 4'd6;
        my_grid[3][3] = 4'd1;
        my_grid[3][4] = 4'd9;
        my_grid[3][5] = 4'd5;
        my_grid[3][6] = 4'd3;
        my_grid[3][7] = 4'd4;
        my_grid[3][8] = 4'd7;
        my_grid[4][0] = 4'd3;
        my_grid[4][1] = 4'd7;
        my_grid[4][2] = 4'd4;
        my_grid[4][3] = 4'd6;
        my_grid[4][4] = 4'd8;
        my_grid[4][5] = 4'd2;
        my_grid[4][6] = 4'd9;
        my_grid[4][7] = 4'd1;
        my_grid[4][8] = 4'd5;
        my_grid[5][0] = 4'd9;
        my_grid[5][1] = 4'd5;
        my_grid[5][2] = 4'd1;
        my_grid[5][3] = 4'd7;
        my_grid[5][4] = 4'd4;
        my_grid[5][5] = 4'd3;
        my_grid[5][6] = 4'd6;
        my_grid[5][7] = 4'd2;
        my_grid[5][8] = 4'd8;
        my_grid[6][0] = 4'd5;
        my_grid[6][1] = 4'd1;
        my_grid[6][2] = 4'd9;
        my_grid[6][3] = 4'd3;
        my_grid[6][4] = 4'd2;
        my_grid[6][5] = 4'd6;
        my_grid[6][6] = 4'd8;
        my_grid[6][7] = 4'd7;
        my_grid[6][8] = 4'd4;
        my_grid[7][0] = 4'd2;
        my_grid[7][1] = 4'd4;
        my_grid[7][2] = 4'd8;
        my_grid[7][3] = 4'd9;
        my_grid[7][4] = 4'd5;
        my_grid[7][5] = 4'd7;
        my_grid[7][6] = 4'd1;
        my_grid[7][7] = 4'd3;
        my_grid[7][8] = 4'd6;
        my_grid[8][0] = 4'd7;
        my_grid[8][1] = 4'd0;
        my_grid[8][2] = 4'd3;
        my_grid[8][3] = 4'd0;
        my_grid[8][4] = 4'd1;
        my_grid[8][5] = 4'd8;
        my_grid[8][6] = 4'd0;
        my_grid[8][7] = 4'd0;
        my_grid[8][8] = 4'd0;
		  */
		for(i_loop=0; i_loop<9; i_loop=i_loop+1) begin
			for(j_loop=0; j_loop<9; j_loop=j_loop+1) begin
				 flat_grid[(i_loop*9+j_loop)*4 +: 4] = my_grid[i_loop][j_loop];
			end		
		end
	end

	

	
	/*
		select ranges from 0-80, indictaing the position we are on the board
		board will be represented by select as 
		[0,  1,  2,  3, ...  8]
		[9, 10, 11, 12, ... 17]
		...
		[72, 73, 74, 75, .. 80]
		A value of 10 for select indicates that it is the box we are currently looking at
	*/
	

	
	reg [3:0] old_value = 0;
	integer select = 0;
	always @(posedge clk) begin
		if (clr) begin
            flat_grid[select*4 +: 4] = 0;
               my_grid[0][0] = 4'd4;
				/*
            my_grid[0][1] = 4'd3;
            my_grid[0][2] = 4'd5;
            my_grid[0][3] = 4'd2;
            my_grid[0][4] = 4'd6;
            my_grid[0][5] = 4'd9;
            my_grid[0][6] = 4'd7;
            my_grid[0][7] = 4'd8;
            my_grid[0][8] = 4'd1;
            my_grid[1][0] = 4'd6;
            my_grid[1][1] = 4'd8;
            my_grid[1][2] = 4'd2;
            my_grid[1][3] = 4'd5;
            my_grid[1][4] = 4'd7;
            my_grid[1][5] = 4'd1;
            my_grid[1][6] = 4'd4;
            my_grid[1][7] = 4'd9;
            my_grid[1][8] = 4'd3;
            my_grid[2][0] = 4'd1;
            my_grid[2][1] = 4'd9;
            my_grid[2][2] = 4'd7;
            my_grid[2][3] = 4'd8;
            my_grid[2][4] = 4'd3;
            my_grid[2][5] = 4'd4;
            my_grid[2][6] = 4'd5;
            my_grid[2][7] = 4'd6;
            my_grid[2][8] = 4'd2;
            my_grid[3][0] = 4'd8;
            my_grid[3][1] = 4'd2;
            my_grid[3][2] = 4'd6;
            my_grid[3][3] = 4'd1;
            my_grid[3][4] = 4'd9;
            my_grid[3][5] = 4'd5;
            my_grid[3][6] = 4'd3;
            my_grid[3][7] = 4'd4;
            my_grid[3][8] = 4'd7;
            my_grid[4][0] = 4'd3;
            my_grid[4][1] = 4'd7;
            my_grid[4][2] = 4'd4;
            my_grid[4][3] = 4'd6;
            my_grid[4][4] = 4'd8;
            my_grid[4][5] = 4'd2;
            my_grid[4][6] = 4'd9;
            my_grid[4][7] = 4'd1;
            my_grid[4][8] = 4'd5;
            my_grid[5][0] = 4'd9;
            my_grid[5][1] = 4'd5;
            my_grid[5][2] = 4'd1;
            my_grid[5][3] = 4'd7;
            my_grid[5][4] = 4'd4;
            my_grid[5][5] = 4'd3;
            my_grid[5][6] = 4'd6;
            my_grid[5][7] = 4'd2;
            my_grid[5][8] = 4'd8;
            my_grid[6][0] = 4'd5;
            my_grid[6][1] = 4'd1;
            my_grid[6][2] = 4'd9;
            my_grid[6][3] = 4'd3;
            my_grid[6][4] = 4'd2;
            my_grid[6][5] = 4'd6;
            my_grid[6][6] = 4'd8;
            my_grid[6][7] = 4'd7;
            my_grid[6][8] = 4'd4;
            my_grid[7][0] = 4'd2;
            my_grid[7][1] = 4'd4;
            my_grid[7][2] = 4'd8;
            my_grid[7][3] = 4'd9;
            my_grid[7][4] = 4'd5;
            my_grid[7][5] = 4'd7;
            my_grid[7][6] = 4'd1;
            my_grid[7][7] = 4'd3;
            my_grid[7][8] = 4'd6;
            my_grid[8][0] = 4'd7;
            my_grid[8][1] = 4'd0;
            my_grid[8][2] = 4'd3;
            my_grid[8][3] = 4'd0;
            my_grid[8][4] = 4'd1;
            my_grid[8][5] = 4'd8;
            my_grid[8][6] = 4'd0;
            my_grid[8][7] = 4'd0;
            my_grid[8][8] = 4'd0;
				*/
            
            my_grid[0][0] = 4'd0;
            my_grid[0][1] = 4'd0;
            my_grid[0][2] = 4'd0;
            my_grid[0][3] = 4'd2;
            my_grid[0][4] = 4'd6;
            my_grid[0][5] = 4'd0;
            my_grid[0][6] = 4'd7;
            my_grid[0][7] = 4'd0;
            my_grid[0][8] = 4'd1;
            my_grid[1][0] = 4'd6;
            my_grid[1][1] = 4'd8;
            my_grid[1][2] = 4'd0;
            my_grid[1][3] = 4'd0;
            my_grid[1][4] = 4'd7;
            my_grid[1][5] = 4'd0;
            my_grid[1][6] = 4'd0;
            my_grid[1][7] = 4'd9;
            my_grid[1][8] = 4'd0;
            my_grid[2][0] = 4'd1;
            my_grid[2][1] = 4'd9;
            my_grid[2][2] = 4'd0;
            my_grid[2][3] = 4'd0;
            my_grid[2][4] = 4'd0;
            my_grid[2][5] = 4'd4;
            my_grid[2][6] = 4'd5;
            my_grid[2][7] = 4'd0;
            my_grid[2][8] = 4'd0;
            my_grid[3][0] = 4'd8;
            my_grid[3][1] = 4'd2;
            my_grid[3][2] = 4'd0;
            my_grid[3][3] = 4'd1;
            my_grid[3][4] = 4'd0;
            my_grid[3][5] = 4'd0;
            my_grid[3][6] = 4'd0;
            my_grid[3][7] = 4'd4;
            my_grid[3][8] = 4'd0;
            my_grid[4][0] = 4'd0;
            my_grid[4][1] = 4'd0;
            my_grid[4][2] = 4'd4;
            my_grid[4][3] = 4'd6;
            my_grid[4][4] = 4'd0;
            my_grid[4][5] = 4'd2;
            my_grid[4][6] = 4'd9;
            my_grid[4][7] = 4'd0;
            my_grid[4][8] = 4'd0;
            my_grid[5][0] = 4'd0;
            my_grid[5][1] = 4'd5;
            my_grid[5][2] = 4'd0;
            my_grid[5][3] = 4'd0;
            my_grid[5][4] = 4'd0;
            my_grid[5][5] = 4'd3;
            my_grid[5][6] = 4'd0;
            my_grid[5][7] = 4'd2;
            my_grid[5][8] = 4'd8;
            my_grid[6][0] = 4'd0;
            my_grid[6][1] = 4'd0;
            my_grid[6][2] = 4'd9;
            my_grid[6][3] = 4'd3;
            my_grid[6][4] = 4'd0;
            my_grid[6][5] = 4'd0;
            my_grid[6][6] = 4'd0;
            my_grid[6][7] = 4'd7;
            my_grid[6][8] = 4'd4;
            my_grid[7][0] = 4'd0;
            my_grid[7][1] = 4'd4;
            my_grid[7][2] = 4'd0;
            my_grid[7][3] = 4'd0;
            my_grid[7][4] = 4'd5;
            my_grid[7][5] = 4'd0;
            my_grid[7][6] = 4'd0;
            my_grid[7][7] = 4'd3;
            my_grid[7][8] = 4'd6;
            my_grid[8][0] = 4'd7;
            my_grid[8][1] = 4'd0;
            my_grid[8][2] = 4'd3;
            my_grid[8][3] = 4'd0;
            my_grid[8][4] = 4'd1;
            my_grid[8][5] = 4'd8;
            my_grid[8][6] = 4'd0;
            my_grid[8][7] = 4'd0;
            my_grid[8][8] = 4'd0;
            
            for(i_loop=0; i_loop<9; i_loop=i_loop+1) begin
                for(j_loop=0; j_loop<9; j_loop=j_loop+1) begin
                     flat_grid[(i_loop*9+j_loop)*4 +: 4] = my_grid[i_loop][j_loop];
                end		
            end
            select = 0;
        end
        else if (!win_flag && !lose_flag) begin
            flat_grid[select*4 +: 4] = old_value;
            if(choose == 1) begin
                if (select==3 || select==4 || select==6 || select==8 || select==9 || select==10 ||
                select==13 || select==16 || select==18 || select==19 || select==23 || select==24 ||
                select==27 || select==28 || select==30 || select==34 || select==38 || select==39 ||
                select==41 || select==42 || select==46 || select==50 || select==52 || select==53 ||
                select==56 || select==57 || select==61 || select==62 || select==64 || select==67 ||
                select==70 || select==71 || select==72 || select==74 || select==76 || select==77) begin
                    //do nothing
                end
                else begin
                    if(flat_grid[select*4 +: 4] == 4'd9) begin
                        flat_grid[select*4 +: 4] = 4'd0;
                    end
                    else begin
                        flat_grid[select*4 +: 4] = old_value + 1;
                    end
                end
                old_value = flat_grid[select*4 +: 4];
            end
            else begin
                if(up == 1) begin
                    if (0 <= select && select < 9) begin
                        // We are at the top of the board and move to the bottom
                        select = select + 72;
                    end
                    else begin
                        // move up one row
                        select = select - 9;
                    end
                end
                else if(right == 1) begin
                    if(select == 8 || select == 17 || select == 26 || select == 35 || select == 44 || select == 53 || select == 62 || select == 71 || select == 80) begin
                        // We are at the right-most part of the board and must move to the LHS
                        select = select - 8;
                    end
                    else begin
                        // move right by one
                        select = select + 1;
                    end
                end
                else if(down == 1) begin
                    if(72 <= select && select < 81) begin
                        // We are at the bottom most part of the grid and must move to the top
                        select = select - 72;
                    end
                    else begin
                        // move down one position
                        select = select + 9;
                    end
                end
                else if(left == 1) begin
                    if(select == 0 || select == 9 || select == 18 || select == 27 || select == 36 || select == 45 || select == 54 || select == 63 || select == 72) begin
                        // We are at the left most side and want to move to the RHS
                        select = select + 8;
                    end
                    else begin
                        select = select - 1;
                    end
                end
                else begin
                    // do nothing
                end
                old_value = flat_grid[select*4 +: 4];
    //			flat_grid[select*4 +: 4] = 4'd10;
            end
        end
        else begin
            //do nothing
        end
	end
	
	assign select_out = select;

endmodule
