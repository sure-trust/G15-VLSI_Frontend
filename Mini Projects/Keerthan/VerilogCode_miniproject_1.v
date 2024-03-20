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
  reg [7:0] RAM_PASSWORD = 8'h10111111;//ff or bf 
  reg [7:0] ROM_PASSWORD = 8'h00111110;//7e or 3e 
  parameter Ram_file = "ram_file.txt"; 
  parameter Rom_file = "rom_file.txt";

    // Internal signals
    reg [2:0] state;
    integer ram;
   integer rom;
    reg file_open;

    // RAM and ROM storage
    reg [7:0] ram_data;
    reg [7:0] rom_data;
  reg [7:0] read_data;
    reg [7:0] read_data2;
  
 

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            
            ram <= 5'b0;
            rom <= 5'b0;
            file_open <= 1'b0;
            data_output <= 8'b0;
        end
      
      else if(write_enable) begin
        if(password_input==8'b10111111) begin
          ram= $fopen( "ram_file.txt", "w"); // Open file in read mode
          $fwrite(ram, "%d", data_input); 
          $fclose(ram);
        end
        if(password_input==8'b00111110) begin
          rom= $fopen( "rom_file.txt", "w"); // Open file in read mode
          $fwrite(rom, "%d", data_input); 
          $fclose(rom);
        end
    end
      else if(read_enable) begin
        if(password_input[7]==1) begin
            // Read data from file when read enable is high
          ram= $fopen( "ram_file.txt", "r"); // Open file in read mode
          $fscanf(ram, "%d", read_data);  // Read data from file
          $fclose(ram);           // Close the file
            data_output <= read_data;                    // Assign read data to output
        end else begin
            // Read data from file when read enable is high
          rom= $fopen( "rom_file.txt", "r"); // Open file in read mode
            $fscanf(rom, "%d", read_data2);  // Read data from file
          $fclose(rom);            // Close the file
            data_output <= read_data2;                    // Assign read data to output
        end
      end 
    end
  
endmodule
