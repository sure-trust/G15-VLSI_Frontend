`timescale 1ms / 1ms

module washing_tb();
  
  reg i_clk,i_start,i_cancel,i_coin,i_mode_1,i_mode_2,i_mode_3,i_mode_4;
  wire o_idle,o_ready,o_soak,o_wash,o_rinse,o_spin,o_done;
  
wash_design DUT(i_clk,i_start,i_cancel,i_coin,i_mode_1,i_mode_2,i_mode_3,i_mode_4,
                        o_idle,o_ready,o_soak,o_wash,o_rinse,o_spin,o_done);  
  
 always #10 i_clk = ~ i_clk; 
  /* Scenario 1 : Mode 1   */
 
  
    task scenario_1();
	  begin
	    
	    @(posedge i_clk) i_start = 1'b0; i_coin = 1'b1;
		@(posedge i_clk) i_coin = 1'b0; i_mode_1 = 1'b1;
		 
		wait(DUT.o_done) 
		  @(posedge i_clk);
		  i_mode_1 = 1'b0;
	  end
	endtask   
	
  /* Scenario 2 : Mode 2   */
  
    task scenario_2();
	  begin
	    @(posedge i_clk) i_start = 1'b0; i_coin = 1'b1;
		@(posedge i_clk) i_coin = 1'b0; i_mode_2 = 1'b1;
		 
		wait(DUT.o_done) 
		  @(posedge i_clk);
		  i_mode_2 = 1'b0;
	  end
	endtask

  /* Scenario 3 : Mode 3  */
  
    task scenario_3();
	  begin
	    @(posedge i_clk) i_start = 1'b0; i_coin = 1'b1;
		@(posedge i_clk) i_coin = 1'b0; i_mode_3 = 1'b1;
		 
		wait(DUT.o_done) 
		  @(posedge i_clk);
		  i_mode_3 = 1'b0;
	  end
	endtask   

  /* Scenario 4 : Mode 4*/
  
    task scenario_4();
	  begin
	    @(posedge i_clk) i_start = 1'b0;i_coin = 1'b1;
		@(posedge i_clk) i_coin = 1'b0; i_mode_4 = 1'b1;
		
		 
		wait(DUT.o_done) 
		  @(posedge i_clk);
		  i_mode_4 = 1'b0;
	  end
	endtask	  
	
	/* Scenario 5: Mode 1 and i_cancel during ready phase */
	
	task scenario_5();
	  begin
	    @(posedge i_clk) i_start = 1'b0;i_coin = 1'b1;
		@(posedge i_clk) i_coin = 1'b0; i_mode_1 = 1'b1; i_cancel = 1'b1;
		@(posedge i_clk);
		@(posedge i_clk);
		@(posedge i_clk);
		@(posedge i_clk) i_cancel = 1'b0;
	  end
	endtask
	
	
	/* Scenario 6: Mode 1 and i_cancel during wash phase */
	task scenario_6();
	  begin
	    @(posedge i_clk) i_start = 1'b0;i_coin = 1'b1;
		@(posedge i_clk) i_coin = 1'b0; i_mode_1 = 1'b1;
		repeat(10) @(posedge i_clk); //  with 10 clock cycle delay, state goes to wash phase 
		i_cancel = 1'b1;
		@(posedge i_clk);
		@(posedge i_clk);
		@(posedge i_clk);
		@(posedge i_clk) i_cancel = 1'b0;
	  end
	endtask   
	
	
	
  initial
     begin
       {i_start,i_cancel,i_coin,i_mode_1,i_mode_2,i_mode_3,i_mode_4} = 0;
       i_clk= 1'b0; 
       @(posedge i_clk) i_start = 1'b1;  //goes to idle state
       
	   /* remove comment markers as per your requirement 
       running all below scenarios might need (6840+8+5+10)*1000 = 68,63,000 ms to finish the entire simulation,so you need to be patient */
     scenario_1;
	   scenario_2;
	   scenario_3;
     scenario_4;
	   scenario_5;
	   scenario_6;
       
       
       #10000; //10 secs delay not neeeded tho 
       $finish;
     end  
 
endmodule

       
