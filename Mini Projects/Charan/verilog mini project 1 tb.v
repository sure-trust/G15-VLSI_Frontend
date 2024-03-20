module tb_can_tx;
  reg clk, rst;
  reg rx, send_data,clear_to_tx;
  reg [10:0] address;
  reg [7:0] data;
  wire tx, txing;

  
  can_tx dut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .address(address),
    .data(data),
    .send_data(send_data),
    .clear_to_tx(clear_to_tx),
    .tx(tx),
    .txing(txing)
  );

 

  // Clock generation
  always #5 clk = ~clk;

  // Stimulus generation
  initial begin
    clk = 0;
    rst = 1;
    rx = 0;
    send_data = 0;
    clear_to_tx = 0;
    address = 11'b0;
    data = 8'b0;

    #10 rst = 0;  
   
    #20 begin
      rx = 1;
      address = 11'b10101010111; 
      data = 8'b11001100;
      send_data = 1;
      clear_to_tx = 1;
    end
     begin
      #40
      rx = 1;
      address = 11'b10101010101; 
      data = 8'b11001111; 
      send_data = 1;
      clear_to_tx = 1;
     end

    #100 $finish; 
  end

 
  always @(posedge clk) begin
    $display("Time = %0t: tx = %b,txing=%0b,send_data = %0b, rx = %0b, address = %0b, data = %0b,clear_to_tx = %0b", $time, tx,txing,send_data, rx, address, data,clear_to_tx);
  end

 
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end

endmodule
