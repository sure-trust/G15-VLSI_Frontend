`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2024 13:20:15
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top
(
input clk, rst, tx_enable,
output [7:0] dout,
output done
);

wire mosi, ss, sclk;

fsm_spi    spi_m (clk, rst, tx_enable, mosi, ss, sclk);
spi_slave  spi_s (sclk, mosi,ss, dout, done);

endmodule
