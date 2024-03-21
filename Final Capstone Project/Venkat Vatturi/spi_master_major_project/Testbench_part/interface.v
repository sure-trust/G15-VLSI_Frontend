interface intf(input clk,rst);
logic [7:0]d_in;
logic ss;
logic mosi;
logic done;
reg state;
clocking driv_cb@(posedge clk);
output d_in; 
input ss;
input mosi;
input done;
endclocking
clocking mon_cb@(posedge clk);
output d_in;
input ss;
input mosi;
input done;
endclocking
endinterface