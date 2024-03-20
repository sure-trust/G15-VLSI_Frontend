`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2024 13:15:03
// Design Name: 
// Module Name: spi_slave
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module spi_slave (
input sclk, mosi,cs,
output [7:0] dout,
output reg done 
);

integer count = 0;
parameter idle=2'b00;
    parameter sample=2'b01;
   
    reg [1:0]state; 
reg [7:0] data = 0;

  
always@(negedge sclk)
begin
case (state)

idle: begin
done <= 1'b0;

if(cs == 1'b0)
state <= sample;
else
state <= idle;
end

sample: 
begin
        if(count < 8)
        begin
        count <= count + 1;
        data <= {data[6:0],mosi};
        state <= sample;
        end
        else
        begin
        count <= 0;
        state <= idle;
        done  <= 1'b1;
        end
end

default : state <= idle;
endcase

end

assign dout = data;

endmodule

