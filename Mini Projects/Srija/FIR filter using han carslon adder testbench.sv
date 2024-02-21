// Code your testbench here
// or browse Examples
// miniproject testbench
module FIR_HCA_TB;

	// Inputs
	reg clk=0;
	reg reset=1;
	reg [7:0] filter_in;

	// Outputs
	wire [15:0] filter_out;
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end

	// Instantiate the Unit Under Test (UUT)
  FIR_using_HCA uut (.filter_out(filter_out), .clk(clk), .reset(reset),.filter_in(filter_in));

always #5 clk = ! clk ;
	initial 
	begin
	#10	reset = 0;
	
	filter_in = 8'b 10110110;
      $monitor("time=%0d filter_out=%d clk=%d reset=%d filter_in=%d",$time,filter_out,clk,reset,filter_in);


      #50 $finish();

	end
      
endmodule
