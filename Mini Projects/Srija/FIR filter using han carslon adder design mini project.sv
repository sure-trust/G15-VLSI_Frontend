// Code your design here
//miniproject design code
module FIR_using_HCA(filter_out,clk,reset,filter_in);
input clk,reset;
input signed [7:0] filter_in;
output signed [15:0] filter_out;
parameter signed [7:0] coeff0 = 8'b11110111;//-9
parameter signed [7:0] coeff1 = 8'b11111101;//-3
parameter signed [7:0] coeff2 = 8'b00001100;//12
parameter signed [7:0] coeff3 = 8'b00011010;//26
parameter signed [7:0] coeff4 = 8'b00011010;//26
parameter signed [7:0] coeff5 = 8'b00001100;//12
parameter signed [7:0] coeff6 = 8'b11111101;//-3
parameter signed [7:0] coeff7 = 8'b11110111;//-9

reg  signed [9:0] delay [1:7] ; 
wire signed [15:0] mul_temp [1:8]; 
wire signed [15:0] temp_add [0:6];
wire signed [15:0] add [0:6]; 
reg  signed [15:0] output_register;
  
    always @( posedge clk or posedge reset)
    begin: Delay_process
      if (reset) 
		begin
        delay[1] <= 0;
        delay[2] <= 0;
        delay[3] <= 0;	
		  delay[4] <= 0;
        delay[5] <= 0;
        delay[6] <= 0;
        delay[7] <= 0;
    end
      else
		begin
          delay[1] <= filter_in;
          delay[2] <= delay[1];
          delay[3] <= delay[2];	
          delay[4] <= delay[3];
          delay[5] <= delay[4];
          delay[6] <= delay[5];
          delay[7] <= delay[6];
      end
    end 


    assign mul_temp[1] = filter_in * coeff0;
    assign mul_temp[2] = delay[1] *     coeff1;
    assign mul_temp[3] = delay[2] *     coeff2;
    assign mul_temp[4] = delay[3] *     coeff3;
    assign mul_temp[5] = delay[4] *     coeff4;
    assign mul_temp[6] = delay[5] *     coeff5;
    assign mul_temp[7] = delay[6] *     coeff6;
    assign mul_temp[8] = delay[7] *     coeff7;
    
    //assign temp_add[0] = mul_temp[1] + mul_temp[2];
	// hancarslon_adder (sum,a,b,cin);
	 han_carslon_adder ha1(.sum(temp_add[0]),.a(mul_temp[1]),.b(mul_temp[2]),.cin(1'b0));
    assign add[0] = temp_add[0];
   
    //assign temp_add[1] = mul_temp[3] + add[0];
	 han_carslon_adder ha2(.sum(temp_add[1]),.a(mul_temp[3]),.b(add[0]),.cin(1'b0));
    
    assign add[1] = temp_add[1];
   
    //assign temp_add[2] = mul_temp[4] + add[1];
	han_carslon_adder ha3(.sum(temp_add[2]),.a(mul_temp[4]),.b(add[1]),.cin(1'b0));
    
    assign add[2] = temp_add[2];
   
    //assign temp_add[3] = mul_temp[5] + add[2];
	 han_carslon_adder ha4(.sum(temp_add[3]),.a(mul_temp[5]),.b(add[2]),.cin(1'b0));
    
    assign add[3] = temp_add[3];
   
    //assign temp_add[4] = mul_temp[6] + add[3];
	 han_carslon_adder ha5(.sum(temp_add[4]),.a(mul_temp[6]),.b(add[3]),.cin(1'b0));
    
    assign add[4] = temp_add[4];
   
    //assign temp_add[5] = mul_temp[7] + add[4];
	 han_carslon_adder ha6(.sum(temp_add[5]),.a(mul_temp[7]),.b(add[4]),.cin(1'b0));
    
    assign add[5] = temp_add[5];
   
    // assign temp_add[6] = mul_temp[8] + add[5];
	 han_carslon_adder ha7(.sum(temp_add[6]),.a(mul_temp[8]),.b(add[5]),.cin(1'b0));
    
    assign add[6] = temp_add[6];
   
    
    always @ (posedge clk or posedge reset)
    begin
        if (reset) 
			output_register <= 0;
      else 
         output_register <= add[6];
    end

  assign filter_out = output_register;
endmodule  
//han carslon adder

module han_carslon_adder(a,b,cin,sum);
  input [15:0]a,b;
  input cin;
  output[15:0] sum;
  wire [15:0] g,p;
  assign g = a & b;
  assign p = a ^ b;
  wire g10,g32,p32,g54,p54,g76,p76,g98,p98,g1110,p1110,g1312,p1312,g1514,p1514,g30,g52,p52,g96,p96,g118,p118,g1310,p1310,g1512,p1512,g50,g74,p74,g70,g92,g114,p114,g136,p136,g158,p158,g91,g113,g135,g157,g20,g40,g60,g80,g100,g120,g140,p92;
  
  ///level1
gc gp1(.g2(g[1]),.p2(p[1]),.g1(g[0]),.G(g10));

bc bp1(.g2(g[3]),.p2(p[3]),.g1(g[2]),.p1(p[2]),.G(g32),.P(p32));
bc bp2(.g2(g[5]),.p2(p[5]),.g1(g[4]),.p1(p[4]),.G(g54),.P(p54));
bc bp3(.g2(g[7]),.p2(p[7]),.g1(g[6]),.p1(p[6]),.G(g76),.P(p76));
bc bp4(.g2(g[9]),.p2(p[9]),.g1(g[8]),.p1(p[8]),.G(g98),.P(p98));
bc bp5(.g2(g[11]),.p2(p[11]),.g1(g[10]),.p1(p[10]),.G(g1110),.P(p1110));
bc bp6(.g2(g[13]),.p2(p[13]),.g1(g[12]),.p1(p[12]),.G(g1312),.P(p1312));
bc bp7(.g2(g[15]),.p2(p[15]),.g1(g[14]),.p1(p[14]),.G(g1514),.P(p1514));
  ///level2
  gc gp2(.g2(g32),.p2(p32),.g1(g10),.G(g30));
 bc bp8(.g2(g54),.p2(p54),.g1(g32),.p1(p32),.G(g52),.P(p52));
  bc bp9(.g2(g76),.p2(p76),.g1(g54),.p1(p54),.G(g74),.P(p74));
  bc bp10(.g2(g98),.p2(p98),.g1(g76),.p1(p76),.G(g96),.P(p96));
  bc bp11(.g2(g1110),.p2(p1110),.g1(g98),.p1(p98),.G(g118),.P(p118));
  bc bp12(.g2(g1312),.p2(p1312),.g1(g1110),.p1(p1110),.G(g1310),.P(p1310));
  bc bp13(.g2(g1514),.p2(p1514),.g1(g1312),.p1(p1312),.G(g1512),.P(p1512));
  //level3
  gc gp3(.g2(g52),.p2(p52),.g1(g10),.G(g50));
  gc gp4(.g2(g74),.p2(p74),.g1(g30),.G(g70));
  bc bp14(.g2(g96),.p2(p96),.g1(g52),.p1(p52),.G(g92),.P(p92));
  bc bp15(.g2(g118),.p2(p118),.g1(g74),.p1(p74),.G(g114),.P(p114));
  bc bp16(.g2(g1310),.p2(p1310),.g1(g96),.p1(p96),.G(g136),.P(p136));
  bc bp17(.g2(g1512),.p2(p1512),.g1(g118),.p1(p118),.G(g158),.P(p158));
  ///level4
  gc gp5(.g2(g92),.p2(p92),.g1(g10),.G(g91));
  gc gp6(.g2(g114),.p2(p114),.g1(g30),.G(g113));
  gc gp7(.g2(g136),.p2(p136),.g1(g50),.G(g135));
  gc gp8(.g2(g158),.p2(p158),.g1(g70),.G(g157));
///level5
  gc gp9(.g2(g[2]),.p2(p[2]),.g1(g10),.G(g20));
  gc gp10(.g2(g[4]),.p2(p[4]),.g1(g30),.G(g40));
  gc gp11(.g2(g[6]),.p2(p[6]),.g1(g50),.G(g60));
  gc gp12(.g2(g[8]),.p2(p[8]),.g1(g70),.G(g80));
  gc gp13(.g2(g[10]),.p2(p[10]),.g1(g91),.G(g100));
  gc gp14(.g2(g[12]),.p2(p[12]),.g1(g113),.G(g120));
  gc gp15(.g2(g[14]),.p2(p[14]),.g1(g135),.G(g140));

  //sum generation
  assign sum[0] = p[0] ^ cin  ;
assign sum[1] = p[1] ^ g10  ;
assign sum[2] = p[2] ^ g20  ;
assign sum[3] = p[3] ^ g30  ;
assign sum[4] = p[4] ^ g40  ;
assign sum[5] = p[5] ^ g50  ;
assign sum[6] = p[6] ^ g60  ;
assign sum[7] = p[7] ^ g70  ;
assign sum[8] = p[8] ^ g80  ;
  assign sum[9] = p[9] ^ g91  ;
assign sum[10] = p[10] ^ g100  ;
  assign sum[11] = p[11] ^ g113  ;
assign sum[12] = p[12] ^ g120  ;
  assign sum[13] = p[13] ^ g135  ;
assign sum[14] = p[14] ^ g140  ;
  assign sum[15] = p[15] ^ g157  ;
  
  
endmodule

//black cell

module bc(g2,p2,g1,p1,G,P);
    input  g1,p1,g2,p2;
    output G,P;
    assign G = ( g2 | (g1&p2));
    assign P = p1&p2;
endmodule

//gray cell
module gc(g2,p2,g1,G);
    input  g1,g2,p2;
    output G ;
    assign G = g2 | (g1&p2);
endmodule
