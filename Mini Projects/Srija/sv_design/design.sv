// Code your design here
// serial in parallel out register
module sipo(clk,rst,in,out);
  input clk, rst, in;
  output reg [7:0] out;
  reg [7:0]temp;
  always@(posedge clk, posedge rst)
    begin
      if (rst==1)
        out<=8'b000;
      else
        begin
          temp<=temp<<1;
          temp[0]<=in;
          out=temp;
          
        end
    end
endmodule