// Code your design here
module async_fifo(
input clk, 
input rst, 
input rd, 
input wr, 
input [7:0] din,
output empty,
output full, 
output reg [7:0] dout,
output reg [3:0] fifo_cnt,
output reg [7:0] fifo_mem [0:7],
output reg [2:0] rd_ptr, wr_ptr
);



assign empty = (fifo_cnt == 0);
assign full = (fifo_cnt == 8);

always @(posedge clk or posedge rst) begin
  if (rst) begin
    rd_ptr <= 0;
    wr_ptr <= 0;
    fifo_cnt <= 0;
  end
  else begin
    if (rd && !empty) begin  //Read operation
    dout <= fifo_mem[rd_ptr];
    rd_ptr <= (rd_ptr == 7) ? 0 : rd_ptr + 1;
    fifo_cnt <= fifo_cnt - 1;
  end

  //Write operation
  if (wr && !full) begin
    fifo_mem[wr_ptr] <= din;
    wr_ptr <= (wr_ptr == 7) ? 0 : wr_ptr + 1;
    fifo_cnt <= fifo_cnt + 1;
  end
end
end

endmodule