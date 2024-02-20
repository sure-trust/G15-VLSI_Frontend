`timescale 1ns / 1ps
module elevator_4stage(clk,rst,rgnd,r1st,r2nd,r3rd,r4th,floor,dir,state);
input clk,rst;
input rgnd,r1st,r2nd,r3rd,r4th;
output [2:0]floor;
//reg [1:0] floor;
parameter groundfloor=0,firstfloor=1,secondfloor=2,thirdfloor=3,fouthfloor=4;
output [2:0]state;
reg [2:0]state;
parameter up=0,down=1;
output [1:0]dir;
reg [1:0]dir;
always @(posedge clk)
begin
   if(rst) state <=groundfloor;
   else begin
	  case(state)
	  groundfloor: case(1)
           rgnd: state <= groundfloor;
           r1st: state <= firstfloor;
	       r2nd: state <= secondfloor;
	       r3rd: state <= thirdfloor;
	       r4th: state <=fouthfloor;
		   endcase
	  firstfloor: case(dir)
	     up: case(1)
		      r1st: state <= firstfloor;
			  r2nd: state <= secondfloor;
			  r3rd: state <= thirdfloor;
			  r4th: state <=fouthfloor;
			  rgnd: state <= groundfloor;
		     endcase
		 down: case(1)    // case=1 means all states =1;
                r1st: state <= firstfloor;
                rgnd: state <= groundfloor;
                r2nd: state <= secondfloor;
                r3rd: state <= thirdfloor;
                r4th: state <=fouthfloor;
		       endcase
		  endcase
	   secondfloor: case(dir)
	      up: case(1)
			   r2nd: state <= secondfloor;
			   r3rd: state <= thirdfloor;
			   r4th: state <=fouthfloor;
			   r1st: state <= firstfloor;
			   rgnd: state <= groundfloor;
			  endcase
		  down: case(1)
                 r2nd: state <= secondfloor;
                 r1st: state <= firstfloor;
                 rgnd: state <= groundfloor;
                 r3rd: state <= thirdfloor;
                 r4th: state <=fouthfloor;
                endcase
		 endcase
      thirdfloor: case(dir)
            up: case(1)
                 r3rd: state <= thirdfloor;
                 r4th: state <=fouthfloor;	     
                 r2nd: state <= secondfloor;		      
                 r1st: state <= firstfloor;			 
                 rgnd: state <= groundfloor;			 
                endcase 
		   down: case(1)
		         r3rd: state <= thirdfloor;
		         r2nd: state <= secondfloor;
                 r1st: state <= firstfloor;
                 rgnd: state <= groundfloor;
                 r4th: state <=fouthfloor;
                 endcase
             endcase
	  fouthfloor: case(1)
	          r4th: state <=fouthfloor;
		      r3rd: state <= thirdfloor;	     
              r2nd: state <= secondfloor;              
              r1st: state <= firstfloor;             
              rgnd: state <= groundfloor;             
                endcase
	endcase
end
end
always @(posedge clk)
begin
	if(rst) dir <=  groundfloor;
	else begin
	case (state)
	groundfloor: case(1)
		  rgnd: dir<= up;
		  r1st: dir<= up;
		  r2nd: dir<= up;
		  r3rd: dir<= up;
		  r4th: dir<= down;
		 endcase
	
	firstfloor: case(dir)
	    up:case(1)
            r1st: dir<= up;
            r2nd: dir<= up;
            r3rd: dir<= up;	
            r4th: dir<= down;	   
            rgnd: dir<= up;			
		   endcase
		down:case(1)
		  r1st: dir<= down;		  
		  rgnd: dir<= up;			
		  r2nd: dir<= up;
		  r3rd: dir<= up;
		  r4th: dir<= down;	
          endcase
		 endcase
		 /////
	secondfloor: case(dir)
	    up:case(1)
		  r2nd: dir<= up;
		  r3rd: dir<= up;
		  r4th: dir<= down;			
		  r1st: dir<= up;		  
		  rgnd: dir<= up;
		   endcase
		down:case(1)
		  r2nd: dir<= down;		
		  r1st: dir<= down;		  
		  rgnd: dir<= up;	  
		  r3rd: dir<= down;
		  r4th: dir<= down;
		     endcase
		 endcase
	thirdfloor: case(dir)
	   up:case(1)
            r3rd: dir <=up;
            r4th: dir<= down;
            r2nd: dir <=up;		      
            r1st: dir <=up;			 
            rgnd: dir <=up;
	      endcase
	   down:case(1)
               r3rd: dir <=down;
               r2nd: dir <=down;              
               r1st: dir <=down;             
               rgnd: dir <=up;
               r4th: dir<= down;
             endcase
	      endcase
	  fouthfloor: case(1)
	          r4th: dir<= down;
              r3rd: dir <=down;
              r2nd: dir <=down;              
              r1st: dir <=down;             
              rgnd: dir <=up;
                endcase
          endcase
end
end
assign floor = state;
endmodule