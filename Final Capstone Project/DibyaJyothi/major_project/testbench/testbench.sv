// Code your testbench here
// or browse Examples
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "interface.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"
module testbench();
bit clk,rst;
test tb;
intf pif(clk,rst);
wishbone d1(.clk(pif.clk),.rst(pif.rst),.we(pif.we),.strb(pif.strb),.addr(pif.addr),.wdata(pif.wdata),.rdata(pif.rdata),.ack(pif.ack));
always #1clk=~clk;
initial begin
rst=1;
#5 rst=0;
end
initial begin

$display("display from top");
  tb=new(pif);
tb.main();
end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
    #20 $finish();
  end
endmodule