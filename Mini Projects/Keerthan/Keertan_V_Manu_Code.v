module password_RAM_ROM (
    input wire clk,
    input wire rst,
    input wire [7:0] password_input,
    input wire [7:0] data_input,
    input wire write_enable,
    input wire read_enable,
    output reg [7:0] data_output
);

  // Parameters
  parameter [7:0] RAM_PASSWORD = 8'h1x111111;//ff or bf 
  parameter [7:0] ROM_PASSWORD = 8'h0x111110;//7e or 3e 
  parameter Ram_file = "ram_file.txt"; 
  parameter Rom_file = "rom_file.txt";

    // Internal signals
    reg [7:0] password_buffer;
    reg [2:0] state;
  reg [4:0] file_handle; // file handle variable that stores the name of file
    reg file_open;

    // RAM and ROM storage
    reg [7:0] ram_data;
    reg [7:0] rom_data;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 3'b000;
            password_buffer <= 8'b0;
            file_handle <= 5'b0; // Initialize file handle
            file_open <= 1'b0;
            data_output <= 8'b0; // Clear data_output on reset
        end else begin
            case (state)
                3'b000: begin // Idle state
                    if (password_input[7] == 1'b1) begin
                        state <= 3'b001; // RAM mode
                    end else if (password_input[7] == 1'b0) begin
                        state <= 3'b010; // ROM mode
                    end
                end
                3'b001: begin // RAM Editing/Reading state
                    if (password_input[6] == 1'b1) begin
                        state <= 3'b011; // RAM Reading mode
                    end else begin
                        password_buffer <= password_input[7:0];// Store password for RAM writing
                        state <= 3'b011; // Move to RAM Writing mode
                    end
                end
                3'b010: begin // ROM Editing/Reading state
                    if (password_input[6] == 1'b1) begin
                        state <= 3'b100; // ROM Reading mode
                    end else begin
                        password_buffer <= password_input[7:0]; // Store password for ROM writing
                        state <= 3'b100; // ROM Reading mode
                    end
                end
                3'b011, 3'b100: begin // Data editing/reading state
                    if (password_input[6] == 1'b0) begin // Write mode
                        if (password_input[7:0] == password_buffer) begin
                          if (state == 3'b011) begin // RAM Writing mode
                                ram_data <= data_input; // Update RAM data
                              
                            end else if (state == 3'b100) begin // ROM Writing mode
                                rom_data <= data_input; // Update ROM data
                            end
                        end
                    end
                    state <= 3'b000; // Return to idle state
                end
                default: state <= 3'b000; // Default to idle state
            endcase

            // Simulate file operations for RAM
            if ((state == 3'b011 || state == 3'b100)) begin
                file_handle = $fopen((state == 3'b011) ? Ram_file : Rom_file, "r"); // Open file for reading
                if (file_handle != 5'b0) begin
                    // Read data from file
                  if (state == 3'b011) begin 
                    $fscanf(file_handle, "%h",  ram_data);
                  end 
                  else begin
                    	$fscanf(file_handle, "%h", rom_data);
                  end
                    
                    $fclose(file_handle); // Close file after reading
                end
            end

          if (((state == 3'b011 && (password_input[5:0]==RAM_PASSWORD[5:0]))|| (state == 3'b100 && (password_input[5:0]==ROM_PASSWORD[5:0]))) && write_enable) begin
                file_handle = $fopen((state == 3'b011) ? Ram_file : Rom_file, "w"); // Open file for writing
                if (file_handle != 5'b0) begin
                    // Write data to file
                    $fwrite(file_handle, "%h\n", (state == 3'b011) ? ram_data : rom_data);
                    file_open <= 1'b1;
                end
            end

            if (state == 3'b000 && file_open) begin
                $fdisplay((state == 3'b011) ? Ram_file : Rom_file, "File closed");
                file_open <= 1'b0;
            end
        end
    end

    // Output ROM data in ROM mode only when read_enable is 1
    always @(posedge clk) begin
      if (read_enable && state == 3'b010) begin
            data_output <= rom_data;
        end else if (read_enable && state == 3'b001)begin
          data_output <= ram_data;
        end else begin
            data_output <= 8'b0;
        end
    end

endmodule
