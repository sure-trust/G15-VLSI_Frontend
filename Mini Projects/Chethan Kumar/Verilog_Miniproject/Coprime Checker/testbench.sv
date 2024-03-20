`timescale 1ns / 1ps

module Coprime_Checker_tb;

    reg [31:0] num1, num2;
    wire coprime;

   
    Coprime_Checker uut(
        .num1(num1),
        .num2(num2),
        .coprime(coprime)
    );
  
    initial begin       
        num1 = 17; 
        num2 = 23; 
        #100; 
      $display("Test Case 1: num1 = %0d, num2 = %0d, Coprime = %0d", num1, num2, coprime);
      if(coprime)
        $display("------ Two Numbers are Coprime ------");
      else
        $display("two numbers are not coprime");
       #10 $finish;
    end

endmodule
