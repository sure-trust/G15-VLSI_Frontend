`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.11.2023 16:18:45
// Design Name: 
// Module Name: reg_file
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


module reg_file(
     input I_clk,
     input I_en,
     input I_we,
     input [2:0] I_selA,
     input [2:0] I_selB,
     input [2:0] I_selD,
     input [15:0] I_dataD,
     output reg [15:0] O_dataA,
      output reg [15:0] O_dataB
    );
    
    reg [15:0] regs [7:0];
    //loop variable
    integer count;
    wire [1:0] val=I_dataD[0];
    
    initial begin
       O_dataA<=0;
       O_dataB<=0;
      
      for (count=0;count<8;count=count+1)
      begin
         regs[count] <=0;
        end
     end
     always@(negedge I_clk) begin
           if(I_en) begin
              if(I_we)
            if(val) begin
              regs[I_selD] <=I_dataD;
               O_dataA <=regs[I_selA];
               O_dataB <=regs[I_selB];
              end
              else begin
               O_dataA <=I_selA;
               O_dataB <=I_selB;
              end
              end
         end
endmodule
