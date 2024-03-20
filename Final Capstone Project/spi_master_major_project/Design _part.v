// Code your design here
module spi_master(ss,mosi,done,d_in,clk,rst);
  output reg ss,mosi,done;
  input [7:0]d_in;
  input clk,rst;
  reg [3:0] count;
  reg [1:0]state;
  parameter idle=0;
  parameter start=1;
  parameter finish=2;
  parameter next=3;
  always@(posedge clk)
    begin 
      if(rst)
        begin
          ss<=1'b0;
          mosi<=1'b0;
          done<=1'b0;
          count<=4'b1000;
          state<=2'b00;
        end
      else begin
        case(state)
          idle:begin
           ss<=1'b0;
           mosi<=1'b0;
           done<=1'b0;
           count<=4'b1000;
           state<=start;
          end
         start:begin
           ss<=1'b1;
           count<=d_in[count];
           if(count==4'b1111)
             begin
               mosi<=mosi;
               state<=finish;
             end
           else
             state<=start;
         end
          finish:begin
            ss<=1'b1;
            done<=1'b1;
            state<=next;
          end
          next:begin
            done<=1'b0;
          end
        endcase
      end
    end
endmodule
            