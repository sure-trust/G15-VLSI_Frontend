/////////////////Even Priority encoder/////////////////////////
//code
module even_pri_enc(input [3:0] i,output reg [1:0] out);

  always @* begin
    case(i)	
      4'b0000: out = 2'b00;
      4'b0010: out = 2'b01;
      4'b0011: out = 2'b01;
      4'b0100: out = 2'b10;
      4'b0101: out = 2'b10;
      4'b0110: out = 2'b10;
      4'b0111: out = 2'b10;
      4'b1000: out = 2'b11;
      default: out = 2'b11;
    endcase
  end

endmodule

//Test Bench
// Code your testbench here
// or browse Examples
module tb;
  reg [3:0] i;
  wire [1:0] out;

  even_pri_enc uut (.i(i),.out(out));

  initial begin
    $monitor("Time=%0t in_data=%b out=%b", $time, i, out);
    i = 4'b0000; #10;
    i = 4'b0010; #10;
    i = 4'b0100; #10;
    i = 4'b1000; #10;
    i = 4'b1111; #10;
    $finish;
  end

endmodule
