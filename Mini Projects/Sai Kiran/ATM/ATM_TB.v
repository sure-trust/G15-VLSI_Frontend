`define WAITING               3'b000
`define MENU                  3'b010
`define BALANCE               3'b011
`define WITHDRAW              3'b100
`define DEPOSIT               3'b101


module example_tb();

reg [11:0]acc_num;
reg [3:0]pin;
reg [2:0]menuOption;
reg  [31:0] amount;
reg clk;
reg exit;


wire error;
wire [15:0]balance;
wire valid;

example e1(.acc_num(acc_num),.pin(pin),.menuOption(menuOption),.amount(amount),.clk(clk),.exit(exit),.error(error),.balance(balance),.valid(valid));

 initial begin
    clk = 1'b0;
  end
  
 always @(error) begin
       if(error == 1)
         $display("Error!, action causes an invalid operation.");
    end

  initial begin
	

    //incorrect PIN
    acc_num = 12'd2278;
    pin = 4'b0100;
    
    #30

    //valid credentials
    acc_num = 12'd2178;
    pin = 4'b0100;
    
    #30
    
    
    //show the balance
    menuOption = `BALANCE;
    clk = ~clk;#5clk = ~clk;
    #30
    
    //withdraw some money and then show the balance
    amount = 100;
	menuOption = `WITHDRAW;
    clk = ~clk;#5clk = ~clk;
    
    #30
    
    amount = 2000;
    menuOption = `DEPOSIT;
    clk = ~clk;#5clk = ~clk;
    
    //withdraw too much money, resulting in an error
     amount = 43000;
     menuOption = `WITHDRAW;
     clk = ~clk;#5clk = ~clk;
     
     #30
   
       //the balance wont change because an error happened during withdrawal
       menuOption = `BALANCE;
       clk = ~clk;#5clk = ~clk;
      
        
end

endmodule