interface counter_intf();
logic clk,rst, wr_en;
  logic [4:0] data_input, address;
  logic [4:0] data_out;
  
  clocking drv_cb@(posedge clk);
    output data_input;
    output address;
    input data_out;
  endclocking
  
  clocking mon_cb@(posedge clk);
    input data_input;
    input address;
    input data_out;
  endclocking
endinterface