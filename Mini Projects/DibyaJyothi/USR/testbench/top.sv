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
USR d1(.clk(pif.clk),.rst(pif.rst),.ctrl(pif.ctrl),.d(pif.d),.q(pif.q));
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
