`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.11.2023 19:37:43
// Design Name: 
// Module Name: main_tb
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


module main_tb();

     reg clk;
     reg reset;
     reg ram_we=0;
     reg [15:0] dataI = 0;
     wire [2:0] selA;
     wire [2:0] selB;
     wire [2:0] selD;
     wire [15:0] dataA;     
     wire [15:0] dataB;
     wire [15:0] dataD;
     wire [4:0] aluop;
     wire [4:0] opcode;
     wire [7:0] imm;
     wire [15:0] dataO;
     wire [15:0] pcO;
     wire shldBranch;
     wire enfetech;
     wire enalu;
     wire endec;
     wire enmem;
     wire enrgrd;
     wire enrgwr;
     wire regwe;
     wire update;
     
     
     assign enrgwr= regwe & update;
     //assigning
     assign opcode = (reset)? 2'b11 : ((shldBranch) ?2'b10 :((enmem)?2'b01 : 2'b00));
     reg_file  main_reg(
         clk,
         enrgrd,
        enrgwr,
        selA,
        selB,
        selD,
        dataD,
        dataA,
        dataB
       );   
       
     inst_dec  main_inst(
       
        dataO,
        clk,
        endec,
          
           aluop,
           selA,
           selB,   
           selD,
           imm,
           regwe
           );
           
        alu  main_alu(
            clk,
            enalu,
            aluop,
            dataA,
            dataB,
            imm,
            dataD,
            shldBranch
            
              );
                            
       ctrl_unit  main_ctrl(
                 //inputs
                  clk,
                  reset,
                 //outputs
                  enfetech,
                  endec,
                  enrgrd,
                  enalu,
                  update,
                  enmem
                 );
                 
       pc_unit  pc_main(
                     clk,
                     opcode,
                     dataD,
                     pcO
                      );    
                      
                      
       fake_ram main_ram (
                          clk,
                          ram_we,
                          pcO,
                          dataI,
                          dataO
                          );                     
      
      
      initial begin 
       
       clk=0;
       reset=1;
       #20;
       reset=0;
       
      end
      always begin
      #5;
      clk=~clk;
      end
       
              
           
endmodule
