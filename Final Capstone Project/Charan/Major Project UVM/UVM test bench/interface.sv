interface intf();
  
  logic clk,rst,wr;
  logic [6:0] addr;
  logic [7:0] din;
  logic  [7:0] datard;
  logic done;
  
  clocking driv_cb@(posedge clk);
    output addr;
    output din;
    output wr;
    input datard;
    input done;
  endclocking
  
  clocking mon_cb@(posedge clk);
    input addr;
    input din;
    input wr;
    input datard;
    input done;
  endclocking
      
endinterface