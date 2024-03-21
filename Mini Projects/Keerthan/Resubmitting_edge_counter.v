/////////////////////////////////RISING AND FALLING EDGE COUNTER/////////////////////////////////
//CODE
module edge_counter(
  input wire clk,
  output reg [7:0] pos,
  output reg [7:0] neg
);

  reg ss;
  initial 
    begin
    pos<=0;
    neg<=0;
  end
  always @(posedge clk) begin
    if(ss==0)
      pos <= pos + 1;
    ss=1;
  end

  always @(negedge clk) begin
    if(ss==1)
      neg <= neg + 1;
    ss=0;
  end

endmodule
/// TEST BENCH


module edge_counter_tb;

  reg clk;
  wire [7:0] pos;
  wire [7:0] neg;
  
  edge_counter uut (
    .clk(clk),
    .pos(pos),
    .neg(neg)
  );

  initial begin
    clk=0;
    $monitor("clk=%b pos_count=%d neg_count=%d", clk, pos, neg);
    repeat (100) #5 clk = ~clk;
    $finish();
  end

endmodule
