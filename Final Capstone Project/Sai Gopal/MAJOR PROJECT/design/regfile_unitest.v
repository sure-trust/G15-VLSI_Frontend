`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.11.2023 19:06:11
// Design Name: 
// Module Name: regfile_unitest
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


module regfile_unitest();
 reg I_clk;
 reg [15:0] I_dataD;
 reg I_en;
 reg [2:0] I_selA;
 reg [2:0] I_selB;
 reg [2:0] I_selD;
 reg I_we;
 wire  [15:0] O_dataA;
 wire [15:0] O_dataB;
    
 reg_file reg_test(
         I_clk,
         I_en,
        I_we,
         I_selA,
          I_selB,
          I_selD,
          I_dataD,
        O_dataA,
        O_dataB
       );    
   initial begin
    I_clk=1'b0;
    I_dataD=0;
    I_en=0;
    I_selA=0;
    I_selB=0;
    I_selD=0;
    I_we=0;
    #7
    I_en=1'b1;
    I_selA=3'b000;
    I_selB=3'b001;
    I_selD=3'b000;
    
    I_dataD=16'hFFFF;
    I_we=1'b1;
    //time 17
    #10;
    I_we=1'b0;
    I_selD=3'b010;
    I_dataD=16'h2222;
    
    #10;
    I_we=1;
    #10;
    I_dataD=16'h3333;
    #10;
    I_we=0;
    I_selD=3'b000;
    I_dataD=16'hFEED;
    #10;
    I_selD=3'b100;
    I_dataD=16'h4444;
    #10;
    I_we=1;
    #50;
    I_selA=3'b100;
    I_selB=3'b100;
    #20;
    $finish;
    end
 always begin
 #5;
 I_clk=~I_clk;    
 end
endmodule
