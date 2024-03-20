
////////////////////////////////////////////////////////////////////////////

module Multiplier3bit(
  input wire [2:0] a1,
  input wire [2:0] b1, 
  output reg [5:0] y1  
);
  reg [5:0] y1_pro;
  initial begin 
    y1_pro=0;
    y1=0;
  end
  always @(a1 or b1) begin
    for (int i = 0; i < 3; i = i + 1) begin
      y1_pro = y1_pro + (a1[i]*(b1<<i));
    end 
    y1 = y1_pro;
  end
endmodule


TESET BENCH

module testbench;

  reg [2:0] a1, b1;
  wire [5:0] y1;

  Multiplier3bit  uut(
    .a1(a1),
    .b1(b1),
    .y1(y1)
  );

  initial begin
    $dumpfile("dump.vcd"); $dumpvars(1);
    a1 = 3'b101;
    b1 = 3'b011;
    $display("a1=%b b1=%b y1=%b", a1, b1, y1);

    a1 = 3'b110;
    b1 = 3'b010;
    $display("a1=%b b1=%b y1=%b", a1, b1, y1);

    #100 $finish();
  end

endmodule
