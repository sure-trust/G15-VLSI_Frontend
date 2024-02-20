
`define WAITING               3'b000
`define MENU                  3'b010
`define BALANCE               3'b011
`define WITHDRAW              3'b100
`define DEPOSIT               3'b101
`define EXIT                  3'b110



module  example(input [11:0]acc_num,[3:0]pin,[2:0]menuOption,[31:0] amount,clk, exit,  output reg error, reg [15:0] balance,valid);
reg [11:0] acc_database [0:9];
reg [3:0] pin_database [0:9];
reg [15:0] balance_database [0:9];
reg [3:0]acc_index;
reg [3:0]pin_index;
reg [2:0] currState = `WAITING;
  //initializing the database with arbitrary accounts
  initial begin
  
  
    acc_database[0] = 12'd2749; pin_database[0] = 4'b0000;
    acc_database[1] = 12'd2175; pin_database[1] = 4'b0001;
    acc_database[2] = 12'd2429; pin_database[2] = 4'b0010;
    acc_database[3] = 12'd2125; pin_database[3] = 4'b0011;
    acc_database[4] = 12'd2178; pin_database[4] = 4'b0100;
    acc_database[5] = 12'd2647; pin_database[5] = 4'b0101;
    acc_database[6] = 12'd2816; pin_database[6] = 4'b0110;
    acc_database[7] = 12'd2910; pin_database[7] = 4'b0111;
    acc_database[8] = 12'd2299; pin_database[8] = 4'b1000;
    acc_database[9] = 12'd2689; pin_database[9] = 4'b1001;
    
    
 
        //$display("Welcome to the ATM");
        
         balance_database[0] = 16'd5000;
         balance_database[1] = 16'd10000;
         balance_database[2] = 16'd6500;
         balance_database[3] = 16'd4000;
         balance_database[4] = 16'd40000;
         balance_database[5] = 16'd550;
         balance_database[6] = 16'd400;
         balance_database[7] = 16'd620;
         balance_database[8] = 16'd8800;
         balance_database[9] = 16'd7200;
    
      end
      

    
//checking weather the given credentials are valid or invalid
integer i=0;
integer j=0;
always@(*)
begin
for(i=0;i<10;i=i+1)
begin
if (acc_num==acc_database[i])
begin
acc_index=i;
end
else
valid=1'b0;
end
for(j=0;j<10;j=j+1)
begin
if (pin==pin_database[j])
begin
pin_index=j;
end
else
valid=1'b0;
end
if(acc_index==pin_index)
valid=1'b1;
else
valid=1'b0;
end

always@(*)
begin

error = 0;


         if(exit ==1)
         begin
               //transition to the waiting state
               
               currState = `WAITING;
               
               #20;      
         end
   
     if(currState == `MENU) begin
         //set the selected option as the current state
         if((menuOption >= 0) & (menuOption <= 7))begin 
           currState = menuOption;
         end else
         currState = menuOption;
       end
       
       

         

      case (currState)


      `WAITING: begin
        if (valid == 1) begin
          currState = `MENU;
          $display("Logged In.");
        end
        else if(valid == 0) begin
          $display("Account number or password was incorrect");
          error=1;
          currState = `WAITING;
        end
      end
      
      
       `BALANCE: begin
             balance = balance_database[acc_index];
             $display("Account %d has balance %d", acc_num, balance_database[acc_index]);
             currState = `MENU;
           end
        
        
        `WITHDRAW: begin
                    if (amount <= balance_database[acc_index]) begin
                      balance_database[acc_index] = balance_database[acc_index] - amount;
                      balance = balance_database[acc_index];
                      currState = `MENU;
                      error = 0;
                      $display("Account %d has balance %d after withdrawing %d", acc_num, balance_database[acc_index], amount);
                    end
                    else begin
                      currState = `MENU;
                
                  
                      error = 1;
                    end
                end
                
          `DEPOSIT:begin
                    if(amount>=100 && amount <=10000) begin
                       balance_database[acc_index] = balance_database[acc_index] + amount;
                                         balance = balance_database[acc_index];
                                         currState = `MENU;
                                         error = 0;
                                         $display("Account %d has balance %d depositing %d", acc_num, balance_database[acc_index], amount);
                                       end
                                       else begin
                                         currState = `MENU;
                                         error = 1;
                                      
                                       end
                                   end
                                   
          
         
                                       
 endcase
 
end


endmodule
