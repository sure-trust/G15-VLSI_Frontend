
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////Counter
// Code your design here
module counter (
  input rst,
  input clk,
  output reg en,
  output reg [3:0] up,
  output reg [3:0] dn
);

  initial begin
    up <= 4'b0000;
    dn <= 4'b1111;
    en <= 1'b0;
  end

  always @(posedge rst or posedge clk) begin
    if (rst) begin
      up <= 4'b0000;
      dn <= 4'b1111;
      en <= 1'b0;
    end
    else begin
      up <= up + 1;
      if (up == 4'b1100) begin
        en <= 1;
      end
      else begin
        en <= 0;
      end
    end
  end 

  always @(posedge en) begin
    dn <= dn - 1;
  end

endmodule

////////////////TEST BENCH

module top;
  reg clk, rst;
  reg en;
  reg [3:0] up, dn;
  integer count = 0; 
  integer start_time, end_time;
  real frequency;
  counter uut (.rst(rst), .clk(clk), .en(en), .up(up), .dn(dn));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0; 
    $dumpfile("dump.vcd"); $dumpvars;
    $monitor(" up=%b, dn=%b, en=%b frequency=%f", up, dn, en, frequency);
  end

  always @(posedge en) begin
    if (!count) begin
      start_time = $time;
      count = count + 1;
    end
    else begin 
      end_time = $time;
      frequency = 1 / (($time - start_time) * 1e-9); 
      count = 0;
    end
  end
  initial #500 $finish;
  
endmodule//////////////
