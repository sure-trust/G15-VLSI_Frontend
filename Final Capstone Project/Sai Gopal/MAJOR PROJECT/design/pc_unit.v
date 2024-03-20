`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.11.2023 16:09:22
// Design Name: 
// Module Name: pc_unit
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


module pc_unit(
   input I_clk,
   input [1:0] I_opcode,
   input [15:0] I_pc,
   output reg [15:0] O_pc

    );
    
    initial begin
      O_pc <=0;
    end
    
    always@(negedge I_clk) begin
        case(I_opcode) 
        2'b00:O_pc <=O_pc;
        2'b01:O_pc <=O_pc +1;
        2'b10:O_pc <=I_pc;
        2'b11:O_pc <=0;
        endcase
    end
      
endmodule
