`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:11:53 03/10/2017 
// Design Name: 
// Module Name:    edge_debouncer 
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
module edge_debouncer(
	input clk,
	input low_freq_clk,
	input btn,
	output btn_out
    );

reg [2:0] btn_history;

always @(posedge clk) begin
	if(low_freq_clk) begin
		btn_history = { btn, btn_history[2:1] };
	end
end

assign btn_out = ~btn_history[0] & btn_history[1] & low_freq_clk;


//
//   wire        rst;
//   wire        arst_i;
//   wire [17:0] clk_dv_inc;
//
//   reg [1:0]   arst_ff;
//   reg [16:0]  clk_dv;
//   reg         clk_en;
//   reg         clk_en_d;
//      
//   reg [7:0]   inst_wd;
//   reg         inst_vld;
//   reg [2:0]   step_d;
//
//   reg [7:0]   inst_cnt;
//
//   // ===========================================================================
//   // 763Hz timing signal for clock enable
//   // ===========================================================================
//
//   assign clk_dv_inc = clk_dv + 1;
//   
//   always @ (posedge clk)
//     if (rst)
//       begin
//          clk_dv   <= 0;
//          clk_en   <= 1'b0;
//          clk_en_d <= 1'b0;
//       end
//     else
//       begin
//          clk_dv   <= clk_dv_inc[16:0];
//          clk_en   <= clk_dv_inc[17];
//          clk_en_d <= clk_en;
//       end
//   
//   // ===========================================================================
//   // Instruction Stepping Control
//   // ===========================================================================
//
//   always @ (posedge clk)
//     if (rst)
//       begin
//          inst_wd[7:0] <= 0;
//          step_d[2:0]  <= 0;
//       end
//     else if (clk_en)
//       begin
//          inst_wd[7:0] <= sw[7:0];
//          step_d[2:0]  <= {btn, step_d[2:1]};
//       end
//
//   always @ (posedge clk)
//     if (rst)
//       inst_vld <= 1'b0;
//     else
//       inst_vld <= ~step_d[0] & step_d[1] & clk_en_d;
//
//	assign btn_out = inst_vld;


endmodule
