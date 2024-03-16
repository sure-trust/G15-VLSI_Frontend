module USR(clk,rst,ctrl,d,q);
input wire clk,rst;
input wire [1:0]ctrl;
input wire [7:0] d;
output wire [7:0]q;
reg [7:0] r_reg,r_next;
always@(posedge clk,posedge rst)
if(rst)
r_reg<=0;
else
r_reg<=r_next;
always@*
case(ctrl)
2'b00:r_next=r_reg;
2'b01:r_next={r_reg[6:0],d[0]};
2'b10:r_next={d[7],r_reg[7:1]};
default:r_next=d;
endcase
assign q=r_reg;
endmodule
