`timescale 1ms / 1ms

 module wash_design(i_clk,i_start,i_cancel,i_coin,i_mode_1,i_mode_2,i_mode_3,i_mode_4,
                        o_idle,o_ready,o_soak,o_wash,o_rinse,o_spin,o_done);
						
	input i_clk,i_start,i_cancel,i_coin,i_mode_1,i_mode_2,i_mode_3,i_mode_4;
	output o_idle,o_ready,o_soak,o_wash,o_rinse,o_spin;
	output o_done;
	
	parameter IDLE  = 6'b000001,
	          READY = 6'b000010,
			  SOAK  = 6'b000100,
			  WASH  = 6'b001000,
			  RINSE = 6'b010000,
			  SPIN  = 6'b100000;
	
    // i_clk = 250hz means 1sec = 250 clock cycles
	
	/* mode1 - cloth < daily wear> 
       Soak  : 5 mins   (5*60*250  = 75,000)
       Wash  : 10 mins  (10*60*250 = 1,50,000)
       Rinse : 5 mins   (5*60*250  = 75,000)
       Spin  : 5 mins   (5*60*250  = 75,000)
	   
	   mode2 - cloth < heavy>
       Soak  : 15mins   (15*60*250  = 2,25,000) 
       Wash  : 20 mins  (20*60*250 = 3,00,000)
       Rinse : 15 mins   (15*60*250  = 2,25,000)
       Spin  : 15 mins   (15*60*250  = 2,25,000)
	   
	   mode3 - cloth <delicate>
       Soak  : 3 mins  (3*60*250 = 45,000)
       Wash  : 8 mins  (8*60*250 = 1,20,000)
       Rinse : 3 mins  (3*60*250 = 45,000)
       Spin  : 3 mins  (3*60*250 = 45,000
       
       	   mode3 -  cloth <smooth>
       Soak  : 5 mins  (5*60*250 = 75,000)
       Wash  : 10 mins  (20*60*250 = 1,50,000)
       Rinse : 5 mins  (10*60*250 = 75,000)
       Spin  : 5 mins  (10*60*250 = 75,000    */
       
       
       
       	   
	   reg [5:0] PS,NS;
	   
	   
		
        reg soak_done,wash_done,rinse_done,spin_done;
		
        wire soak_up,wash_up,rinse_up,spin_up;

		reg [18:0] soakcounter,washcounter,rinsecounter,spincounter; //19 bits can count upto 5,24,288
		
		//------- Timer pause logic when lid is open -------------------
		
	
		

		assign soak_up  = (PS == SOAK) && (i_mode_1 || i_mode_2 || i_mode_3||i_mode_4);
		assign wash_up  = (PS == WASH);
		assign rinse_up = (PS == RINSE);
		assign spin_up  = (PS == SPIN);
		
	
	    //---------- SOAK DONE LOGIC ------------------------------
        always@(i_mode_1,i_mode_2,i_mode_3,i_mode_4,soakcounter)
		    begin
			    if(i_mode_1)
				  soak_done = (soakcounter == 75000) ? 1'b1 : 1'b0;
				else if(i_mode_2)
				  soak_done = (soakcounter == 225000) ? 1'b1 : 1'b0;
                else if(i_mode_3)
                  soak_done = (soakcounter == 45000) ? 1'b1 : 1'b0;	
                else if(i_mode_4)
                  soak_done = (soakcounter == 75000) ? 1'b1 : 1'b0;    	
             end
			 
			 
		//---------- WASH DONE LOGIC ------------------------------	
            always@(i_mode_1,i_mode_2,i_mode_3,i_mode_4,washcounter)
		    begin
			    if(i_mode_1)
				  wash_done = (washcounter == 150000) ? 1'b1 : 1'b0;
				else if(i_mode_2)
				  wash_done = (washcounter == 300000) ? 1'b1 : 1'b0;
                else if(i_mode_3)
				  wash_done = (washcounter == 120000) ? 1'b1 : 1'b0;				  
                else if(i_mode_4)
                  wash_done = (washcounter == 150000) ? 1'b1 : 1'b0;				  
			end
			
			
        //---------- RINSE DONE LOGIC ------------------------------
              always@(i_mode_1,i_mode_2,i_mode_3,i_mode_4,rinsecounter)
		    begin
			    if(i_mode_1)
				  rinse_done = (rinsecounter == 75000) ? 1'b1 : 1'b0;
				else if(i_mode_2)
				  rinse_done = (rinsecounter == 225000) ? 1'b1 : 1'b0;
                else if(i_mode_3)
				  rinse_done = (rinsecounter == 45000) ? 1'b1 : 1'b0;				  
                else if(i_mode_4)
                  rinse_done = (rinsecounter == 75000) ? 1'b1 : 1'b0;    				  
			end		

			
		//---------- SPIN DONE LOGIC ------------------------------	
              always@(i_mode_1,i_mode_2,i_mode_3,i_mode_4,spincounter)
		    begin
			    if(i_mode_1)
				  spin_done = (spincounter == 75000) ? 1'b1 : 1'b0;
				else if(i_mode_2)
				  spin_done = (spincounter == 225000) ? 1'b1 : 1'b0;
                else if(i_mode_3)
				  spin_done = (spincounter == 45000) ? 1'b1 : 1'b0;				  
                else if(i_mode_4)
                  wash_done = (washcounter == 75000) ? 1'b1 : 1'b0;    				  
			end	
   
   
   
		//----------- SOAK TIMER ------------------------------------
        always@(posedge i_clk)
            begin
              if(i_start)
			        soakcounter <= 0;
			   if(soak_done)
                    soakcounter <= 0;		   
               else if(soak_up)
                    soakcounter <= soakcounter + 1'b1;				
            end
			
        //----------- WASH TIMER ------------------------------------
        always@(posedge i_clk)
            begin
              if(i_start)
			        washcounter <= 0;
				else if(wash_done)
                    washcounter <= 0;	
                else if(wash_up)
                    washcounter <= washcounter + 1'b1;				
            end
			
		//----------- RINSE TIMER ------------------------------------	
		always@(posedge i_clk)
            begin
              if(i_start)
			        rinsecounter <= 0;
			   else if(rinse_done)
                    rinsecounter <= 0;
			   else if(rinse_up)
                    rinsecounter <= rinsecounter + 1'b1;				
            end
        //----------- SPIN TIMER ------------------------------------
        always@(posedge i_clk)
            begin
              if(i_start)
			        spincounter <= 0;
			   else if(spin_done)
                    spincounter <= 0;		
               else if(spin_up)
                    spincounter <= spincounter + 1'b1;				
            end			
			
		
		
		//---------------- Present state logic ----------------------
	   always@(posedge i_clk)
	       begin
		       if(i_start)
			      PS <= IDLE;
			   else if(i_cancel)
                  PS <= IDLE;
               else
                  PS <= NS;			   
		   end
		   
		
		
	    //----------- Next state decoder logic ------------------------------------
		
   always@(*)		//always@(PS,i_cancel,i_coin,i_lid,i_mode_1,i_mode_2,i_mode_3,soak_done,wash_done,rinse_done,spin_done) 
             begin
				case(PS)
				  IDLE : begin 
				          if(i_coin && !i_cancel)
						     NS <= READY;
						  else
                             NS <= PS;						  
						 end
						 
				  READY : begin 
                    if(!i_cancel && (i_mode_1 || i_mode_2 || i_mode_3||i_mode_4))
							  NS <= SOAK;
							else
                              NS <= PS;							
				          end

                  SOAK : begin 
                    if( !i_cancel && soak_done)
							  NS <= WASH;
							else
                              NS <= PS;							
				         end
 
                  WASH : begin 
                         if(!i_cancel && wash_done)    
							  NS <= RINSE;
							else
                              NS <= PS;							
				         end

                  RINSE : begin 
                    if(!i_cancel && rinse_done)
							  NS <= SPIN;
							else
                              NS <= PS;	
				          end

                  SPIN : begin 
                    if(!i_cancel && spin_done)
							  NS <= IDLE;
							else
                              NS <= PS;	
				         end	
                  default :  NS <= IDLE;
                endcase         
		    end			 
			
			
		//--- output logic --

        assign o_idle = (PS == IDLE);
        assign o_ready = (PS == READY);
        assign o_soak = (PS == SOAK);
        assign o_wash = (PS == WASH);
        assign o_rinse = (PS == RINSE);
        assign o_spin = (PS == SPIN);
        assign o_done = (PS == SPIN) && (spin_done);

     endmodule