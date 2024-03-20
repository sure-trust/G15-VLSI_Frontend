// Code your testbench here
// or browse Examples
module alu_tb;
  // Inputs
  reg [31:0] A;
  reg [31:0] B;
  reg [3:0] sel;
  // Outputs
  wire [63:0] Yout;
  // Instantiate the Unit Under Test (UUT)
  ALU uut (.A(A), 
           .B(B), 
           .sel(sel), 
           .Yout(Yout));
  initial begin
		// Initialize Inputs
    repeat(2)
		begin
          A = 32'h0000_0010;
          B = 32'h0000_0008;
          #2 sel = 4'b0000;
          #2 sel = 4'b0001;
          #2 sel = 4'b0010;
          #2 sel = 4'b0011;
          #2 sel = 4'b0100;
          #2 sel = 4'b0101;
          #2 sel = 4'b0110;
          #2 sel = 4'b0111;
          #2 sel = 4'b1000;
          #2 sel = 4'b1001;
          #2 sel = 4'b1010;
          #2 sel = 4'b1011;
          #2 sel = 4'b1100;
          #2 sel = 4'b1101;
          #2 sel = 4'b1110;
          #2 sel = 4'b1111;
          $monitor("A=%d   B=%d :---> Sel=%b :: Yout=%b",A,B,sel,Yout);
        end
          #40 $finish() ;
        end
    
    initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
      
endmodule

