// Code your design here
module can_tx(
	output reg tx,
	output reg can_bitstuff,
	output reg txing,
	input rx,
	input[10:0] address,
	input clk,
	input baud_clk,
	input rst,
    input [7:0] data,
	input send_data,
	input bitstuffed_output,
	input clear_to_tx
	);
	
	
	assign rx_buf = rx;
	parameter all_ones = 15'b111111111111111;
	parameter idle = 8'h0,  start_of_frame = 8'h1, addressing =8'h2 ,rtr = 8'h3 ,ide = 8'h4, reserve_bit = 8'h5, num_of_bytes = 8'h6,
			data_out = 8'h7, crc_out = 8'h8, crc_delimiter = 8'h9 , ack = 8'hA, ack_delimiter =  8'hB, end_of_frame = 8'hC, waiting = 8'hD;

	parameter bytes = 5'd8;
	reg[10:0] address_count = 0, crc_count = 0, eof_count = 0 , data_bit_count = 0, data_byte_count = 0;
	reg[7:0] c_state=0, n_state=0;
	initial txing = 0;
	
	reg[14:0] crc_output, crc_holder;
	wire one_shotted_send;
	wire[14:0] crc_buff;
  
  CRC cyclic_red_check(data, one_shotted_send, crc_buff,rst,clk);//caliing crc module
	
  OneShot os(send_data, clk, rst, one_shotted_send);//calling one shot pulse module

	always @(crc_buff or crc_holder) begin
		if(crc_buff != all_ones) 
			crc_output <= crc_buff;
		else
			crc_output <= crc_holder;
	end
	
	always @ (posedge clk or posedge rst) begin
		if(rst == 1) begin
			crc_holder <= 15'd0;
		end
		else begin
			crc_holder <= crc_output;
		end
	end
	
	//Update Logic
	always @ (posedge baud_clk or posedge rst) begin
		if(rst == 1) begin
			c_state <= 32'd0;
		end
		else begin
			c_state <= n_state;
		end
	end

	//Counting Logic
	always @ (posedge baud_clk) begin
		case(c_state) 
			idle: begin
				address_count <= 11'd0;
				data_bit_count<= 11'd0;
				data_byte_count<= 11'd0;
				crc_count <= 11'd0; 
				eof_count <= 11'd0;
			end
			waiting: begin
				address_count <= 11'd0;
				data_bit_count<= 11'd0;
				data_byte_count<= 11'd0;
				crc_count <= 11'd0; 
				eof_count <= 11'd0;
			end
			start_of_frame:begin
				address_count <= 11'd0;
				data_bit_count<= 11'd0;
				data_byte_count<= 11'd0;
				crc_count <= 11'd0; 
				eof_count <= 11'd0;
			end
			addressing: begin
				address_count <= address_count + 1'b1;
				data_bit_count<= 11'd0;
				data_byte_count<= 11'd0;
				crc_count <= 11'd0; 
				eof_count <= 11'd0;
			end
			rtr: begin
				address_count <= 11'd0;
				data_bit_count<= 11'd0;
				data_byte_count<= 11'd0;
				crc_count <= 11'd0; 
				eof_count <= 11'd0;
			end
			ide: begin
				address_count <= 11'd0;
				data_bit_count<= 11'd0;
				data_byte_count<= 11'd0;
				crc_count <= 11'd0; 
				eof_count <= 11'd0;
			end
			reserve_bit: begin
				address_count <= 11'd0;
				data_bit_count<= 11'd0;
				data_byte_count<= 11'd0;
				crc_count <= 11'd0; 
				eof_count <= 11'd0;
			end
			num_of_bytes: begin
				address_count <= 11'd0;
				data_bit_count<= 11'd0;
				data_byte_count<= data_byte_count +1'b1;
				crc_count <= 11'd0; 
				eof_count <= 11'd0;
			end
			data_out: begin
				address_count <= 11'd0;
				data_bit_count<= data_bit_count +1'b1;
				data_byte_count<= 11'd0;
				crc_count <= 11'd0; 
				eof_count <= 11'd0;
			end
			crc_out: begin
				address_count <= 11'd0;
				data_bit_count<= 11'd0;
				data_byte_count<= 11'd0;
				crc_count <= crc_count + 1'b1; 
				eof_count <= 11'd0;
			end
			crc_delimiter: begin
				address_count <= 11'd0;
				data_bit_count<= 11'd0;
				data_byte_count<= 11'd0;
				crc_count <= 11'd0; 
				eof_count <= 11'd0;
			end
			ack: begin
				address_count <= 11'd0;
				data_bit_count<= 11'd0;
				data_byte_count<= 11'd0;
				crc_count <= 11'd0; 
				eof_count <= 11'd0;
			end
			ack_delimiter:begin
				address_count <= 11'd0;
				data_bit_count<= 11'd0;
				data_byte_count<= 11'd0;
				crc_count <= 11'd0; 
				eof_count <= 11'd0;
			end
			end_of_frame: begin
				address_count <= 11'd0;
				data_bit_count<= 11'd0;
				data_byte_count<= 11'd0;
				crc_count <= 11'd0; 
				eof_count <= eof_count +1'b1;
			end
			default: begin
				address_count <= 11'd0;
				data_bit_count<= 11'd0;
				data_byte_count<= 11'd0;
				crc_count <= 11'd0; 
				eof_count <= 11'd0;
			end
		endcase
	end

	//Next State Logic
	always @ (c_state or rx_buf or data or send_data or address_count or bitstuffed_output or data_byte_count
		or data_bit_count or crc_count or eof_count or clear_to_tx or crc_output) begin
		case(c_state)
			idle: begin
				if(send_data && clear_to_tx) begin
					n_state <= start_of_frame;
				end
				else begin
					n_state <= idle;
				end
			end
			start_of_frame: begin
				if(!rx_buf) begin
					n_state <= addressing;
				end
				else begin
					n_state <= waiting;
				end
			end
			waiting: begin
				if(send_data && clear_to_tx) begin
					n_state <= start_of_frame;
				end
				else begin
					n_state <= waiting;
				end
			end
			addressing: begin
				if(rx_buf != bitstuffed_output) begin
					n_state <= waiting; //Lost Arbitration
				end
				else if(address_count == 11'd10) begin
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
				if(data_byte_count == 11'd3) begin
					n_state <= data_out;
				end
				else begin
					n_state <= num_of_bytes;
				end
			end
			data_out: begin
				if(data_bit_count == 11'd63) begin
					n_state <= crc_out;
				end
				else begin
					n_state <= data_out;
				end
			end
			crc_out: begin
				if(crc_count == 11'd14) begin
					n_state <= crc_delimiter;
				end
				else begin
					n_state <= crc_out;
				end
			end
			crc_delimiter: begin
				n_state <= ack;
			end
			ack: begin
				n_state <= ack_delimiter;
			end
			ack_delimiter: begin
				n_state <= end_of_frame;
			end
			end_of_frame: begin
				if(eof_count == 11'd6) begin
					n_state <= idle;
				end
				else begin
					n_state <= end_of_frame;
				end
			end
			default:
			begin
				n_state <= idle;
			end
		endcase
	end

	//Output Logic
	always @(c_state or address or data or crc_output or crc_count or data_byte_count or data_bit_count or address_count) begin
		case(c_state) 
			idle: begin
				tx <= 1;
				can_bitstuff <= 0;
				txing <= 1'b0;
			end
			addressing: begin
				tx <= address[11'd10-address_count];
				can_bitstuff <= 1;
				txing <= 1'b1;
			end
			start_of_frame: begin
				tx<= 0;
				can_bitstuff <= 1'b0;
				txing <= 1'b1;
			end
			rtr: begin
				tx <= 0;
				can_bitstuff <= 1;
				txing <= 1'b1;
			end
			ide: begin
				tx <= 0;
				can_bitstuff <= 1;
				txing <= 1'b1;
			end
			reserve_bit: begin
				tx <= 0;
				can_bitstuff <= 1;
				txing <= 1'b1;
			end
			num_of_bytes: begin
				tx <= bytes[11'd3-data_byte_count];
				can_bitstuff <= 1;
				txing <= 1'b1;
			end
			data_out: begin
				tx <= data[11'd63-data_bit_count];
				can_bitstuff <= 1;
				txing <= 1'b1;
			end
			crc_out: begin
				tx <= crc_output[11'd14-crc_count];
				can_bitstuff <= 1;
				txing <= 1'b1;
			end
			crc_delimiter: begin
				tx <= 1;
				can_bitstuff <= 0;
				txing <= 1'b1;
			end
			ack: begin
				tx <= 1;
				can_bitstuff <= 0;
				txing <= 1'b1;
			end
			ack_delimiter:begin
				tx <= 1;
				can_bitstuff <= 0;
				txing <= 1'b1;
			end
			end_of_frame: begin
				tx <= 1;
				can_bitstuff <= 0;
				txing <= 1'b1;
			end
			waiting: begin
				tx <= 1;
				can_bitstuff <= 0;
				txing <= 1'b0;
			end
			default: begin
				tx <= 1;
				can_bitstuff <= 0;
				txing <= 1'b1;
			end
		endcase
	end

endmodule

module CRC (
    input wire [7:0] data_in,
  input wire crc_en,
  output reg [4:0] crc_out,
    input wire reset,
    input wire clk
    
);

// Define the CRC polynomial (example polynomial: x^5 + x^2 + 1)
parameter POLYNOMIAL = 5'b101101;

// Internal signals
reg [4:0] crc_reg;
reg [7:0] shift_reg;

always @(posedge clk) begin
    if (reset) begin
        crc_reg <= 5'b0; // Initialize CRC register
        shift_reg <= 8'b0; // Initialize shift register
    end else begin
        shift_reg <= {shift_reg[6:0], data_in}; // Shift in new data
        if (crc_reg[4]) begin
            crc_reg <= crc_reg ^ POLYNOMIAL; // XOR with polynomial if MSB is 1
        end
        crc_reg <= {crc_reg[3:0], crc_reg[4]}; // Shift left by one bit
    end
end

assign crc_out = crc_reg;

endmodule




module OneShot(
    input pulse,
    input clk,
    input rst,
    output reg out
    );
initial out = 0;
parameter waiting_l = 2'b00, on = 2'b01, waiting_h = 2'b10;
reg[1:0] next_state, current_state;

always @ (posedge clk or posedge rst) begin
	if(rst) begin
		current_state <= waiting_l;
	end
	else begin
		current_state <= next_state;
	end
end

always @ (current_state or pulse) begin
	if(current_state == on) begin
		next_state <= waiting_h;
	end
	else if(current_state == waiting_h) begin
		if(pulse) begin
			next_state <= waiting_h;
		end
		else begin
			next_state <= waiting_l;
		end
	end
	else if(pulse) begin
		next_state<= on;
	end
	else begin
		next_state<= waiting_l;
	end
end

always @(current_state or rst) begin
	if(rst)
		out <= 1'b0;
	else if(current_state == on)
		out <= 1'b1;
	else 
		out <= 1'b0;
end

endmodule
