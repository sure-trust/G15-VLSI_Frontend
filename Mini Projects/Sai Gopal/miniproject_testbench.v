`timescale 1ns/1ns                             

module tb_voting_machine ();
reg t_clk;
reg t_rst;
reg t_candidate_1;
reg t_candidate_2;
reg t_candidate_3;
reg t_vote_over;

wire [5:0] t_result_1;
wire [5:0] t_result_2;
wire [5:0] t_result_3;


voting_machine uut ( 
.clk(t_clk), 
.rst(t_rst), 
.i_candidate_1(t_candidate_1), 
.i_candidate_2(t_candidate_2), 
.i_candidate_3(t_candidate_3), 
.i_voting_over(t_vote_over),
.o_count1(t_result_1),
.o_count2(t_result_2),
.o_count3(t_result_3)
);


initial t_clk = 1'b1;


always
begin
    #5 t_clk = ~ t_clk;     
end


initial
begin
    $monitor ("time = %d, rst = %b, candidate_1 = %b, candidate_2 = %b, candidate_3 = %b, vote_over = %b, result_1 = %3d, result_2 = %3d, result_3 = %3d,\n",
    $time, t_rst, t_candidate_1, t_candidate_2, t_candidate_3, t_vote_over, t_result_1, t_result_2, t_result_3,);

    
    t_rst = 1'b1;
    t_candidate_1 = 1'b0;
    t_candidate_2 = 1'b0;
    t_candidate_3 = 1'b0;
    t_vote_over = 1'b0;

    #20 t_rst = 1'b0;
    #10 t_candidate_1 = 1'b1;              //when button for candidate 1 is pressed
    #10 t_candidate_1 = 1'b0;              //button  for candidate 1 is released

    #20 t_candidate_2 = 1'b1;              
    #10 t_candidate_2 = 1'b0;              

    #20 t_candidate_1 = 1'b1;              
    #10 t_candidate_1 = 1'b0;              

    #20 t_candidate_3 = 1'b1;              
    #10 t_candidate_3 = 1'b0;              
  
    #20 t_candidate_2 = 1'b1;
    #10 t_candidate_2 = 1'b0;

    #20 t_candidate_2 = 1'b1;
    #10 t_candidate_2 = 1'b0;
    
    #20 t_candidate_1 = 1'b1;
    #10 t_candidate_1 = 1'b0;
    
    #20 t_candidate_3 = 1'b1;               
    #10 t_candidate_3 = 1'b0;               


    #30 t_vote_over = 1'b1;

    #50 t_rst = 1'b1;                                    
    
   
    #60 $stop;                                          
end





endmodule
