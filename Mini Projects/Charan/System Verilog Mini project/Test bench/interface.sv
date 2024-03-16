interface intf(input clk,rst);
  logic rd;
  logic wr;
  logic [7:0] din;
  logic full;
  logic empty;
  logic [7:0] dout;
  logic [3:0] fifo_cnt;
  logic [7:0] fifo_mem[7:0];
  logic [2:0] wr_ptr;
  logic [2:0] rd_ptr;
  
  clocking driv_cb@(posedge clk);
    output rd;
    output wr;
    output din;
    input full,empty ;
    input dout;
    input fifo_cnt;
    input fifo_mem;
    input wr_ptr;
    input rd_ptr;
  endclocking
  
  clocking mon_cb@(posedge clk);
    input rd;
    input wr;
    input din;
    input full,empty;
    input dout;
    input fifo_cnt;
    input fifo_mem;
    input wr_ptr;
    input rd_ptr;
  endclocking
    
endinterface
