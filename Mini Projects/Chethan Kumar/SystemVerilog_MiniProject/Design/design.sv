module fifo(rst,clk,rd_en,wr_en,din,full,empty,dout,count,fifo_mem,wr_ptr,rd_ptr);
  
  //input and output port declaration
  input rst,clk,rd_en,wr_en;
  input [7:0] din;
  output full,empty;
  output reg [7:0] dout;
  output reg [3:0] count;
  output reg [7:0] fifo_mem[7:0];
  output reg [2:0] wr_ptr,rd_ptr;
  
  //Flags to  check if FIFO is FULL or EMPTY
  assign empty=(count==0);
  assign full=(count==8);
  
  // Write operation
  // write opearation is done when wr_en is High and FIFO is not FULL
  always@(posedge clk) begin
    if(wr_en && !(full)) begin
      fifo_mem[wr_ptr]<=din;
      wr_ptr<=wr_ptr+1;
      count<=count+1;
    end
  end
  
  //Read operation
  // Read operation id performed when rd_en is HIGH and FIFO is Not Empty
  always@(posedge clk)begin
    if(rd_en && !(empty) )begin
      dout<=fifo_mem[rd_ptr];
      rd_ptr<=rd_ptr+1;
      count<=count-1;
      
    end
  end
  
  //pointer
  always@(posedge clk or posedge rst) begin
    if(rst) begin
      wr_ptr<=0;
      rd_ptr<=0;
    end
  end
  
  //counter
  always@(posedge clk or posedge rst) begin
    if(rst) begin
      count<=0;
      dout<=0;
    end
    
  end
endmodule