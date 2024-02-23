module tb();

    reg clk, rst, write_enable, read_enable;
    reg [7:0] password_input, data_input;
    wire [7:0] data_output;

    // Instantiate the module
    password_RAM_ROM uut (
        .clk(clk),
        .rst(rst),
        .password_input(password_input),
        .data_input(data_input),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .data_output(data_output)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test scenarios
    initial begin
      $dumpfile("dump.vcd"); $dumpvars;
        // Apply reset at the beginning
        $display("Applying Reset");
        rst = 1;
        #10;
        rst = 0;
        #10;

        // Scenario 1: Wrong password for RAM writing
        $display("Scenario 1: Wrong password for RAM writing");
        password_input = 8'b10011010; // Wrong RAM password
        data_input = 8'hee;
        write_enable = 1;
        #20;
        write_enable = 0;
        #50;

        // Scenario 2: Correct password for RAM writing and reading
        $display("Scenario 2: Correct password for RAM writing");
        password_input = 8'b10111111; // Correct RAM password
        data_input = 8'hdd;
        write_enable = 1;
        #20;
        write_enable = 0;
        #20;
        read_enable = 1;
        #20;
        read_enable = 0;
        #50;

        // Scenario 3: Write and Read RAM with different data
        $display("Scenario 3: Write and Read RAM with different data");
        password_input = 8'b10111111; // Correct RAM password
        data_input = 8'hbb;
        write_enable = 1;
        #20;
        write_enable = 0;
        #20;
        read_enable = 1;
        #20;
        read_enable = 0;
        #50;

        // Scenario 4: Wrong password for ROM writing
        $display("Scenario 4: Wrong password for ROM writing");
        password_input = 8'b01011011; // Wrong ROM password
        data_input = 8'hcc;
        write_enable = 1;
        #20;
        write_enable = 0;
        #50;

        // Scenario 5: Correct password for ROM writing and reading
        $display("Scenario 5: Correct password for ROM writing and reading");
        password_input = 8'b00111110; // Correct ROM password
        data_input = 8'hcc;
        write_enable = 1;
        #20;
        write_enable = 0;
        #10;
        read_enable = 1;
        #20;
        read_enable = 0;
        #50;

        // Scenario 6: Write and Read ROM with different data
        $display("Scenario 6: Write and Read ROM with different data");
        password_input = 8'b00111110; // Correct ROM password
        data_input = 8'hff;
        write_enable = 1;
        #20;
        write_enable = 0;
        #10;
        read_enable = 1;
        #20;
        read_enable = 0;
        #50;

        $finish();
    end

endmodule
