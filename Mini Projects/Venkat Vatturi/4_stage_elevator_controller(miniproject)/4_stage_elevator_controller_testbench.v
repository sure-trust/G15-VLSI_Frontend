`timescale 1ns / 1ps
module elevator_4stage_tb();
reg clk;
reg rst;
reg rgnd, r1st, r2nd ,r3rd,r4th;
wire[2:0] floor;
wire[2:0] state;
wire [1:0]dir;
parameter groundfloor=0,firstfloor=1,secondfloor=2,thirdfloor=3,fouthfloor=4;
parameter up=0,down=1;
elevator_4stage dut(
.clk(clk),
.rst(rst),
.rgnd(rgnd),
.r1st(r1st),
.r2nd(r2nd),
.r3rd(r3rd),
.r4th(r4th),
.floor(floor),
.dir(dir),
.state(state)
);
initial begin
clk=0;
forever #5clk=~clk;
end
initial begin
rst=1'b1;
#10
rst=1'b0;
rgnd=1'b1;
r1st=1'b0;
r2nd=1'b0;
r3rd=1'b0;
r4th=1'b0;
#100
rgnd=1'b0;
r1st=1'b1;
r2nd=1'b0;
r3rd=1'b0;
r4th=1'b0;
#100
rgnd=1'b0;
r1st=1'b0;
r2nd=1'b1;
r3rd=1'b0;
r4th=1'b0;
#100
rgnd=1'b0;
r1st=1'b0;
r2nd=1'b0;
r3rd=1'b1;
r4th=1'b0;
#100
rgnd=1'b0;
r1st=1'b0;
r2nd=1'b0;
r3rd=1'b0;
r4th=1'b1;
#100
rgnd=1'b0;
r1st=1'b1;
r2nd=1'b0;
r3rd=1'b1;
r4th=1'b0;
#100
rgnd=1'b1;
r1st=1'b0;
r2nd=1'b1;
r3rd=1'b0;
r4th=1'b0;
#100
rgnd=1'b0;
r1st=1'b1;
r2nd=1'b0;
r3rd=1'b1;
r4th=1'b0;
end
endmodule