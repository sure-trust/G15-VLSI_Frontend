`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.11.2023 18:44:18
// Design Name: 
// Module Name: decoder_unitest
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


module decoder_unitest();
  reg I_clk;
  reg I_en;
  reg [15:0] I_inst;
  wire [4:0] O_aluop;
  wire [3:0] O_selA;
  wire [3:0] O_selB;
  wire [3:0] O_selD;
  wire [15:0] O_imm;
  wire O_regwe;


 inst_dec  inst_unit(

     I_inst,
    I_clk,
    I_en,
   
     O_aluop,
    O_selA,
    O_selB,   
    O_selD,
    O_imm,
    O_regwe
    );
    
    initial begin
      I_clk <=0;
      I_en <=0;
      I_inst <=0;
       #10;
       I_inst=16'b0001011100000100;
       #10;
       I_en=1;
     end
     
     
     always begin
     #5;
     I_clk=~I_clk;
     end
endmodule
