interface intf(input clk,rst);
  logic rd_en;
  logic wr_en;
  logic [7:0] din;
  logic full;
  logic empty;
  logic [7:0] dout;
  logic [3:0] count;
  logic [7:0] fifo_mem[7:0];
  logic [2:0] wr_ptr;
  logic [2:0] rd_ptr;
  
  clocking driv_cb@(posedge clk);
    output rd_en;
    output wr_en;
    output din;
    input full,empty ;
    input dout;
    input count;
    input fifo_mem;
    input wr_ptr;
    input rd_ptr;
  endclocking
  
  clocking mon_cb@(posedge clk);
    input rd_en;
    input wr_en;
    input din;
    input full,empty;
    input dout;
    input count;
    input fifo_mem;
    input wr_ptr;
    input rd_ptr;
  endclocking
    
endinterface