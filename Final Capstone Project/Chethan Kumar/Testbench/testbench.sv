`include "list.svh"

module tb;
  
  uart_if vif();

  uart_top dut (.clk(vif.clk), .rst(vif.rst), .tx_start(vif.tx_start), .rx_start(vif.rx_start), .tx_data(vif.tx_data), .baud(vif.baud), .length(vif.length), .parity_type(vif.parity_type), .parity_en(vif.parity_en),.stop2(vif.stop2),.tx_done(vif.tx_done), .rx_done(vif.rx_done), .tx_err(vif.tx_err), .rx_err(vif.rx_err), .rx_out(vif.rx_out));
  
  initial begin
    vif.clk <= 0;
  end

  always #10 vif.clk <= ~vif.clk;

  typedef enum bit [3:0]   {rand_baud_1_stop = 0, rand_length_1_stop = 1, length5wp = 2, length6wp = 3, length7wp = 4, length8wp = 5, length5wop = 6, length6wop = 7, length7wop = 8, length8wop = 9,rand_baud_2_stop = 11, rand_length_2_stop = 12} oper_mode;
  
  
  initial begin
    uvm_config_db#(virtual uart_if)::set(null, "*", "vif", vif);
    run_test("test");
   end
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

  
endmodule

class uart_config extends uvm_object; /////configuration of env
  `uvm_object_utils(uart_config)
  
  function new(string name = "uart_config");
    super.new(name);
  endfunction
  
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  
endclass

//////////////////////////////////////////////////////////

