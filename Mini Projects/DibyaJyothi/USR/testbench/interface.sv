interface intf(input clk,rst);
logic [7:0]d;
logic [1:0]ctrl;
logic [7:0]q;
logic [7:0] r_reg,r_next;
clocking driv_cb@(posedge clk);
output d;
output ctrl; 
input q;
endclocking
clocking mon_cb@(posedge clk);
input ctrl;
input d;
output q;
endclocking
endinterface