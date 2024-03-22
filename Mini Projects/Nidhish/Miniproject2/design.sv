// Code your design here
module memory
  #(  
  parameter ADDR_WIDTH = 2,
  parameter DATA_WIDTH = 8
  )
  (
    input clk,
    input reset,
    
    input [ADDR_WIDTH-1:0]  addr,
    input                   wr_en,
    input                   rd_en,
    
    input  [DATA_WIDTH-1:0] wdata,
    output [DATA_WIDTH-1:0] rdata
  ); 
  
  reg [DATA_WIDTH-1:0] rdata;
  
  
  reg [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH];

  always @(posedge reset) 
    for(int i=0;i<2**ADDR_WIDTH;i++) mem[i]=8'hFF;
   
  always @(posedge clk)
    begin
    if (wr_en)   
      mem[addr] <= wdata;
    end
  always @(posedge clk)
    
    begin
    if (rd_en)
      rdata <= mem[addr];
    end
  
endmodule
