`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2024 13:29:27
// Design Name: 
// Module Name: tb1
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


module tb1(

    );
    reg clk_0=0;
  wire done_0;
  wire [7:0]dout_0;
  reg rst_0=1;
  reg tx_enable_0;
  
    always #5 clk_0 = ~clk_0;
    
    initial begin
    rst_0 = 1;
    repeat(5) @(posedge clk_0);
    rst_0 = 0;
    end

    initial begin
    tx_enable_0 = 0;
    repeat(5) @(posedge clk_0);
    tx_enable_0 = 1;
    end
    
     design_1 design_1_i
       (.clk_0(clk_0),
        .done_0(done_0),
        .dout_0(dout_0),
        .rst_0(rst_0),
        .tx_enable_0(tx_enable_0));
        
        

endmodule
