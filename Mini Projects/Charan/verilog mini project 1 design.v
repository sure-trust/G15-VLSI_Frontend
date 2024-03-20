module can_tx(
    output reg tx,
    output reg txing,
    input rx,
    input[10:0] address,
    input clk,
    input rst,
    input [7:0] data,
    input send_data,
    input clear_to_tx
);
  
  assign rx_buf = rx;
  parameter idle = 8'h0, start_of_frame = 8'h1, addressing = 8'h2, rtr = 8'h3, ide = 8'h4,
  reserve_bit = 8'h5, num_of_bytes = 8'h6,data_out = 8'h7, ack = 8'h8, ack_delimiter = 8'h9,end_of_frame = 8'hA, waiting = 8'hB;
  
  parameter bytes = 5'd8;
  reg [10:0] address_count = 0;
  reg [7:0] c_state = 0, n_state = 0,data_bit_count = 0,eof_count = 0,data_byte_count = 0;
  initial txing = 0;
  
  always @ (posedge clk or posedge rst) begin
    if (rst == 1) begin
        c_state <= 32'd0;
        address_count <= 11'd0;
        eof_count <= 11'd0;
        data_bit_count <= 11'd0;
        data_byte_count <= 11'd0;
    end else begin
        c_state <= n_state;
    end
end
  
  always @ (posedge clk) begin
    case (c_state)
        idle: begin
            if (send_data && clear_to_tx) begin
                n_state <= start_of_frame;
            end else begin
                n_state <= idle;
            end
        end
        start_of_frame: begin
            if (!rx_buf) begin
                n_state <= addressing;
            end else begin
                n_state <= waiting;
            end
        end
        waiting: begin
            if (send_data && clear_to_tx) begin
                n_state <= start_of_frame;
            end else begin
                n_state <= waiting;
            end
        end
        addressing: begin
          if (address_count == 11'd10) begin
                n_state <= rtr;
            end
          else begin
                n_state <= addressing;
            end
      end
        rtr: begin
            n_state <= ide;
        end
        ide: begin
            n_state <= reserve_bit;
        end
        reserve_bit: begin
            n_state <= num_of_bytes;
        end
        num_of_bytes: begin
            if (data_byte_count == 11'd3) begin
                n_state <= data_out;
            end else begin
                n_state <= num_of_bytes;
            end
        end
        data_out: begin
            if (data_bit_count == 11'd63) begin
                n_state <= ack;
            end else begin
                n_state <= data_out;
            end
        end
     
        ack: begin
            n_state <= ack_delimiter;
        end
        ack_delimiter: begin
            n_state <= end_of_frame;
        end
        end_of_frame: begin
            if (eof_count == 11'd6) begin
                n_state <= idle;
            end else begin
                n_state <= end_of_frame;
            end
        end
        default: begin
            n_state <= idle;
        end
    endcase
end
  
  always @* begin
    case (c_state)
        idle: begin
            tx <= 1;
            txing <= 1'b0;
        end
        addressing: begin
            tx <= address[11'd10 - address_count];
            txing <= 1'b1;
        end
        start_of_frame: begin
            tx <= 0;
            txing <= 1'b1;
        end
        rtr, ide, reserve_bit, ack, ack_delimiter, end_of_frame: begin
            tx <= 1;
            txing <= 1'b1;
        end
        num_of_bytes: begin
          tx <= bytes[8'd3 - data_byte_count];
          txing <= 1'b1;
        end
        data_out: begin
          tx <= data[8'd7 - data_bit_count];
          txing <= 1'b1;
        end
        default: begin
            tx <= 1;
            txing <= 1'b1;
        end
    endcase
end
  
  // Counting Logic
  
  always @ (posedge clk) begin
    case (c_state)
        idle, waiting, start_of_frame: begin
            address_count <= 11'd0;
            eof_count <= 11'd0;
            data_bit_count <= 11'd0;
            data_byte_count <= 11'd0;
        end
        addressing: begin
            address_count <= address_count + 1'b1;
        end
        num_of_bytes: begin
            data_byte_count <= data_byte_count + 1'b1;
        end
        data_out: begin
            data_bit_count <= data_bit_count + 1'b1;
        end
        
        end_of_frame: begin
            eof_count <= eof_count + 1'b1;
        end
        
    endcase
end

endmodule
