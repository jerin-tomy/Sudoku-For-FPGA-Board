`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:42:33 03/06/2017 
// Design Name: 
// Module Name:    timer 
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
module timer(
	clk_high, clk, clr, win_flag, lose_flag, sec_u, sec_t, sec_h, h_sec_u, h_sec_t, h_sec_h
    );
	input clk_high; 
	input clk;
   input clr;
	input win_flag;
	output lose_flag; 
	
	output [3:0] sec_u;
	output [3:0] sec_t; 
	output [3:0] sec_h; 
	
   output [3:0] h_sec_u;
	output [3:0] h_sec_t; 
	output [3:0] h_sec_h; 
 
	reg o_lose = 0;
	
	reg [3:0] high_units = 4'b0010;
   reg [3:0] high_tens = 4'b0;
   reg [3:0] high_hundreds = 4'b0;
    
	reg [3:0] units = 4'b1001;
	reg [3:0] tens = 4'b1001;
	reg [3:0] hundreds = 4'b1001;
	
    
	always@(posedge clk_high) begin
		//won: pause the score
        if (clr) begin 
            units <= 4'b1001;
            tens <= 4'b1001;
            hundreds <= 4'b1001;
            o_lose <= 0;
        end
        else if (clk) begin
            if (win_flag == 1) begin
                o_lose <= 0;
                if (high_hundreds < hundreds) begin
                    high_units <= units;
                    high_tens <= tens;
                    high_hundreds <= hundreds;
                end
                else if (high_hundreds == hundreds) begin
                    if (high_tens < tens) begin
                        high_units <= units;
                        high_tens <= tens;
                        high_hundreds <= hundreds;
                    end
                    else if (high_tens == tens) begin
                        if (high_units < units) begin
                            high_units <= units;
                            high_tens <= tens;
                            high_hundreds <= hundreds;
                        end
                        else begin
                            //do nothing
                        end
                    end
                    else begin
                        //do nothing
                    end
                end
                else begin
                    //do nothing
                end
					 
            end
            else begin
                //lost: pause the score at 0, set lose_flag to 1
                if (units == 4'b0 && tens == 4'b0 && hundreds == 4'b0) begin
                    o_lose <= 1;
                end
                //game still going on: decrement the counter
                else begin
                    if(units == 4'b0 && tens == 4'b0) begin
                        hundreds <= hundreds -1;
                        units <= 4'b1001;
                        tens <= 4'b1001;	
                    end
                    
                    else if (units == 4'b0) begin
                        tens <= tens -1;
                        units <= 4'b1001;
                    end
                    else begin
                        units <= units -1;
                    end
                end
            
            end
		end
	end
	assign lose_flag = o_lose;
	assign sec_u = units;
	assign sec_t = tens;
	assign sec_h = hundreds;
    assign h_sec_u = high_units;
    assign h_sec_t = high_tens;
    assign h_sec_h = high_hundreds;
	
endmodule
