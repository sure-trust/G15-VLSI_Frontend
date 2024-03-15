interface intf(input clk,rst);
  logic in;
  logic out;
  clocking driv_cb@(posedge clk);
    output in;
    input out;
  endclocking
  
  clocking mon_cb@(posedge clk);
    input in;
    input out;
  endclocking
endinterface
