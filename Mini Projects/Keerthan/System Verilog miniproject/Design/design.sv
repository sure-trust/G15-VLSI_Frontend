// Code your design here
module sram(

input clk, rst, wr_en,

  input [4:0] data_input, address,

  output reg [4:0] data_out

);

  reg [4:0] memory [32];

integer i;

  always @(posedge clk or posedge rst) begin

if(rst) begin

  for(i = 0; i <32; i++) begin

memory[i] = 0;

end

end

  else if(wr_en) begin

    memory[address] = data_input;
  #10;

end


  else begin

    data_out = memory[address];
    #10;

end

end

endmodule