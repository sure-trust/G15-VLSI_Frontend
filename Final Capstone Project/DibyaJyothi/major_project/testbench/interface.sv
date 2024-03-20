interface intf(input clk,rst);
    //logic clk;
    logic we;
    logic strb;
    //logic rst;
    logic [7:0] addr;
    logic [7:0] wdata;
    logic [7:0] rdata;
    logic  ack;
clocking driv_cb@(posedge clk);
output we,strb;
output addr;
output wdata; 
input  rdata;
input ack ;
endclocking
clocking mon_cb@(posedge clk);
input we,strb;
input  addr;
input  wdata;
output rdata;
output ack;
endclocking
endinterface