// Code your design here
module ALU(A,B,sel,Yout);
  input [31:0] A,B;
  input [3:0] sel ;
  output reg [63:0]Yout;
  wire [32:0]Yadd;
  wire [31:0]Yfullsub;
  wire [63:0]Yproduct;
  wire[31:0]Ydiv,Ymod;
  wire [31:0]Yand,Yor ;
  wire [31:0]Yincr,Ydecr,Ynand,Ynor;
  wire [31:0]Yxor,Ynot,Yxnor;
  wire [31:0]Yshr,Yshl;
  
  RIPPLE_CARRY_ADDER32BIT ins1(.A(A),.B(B),.Cin(1'b0),.SUM(Yadd[31:0]),.CARRY(Yadd[32]));
  modified_booth_multiplier ins2(.product(Yproduct),.x(A),.y(B)) ;

//modified_booth_multiplier(x,y,product );
  fullsub ins0(.a(A), .b(B), .diff(Yfullsub));
  div ins5(.a(A), .b(B), .div1(Ydiv));
  and_logic ins3(.a(A),.b(B),.y(Yand));
  or_logic ins4(.a(A),.b(B),.y(Yor));
  not1 ins6(.a(A), .y(Ynot));
  nand1 ins7(.a(A), .b(B), .y(Ynand));
  nor1 ins8(.a(A), .b(B), .y(Ynor));
  incr1 ins9(.a(A), .y(Yincr));
  decr1 ins10(.a(A), .y(Ydecr));
  shr1 ins11(.a(A), .y(Yshr));
  shl1 ins12(.b(B), .y(Yshl));
  xor1 ins13(.a(A), .b(B), .y(Yxor));
  xnor1 ins14(.a(A), .b(B), .y(Yxnor));
  mod1 ins15(.a(A), .b(B), .y(Ymod));
  always@ *
    begin
      if(sel==4'b000) Yout = Yfullsub ;
      else if(sel==4'b0001) Yout = Yadd ;
      else if(sel==4'b0010) Yout = Yproduct;
      else if(sel==4'b0011) Yout = Ydiv ;
      else if(sel==4'b0100) Yout = Yand ;
      else if(sel==4'b0101) Yout = Yor ;
      else if(sel==4'b0110) Yout = Ynot ;
      else if(sel==4'b0111) Yout = Ynand ;
      else if(sel==4'b1000) Yout = Ynor ;
      else if(sel==4'b1001) Yout = Yshr ;
      else if(sel==4'b1010) Yout = Yshl ;
      else if(sel==4'b1011) Yout = Yxor;
      else if(sel==4'b1100) Yout = Yxnor;
      else if(sel==4'b1101) Yout = Ymod;
      else if(sel==4'b1110)Yout = Yincr ;
      else  Yout = Ydecr ;
    end
endmodule
///

//////32BIT RIPPLE CARRY ADDER//////////
module RIPPLE_CARRY_ADDER32BIT(A,B,Cin,SUM,CARRY);
  input [31:0]A,B;
  input Cin;
  output [31:0]SUM;
  output CARRY ;
  wire C1;
  RIPPLE_CARRY_ADDER16BIT rca1(.A(A[15:0]),.B(B[15:0]),.Cin(Cin),.SUM(SUM[15:0]),.CARRY(C1));
  RIPPLE_CARRY_ADDER16BIT rca2(.A(A[31:16]),.B(B[31:16]),.Cin(C1),.SUM(SUM[31:16]),.CARRY(CARRY));
endmodule
//////16BIT RIPPLE CARRY ADDER//////////
module RIPPLE_CARRY_ADDER16BIT(A,B,Cin,SUM,CARRY);
  input [15:0]A,B;
  input Cin;
  output [15:0]SUM;
  output CARRY ;
  wire C1;
  RIPPLE_CARRY_ADDER8BIT rca1(.A(A[7:0]),.B(B[7:0]),.Cin(Cin),.SUM(SUM[7:0]),.CARRY(C1));
  RIPPLE_CARRY_ADDER8BIT rca2(.A(A[15:8]),.B(B[15:8]),.Cin(C1),.SUM(SUM[15:8]),.CARRY(CARRY));
endmodule

//////8BIT RIPPLE CARRY ADDER//////////
module RIPPLE_CARRY_ADDER8BIT(A,B,Cin,SUM,CARRY);
  input [7:0]A,B;
  input Cin;
  output [7:0]SUM;
  output CARRY ;
  wire C1;

RIPPLE_CARRY_ADDER4BIT rca1(.A(A[3:0]),.B(B[3:0]),.Cin(Cin),.SUM(SUM[3:0]),.CARRY(C1));
RIPPLE_CARRY_ADDER4BIT rca2(.A(A[7:4]),.B(B[7:4]),.Cin(C1),.SUM(SUM[7:4]),.CARRY(CARRY));

endmodule


//////4BIT RIPPLE CARRY ADDER//////////
module RIPPLE_CARRY_ADDER4BIT(A,B,Cin,SUM,CARRY);
  input [3:0]A,B;
  input Cin;
  output [3:0]SUM;
  output CARRY ;
  wire C1,C2,C3;
  fulladder fa1(.a(A[0]),.b(B[0]),.c(Cin),.sum(SUM[0]),.carry(C1));
  fulladder fa2(.a(A[1]),.b(B[1]),.c(C1),.sum(SUM[1]),.carry(C2));
  fulladder fa3(.a(A[2]),.b(B[2]),.c(C2),.sum(SUM[2]),.carry(C3));
  fulladder fa4(.a(A[3]),.b(B[3]),.c(C3),.sum(SUM[3]),.carry(CARRY));


endmodule

//full adder

module fulladder(a,b,c,sum,carry);
  input a,b,c;
  output sum,carry;
  assign sum = a ^ b ^ c;
  assign carry = (a&b)|(b&c)|(a&c);
endmodule 

module fullsub(a,b,diff);
  input [31:0]a,b;
  output [31:0]diff;
  
  assign diff = a - b;
endmodule


//// modified booth multiplier
module modified_booth_multiplier(input [31:0] x,y,output [63:0] product);
  // wire [15:0] y;
  wire [32:0] PP1,PP2,PP3,PP4,PP5,PP6,PP7,PP8 ;
  wire [32:0] PP9,PP10,PP11,PP12,PP13,PP14,PP15,PP16 ;
	 
     all_partial_products sm1 (x,y,PP1,PP2,PP3,PP4,PP5,PP6,PP7,PP8,PP9,PP10,PP11,PP12,PP13,PP14,PP15,PP16);
	 adder_32bits sm2 (PP1,PP2,PP3,PP4,PP5,PP6,PP7,PP8,PP9,PP10,PP11,PP12,PP13,PP14,PP15,PP16, product);
	 
endmodule


module all_partial_products(Multiplier,Multiplicand,PP1,PP2,PP3,PP4,PP5,PP6,PP7,PP8,PP9,PP10,PP11,PP12,PP13,PP14,PP15,PP16);
  
  
  input [31:0] Multiplier;
  input [31:0] Multiplicand;
  
  output [32:0] PP1,PP2,PP3,PP4,PP5,PP6,PP7,PP8;
    
  output [32:0] PP9,PP10,PP11,PP12,PP13,PP14,PP15,PP16;

  
  Partial_product  n1(.Multiplicand(Multiplicand),.MLP_1(1'b0),.MLP_2(Multiplier[0]),.MLP_3(Multiplier[1]),.PP_out(PP1));
  Partial_product  n2(.Multiplicand(Multiplicand),.MLP_1(Multiplier[1]),.MLP_2(Multiplier[2]),.MLP_3(Multiplier[3]),.PP_out(PP2));
  Partial_product  n3(.Multiplicand(Multiplicand),.MLP_1(Multiplier[3]),.MLP_2(Multiplier[4]),.MLP_3(Multiplier[5]),.PP_out(PP3));
  Partial_product  n4(.Multiplicand(Multiplicand),.MLP_1(Multiplier[5]),.MLP_2(Multiplier[6]),.MLP_3(Multiplier[7]),.PP_out(PP4));
  Partial_product  n5(.Multiplicand(Multiplicand),.MLP_1(Multiplier[7]),.MLP_2(Multiplier[8]),.MLP_3(Multiplier[9]),.PP_out(PP5));
  Partial_product  n6(.Multiplicand(Multiplicand),.MLP_1(Multiplier[9]),.MLP_2(Multiplier[10]),.MLP_3(Multiplier[11]),.PP_out(PP6));
  Partial_product  n7(.Multiplicand(Multiplicand),.MLP_1(Multiplier[11]),.MLP_2(Multiplier[12]),.MLP_3(Multiplier[13]),.PP_out(PP7));
  Partial_product  n8(.Multiplicand(Multiplicand),.MLP_1(Multiplier[13]),.MLP_2(Multiplier[14]),.MLP_3(Multiplier[15]),.PP_out(PP8));
    
  Partial_product  n9(.Multiplicand(Multiplicand),.MLP_1(Multiplier[15]),.MLP_2(Multiplier[16]),.MLP_3(Multiplier[17]),.PP_out(PP9));
  Partial_product  n10(.Multiplicand(Multiplicand),.MLP_1(Multiplier[17]),.MLP_2(Multiplier[18]),.MLP_3(Multiplier[19]),.PP_out(PP10));
  Partial_product  n11(.Multiplicand(Multiplicand),.MLP_1(Multiplier[19]),.MLP_2(Multiplier[20]),.MLP_3(Multiplier[21]),.PP_out(PP11));
  Partial_product  n12(.Multiplicand(Multiplicand),.MLP_1(Multiplier[21]),.MLP_2(Multiplier[22]),.MLP_3(Multiplier[23]),.PP_out(PP12));
  Partial_product  n13(.Multiplicand(Multiplicand),.MLP_1(Multiplier[23]),.MLP_2(Multiplier[24]),.MLP_3(Multiplier[25]),.PP_out(PP13));
  Partial_product  n14(.Multiplicand(Multiplicand),.MLP_1(Multiplier[25]),.MLP_2(Multiplier[26]),.MLP_3(Multiplier[27]),.PP_out(PP14));
  Partial_product  n15(.Multiplicand(Multiplicand),.MLP_1(Multiplier[27]),.MLP_2(Multiplier[28]),.MLP_3(Multiplier[29]),.PP_out(PP15));
  Partial_product  n16(.Multiplicand(Multiplicand),.MLP_1(Multiplier[29]),.MLP_2(Multiplier[30]),.MLP_3(Multiplier[31]),.PP_out(PP16));
  	 
endmodule

module Partial_product(Multiplicand,MLP_1,MLP_2,MLP_3,PP_out);
  
  input signed [31:0] Multiplicand;
  input MLP_1,MLP_2,MLP_3;
  
  output reg signed [32:0]PP_out;
  
  reg signed [32:0]PP_out1;
  wire signed [32:0]PP;
  reg signed [31:0]Multpcnd;
  wire Sbar;
  
  wire [94:0]P;
  wire S;

  wire D1,D2;
  wire Sel_in;
  
  always @ (Multiplicand)
    begin
      if (Multiplicand[31]==1'b1)
        Multpcnd <= ~(Multiplicand) + 1;
      else 
        Multpcnd <= Multiplicand;
    end 
    
  
  assign D1  = MLP_1 ^ MLP_2;
  assign Sel_in = ~(MLP_2 ^ MLP_3);
  assign D2 = ~(D1 | Sel_in);
  
  
 
  assign S = MLP_3;
  assign Sbar = ~S;
  
 
andgate ppg0(.a(D1),.b(Multpcnd[0]),.y(P[0]));
xorgate ppg1(.a(P[0]),.b(S),.y(PP[0]));


andgate ppg2(.a(D1),.b(Multpcnd[1]),.y(P[1]));
andgate ppg3(.a(D2),.b(Multpcnd[0]),.y(P[2]));
orgate  ppg4(.a(P[1]),.b(P[2]),.y(P[3]));
xorgate ppg5(.a(P[3]),.b(S),.y(PP[1]));


andgate ppg6(.a(D1),.b(Multpcnd[2]),.y(P[4]));
andgate ppg7(.a(D2),.b(Multpcnd[1]),.y(P[5]));
orgate  ppg8(.a(P[4]),.b(P[5]),.y(P[6]));
xorgate ppg9(.a(P[6]),.b(S),.y(PP[2])); 

andgate ppg10(.a(D1),.b(Multpcnd[3]),.y(P[7]));
andgate ppg11(.a(D2),.b(Multpcnd[2]),.y(P[8]));
orgate  ppg12(.a(P[7]),.b(P[8]),.y(P[9]));
xorgate ppg13(.a(P[9]),.b(S),.y(PP[3])); 

andgate ppg14(.a(D1),.b(Multpcnd[4]),.y(P[10]));
andgate ppg15(.a(D2),.b(Multpcnd[3]),.y(P[11]));
orgate  ppg16(.a(P[10]),.b(P[11]),.y(P[12]));
xorgate ppg17(.a(P[12]),.b(S),.y(PP[4])); 

andgate ppg18(.a(D1),.b(Multpcnd[5]),.y(P[13]));
andgate ppg19(.a(D2),.b(Multpcnd[4]),.y(P[14]));
orgate  ppg20(.a(P[13]),.b(P[14]),.y(P[15]));
xorgate ppg21(.a(P[15]),.b(S),.y(PP[5])); 

andgate ppg22(.a(D1),.b(Multpcnd[6]),.y(P[16]));
andgate ppg23(.a(D2),.b(Multpcnd[5]),.y(P[17]));
orgate  ppg24(.a(P[16]),.b(P[17]),.y(P[18]));
xorgate ppg25(.a(P[18]),.b(S),.y(PP[6])); 

andgate ppg26(.a(D1),.b(Multpcnd[7]),.y(P[19]));
andgate ppg27(.a(D2),.b(Multpcnd[6]),.y(P[20]));
orgate  ppg28(.a(P[19]),.b(P[20]),.y(P[21]));
xorgate ppg29(.a(P[21]),.b(S),.y(PP[7])); 

andgate ppg30(.a(D1),.b(Multpcnd[8]),.y(P[22]));
andgate ppg31(.a(D2),.b(Multpcnd[7]),.y(P[23]));
orgate  ppg32(.a(P[22]),.b(P[23]),.y(P[24]));
xorgate ppg33(.a(P[24]),.b(S),.y(PP[8])); 

andgate ppg34(.a(D1),.b(Multpcnd[9]),.y(P[25]));
andgate ppg35(.a(D2),.b(Multpcnd[8]),.y(P[26]));
orgate  ppg36(.a(P[25]),.b(P[26]),.y(P[27]));
xorgate ppg37(.a(P[27]),.b(S),.y(PP[9])); 

andgate ppg38(.a(D1),.b(Multpcnd[10]),.y(P[28]));
andgate ppg39(.a(D2),.b(Multpcnd[9]),.y(P[29]));
orgate  ppg40(.a(P[28]),.b(P[29]),.y(P[30]));
xorgate ppg41(.a(P[30]),.b(S),.y(PP[10])); 

andgate ppg42(.a(D1),.b(Multpcnd[11]),.y(P[31]));
andgate ppg43(.a(D2),.b(Multpcnd[10]),.y(P[32]));
orgate  ppg44(.a(P[31]),.b(P[32]),.y(P[33]));
xorgate ppg45(.a(P[33]),.b(S),.y(PP[11])); 

andgate ppg46(.a(D1),.b(Multpcnd[12]),.y(P[34]));
andgate ppg47(.a(D2),.b(Multpcnd[11]),.y(P[35]));
orgate  ppg48(.a(P[34]),.b(P[35]),.y(P[36]));
xorgate ppg49(.a(P[36]),.b(S),.y(PP[12])); 

andgate ppg50(.a(D1),.b(Multpcnd[13]),.y(P[37]));
andgate ppg51(.a(D2),.b(Multpcnd[12]),.y(P[38]));
orgate  ppg52(.a(P[37]),.b(P[38]),.y(P[39]));
xorgate ppg53(.a(P[39]),.b(S),.y(PP[13])); 

andgate ppg54(.a(D1),.b(Multpcnd[14]),.y(P[40]));
andgate ppg55(.a(D2),.b(Multpcnd[13]),.y(P[41]));
orgate  ppg56(.a(P[40]),.b(P[41]),.y(P[42]));
xorgate ppg57(.a(P[42]),.b(S),.y(PP[14])); 

andgate ppg58(.a(D1),.b(Multpcnd[15]),.y(P[43]));
andgate ppg59(.a(D2),.b(Multpcnd[14]),.y(P[44]));
orgate  ppg60(.a(P[43]),.b(P[44]),.y(P[45]));
xorgate ppg61(.a(P[45]),.b(S),.y(PP[15])); 

andgate ppg62(.a(D1),.b(Multpcnd[16]),.y(P[46]));
andgate ppg63(.a(D2),.b(Multpcnd[15]),.y(P[47]));
orgate  ppg64(.a(P[46]),.b(P[47]),.y(P[48]));
xorgate ppg65(.a(P[48]),.b(S),.y(PP[16])); 

andgate ppg66(.a(D1),.b(Multpcnd[17]),.y(P[49]));
andgate ppg67(.a(D2),.b(Multpcnd[16]),.y(P[50]));
orgate  ppg68(.a(P[49]),.b(P[50]),.y(P[51]));
xorgate ppg69(.a(P[51]),.b(S),.y(PP[17])); 

andgate ppg70(.a(D1),.b(Multpcnd[18]),.y(P[52]));
andgate ppg71(.a(D2),.b(Multpcnd[17]),.y(P[53]));
orgate  ppg72(.a(P[52]),.b(P[53]),.y(P[54]));
xorgate ppg73(.a(P[54]),.b(S),.y(PP[18])); 

andgate ppg74(.a(D1),.b(Multpcnd[19]),.y(P[55]));
andgate ppg75(.a(D2),.b(Multpcnd[18]),.y(P[56]));
orgate  ppg76(.a(P[55]),.b(P[56]),.y(P[57]));
xorgate ppg77(.a(P[57]),.b(S),.y(PP[19])); 

andgate ppg78(.a(D1),.b(Multpcnd[20]),.y(P[58]));
andgate ppg79(.a(D2),.b(Multpcnd[19]),.y(P[59]));
orgate  ppg80(.a(P[58]),.b(P[59]),.y(P[60]));
xorgate ppg81(.a(P[60]),.b(S),.y(PP[20]));

andgate ppg82(.a(D1),.b(Multpcnd[21]),.y(P[61]));
andgate ppg83(.a(D2),.b(Multpcnd[20]),.y(P[62]));
orgate  ppg84(.a(P[61]),.b(P[62]),.y(P[63]));
xorgate ppg85(.a(P[63]),.b(S),.y(PP[21])); 

andgate ppg86(.a(D1),.b(Multpcnd[22]),.y(P[64]));
andgate ppg87(.a(D2),.b(Multpcnd[21]),.y(P[65]));
orgate  ppg88(.a(P[64]),.b(P[65]),.y(P[66]));
xorgate ppg89(.a(P[66]),.b(S),.y(PP[22])); 

andgate ppg90(.a(D1),.b(Multpcnd[23]),.y(P[67]));
andgate ppg91(.a(D2),.b(Multpcnd[22]),.y(P[68]));
orgate  ppg92(.a(P[67]),.b(P[68]),.y(P[69]));
xorgate ppg93(.a(P[69]),.b(S),.y(PP[23])); 

andgate ppg94(.a(D1),.b(Multpcnd[24]),.y(P[70]));
andgate ppg95(.a(D2),.b(Multpcnd[23]),.y(P[71]));
orgate  ppg96(.a(P[70]),.b(P[71]),.y(P[72]));
xorgate ppg97(.a(P[72]),.b(S),.y(PP[24])); 

andgate ppg98(.a(D1),.b(Multpcnd[25]),.y(P[73]));
andgate ppg99(.a(D2),.b(Multpcnd[24]),.y(P[74]));
orgate  pg1(.a(P[73]),.b(P[74]),.y(P[75]));
xorgate pg2(.a(P[75]),.b(S),.y(PP[25])); 

andgate pg3(.a(D1),.b(Multpcnd[26]),.y(P[76]));
andgate pg4(.a(D2),.b(Multpcnd[25]),.y(P[77]));
orgate  pg5(.a(P[76]),.b(P[77]),.y(P[78]));
xorgate pg6(.a(P[78]),.b(S),.y(PP[26])); 

andgate pg7(.a(D1),.b(Multpcnd[27]),.y(P[79]));
andgate pg8(.a(D2),.b(Multpcnd[26]),.y(P[80]));
orgate  pg9(.a(P[79]),.b(P[80]),.y(P[81]));
xorgate pg10(.a(P[81]),.b(S),.y(PP[27]));

andgate pg11(.a(D1),.b(Multpcnd[28]),.y(P[82]));
andgate pg12(.a(D2),.b(Multpcnd[27]),.y(P[83]));
orgate  pg13(.a(P[82]),.b(P[83]),.y(P[84]));
xorgate pg14(.a(P[84]),.b(S),.y(PP[28])); 

andgate pg15(.a(D1),.b(Multpcnd[29]),.y(P[85]));
andgate pg16(.a(D2),.b(Multpcnd[28]),.y(P[86]));
orgate  pg17(.a(P[85]),.b(P[86]),.y(P[87]));
xorgate pg18(.a(P[87]),.b(S),.y(PP[29]));  

andgate pg19(.a(D1),.b(Multpcnd[30]),.y(P[88]));
andgate pg20(.a(D2),.b(Multpcnd[29]),.y(P[89]));
orgate  pg21(.a(P[88]),.b(P[89]),.y(P[90]));
xorgate pg22(.a(P[90]),.b(S),.y(PP[30])); 

andgate pg23(.a(D1),.b(Multpcnd[31]),.y(P[91]));
andgate pg24(.a(D2),.b(Multpcnd[30]),.y(P[92]));
orgate  pg25(.a(P[91]),.b(P[92]),.y(P[93]));
xorgate pg26(.a(P[93]),.b(S),.y(PP[31])); 

andgate pg27(.a(D2),.b(Multpcnd[31]),.y(P[94]));
xorgate pg28(.a(P[94]),.b(S),.y(PP[32]));



   

  always @(MLP_1,MLP_2,MLP_3,PP)
    begin
     case({MLP_3,MLP_2,MLP_1})
        
        3'b000: PP_out1 = PP ;
        3'b001: PP_out1 = PP ;
        3'b010: PP_out1 = PP ;
        3'b011: PP_out1 = PP ;
        3'b100: PP_out1 = PP + 1'b1;
        3'b101: PP_out1 = PP + 1'b1;
        3'b110: PP_out1 = PP + 1'b1;
        3'b111: PP_out1 = PP + 1'b1;
   endcase
 end
 always @ (PP_out1,Multiplicand)
  begin
     if (Multiplicand[31]==1'b1)
       PP_out <= ~(PP_out1) + 1;
     else
       PP_out <= PP_out1;
  end
endmodule  

module adder_32bits(A,B,C,D,E,F,G,H,A1,B1,C1,D1,E1,F1,G1,H1,Sum);
  
  
  input signed [32:0] A;
  input signed [32:0] C;
  input signed [32:0] B;
  input signed [32:0] D;
  input signed [32:0] E;
  input signed [32:0] F;
  input signed [32:0] G;
  input signed [32:0] H,A1,B1,C1,D1,E1,F1,G1,H1;
  output signed [63:0] Sum;
  
  wire signed [34:0]out1;
  wire signed [36:0]out2;
  wire signed [38:0]out3;
  wire signed [40:0]out4;
  wire signed [42:0]out5;
  wire signed [44:0]out6;
  wire signed [46:0]out7;
  wire signed [48:0]out8;
  wire signed [50:0]out9;
  wire signed [52:0]out10;
  wire signed [54:0]out11;
  wire signed [56:0]out12;
  wire signed [58:0]out13;
  wire signed [60:0]out14;
  wire signed [62:0]out15;
  
  assign out1 = (B << 2);
  assign out2 = (C << 4);
  assign out3 = (D << 6);
  assign out4 = (E << 8);
  assign out5 = (F << 10);
  assign out6 = (G << 12);
  assign out7 = (H << 14);
  assign out8 = (A1 << 16);
  assign out9 = (B1 << 18);
  assign out10 = (C1 << 20);
  assign out11 = (D1 << 22);
  assign out12 = (E1 << 24);
  assign out13 = (F1 << 26);
  assign out14 = (G1 << 28);
  assign out15 = (H1 << 30);
  
  assign Sum = A + out1  + out2 + out3 + out4  + out5 + out6 + out7 + out8  + out9 + out10 + out11  + out12 + out13 + out14 + out15 ;
  
endmodule

//majority gate
module majority_gate(a,b,c,y);
input a,b,c;
output y;
assign y = (a&b) | (b&c) | (c&a) ;
endmodule

module xorgate(a,b,y);
input a,b;
  wire w1,w2;
output y;
majority_gate g1(.a(a),.b(b),.c(1'b1),.y(w1));
majority_gate g2(.a(a),.b(b),.c(1'b0),.y(w2));
majority_gate g3(.a(w1),.b(!w2),.c(1'b0),.y(y));
endmodule

module andgate(a,b,y);
input a,b;
output y;

majority_gate g4(.a(a),.b(b),.c(1'b0),.y(y));

endmodule

module orgate(a,b,y);
input a,b;
output y;

majority_gate g5(.a(a),.b(b),.c(1'b1),.y(y));

endmodule

module div(a,b,div1);
  input [31:0]a,b;
  output [31:0]div1;
  assign div1 = a/b;
endmodule

module and_logic(a,b,y);

input [31:0]a,b ;
output [31:0] y;

assign y= a & b ;

endmodule 

module or_logic(a,b,y);

input [31:0]a,b ;
output [31:0] y;

assign y= a | b ;

endmodule

module not1(a,y);
  input [31:0]a;
  output [31:0]y;
  assign y = ~a;
endmodule

module nand1(a,b,y);
  input [31:0]a,b;
  output [31:0]y;
  
  assign y = ~(a & b);
endmodule

module nor1(a,b,y);
  input [31:0]a,b;
  output [31:0]y;
  
  assign y = ~(a | b);
endmodule


module incr1(a,y);
  input [31:0]a;
  output [31:0]y;
  assign y = a+1;
endmodule

module decr1(a,y);
  input [31:0]a;
  output [31:0]y;
  assign y = a-1;
endmodule 

module shr1(a,y);
  input [31:0]a;
  output [31:0]y;
  assign y = a>>1;
endmodule

module shl1(b,y);
  input [31:0]b;
  output [31:0]y;
  assign y = b<<1;
endmodule

module xor1(a,b,y);
  input [31:0]a,b;
  output [31:0]y;
  
  assign y = a ^ b;
endmodule

module xnor1(a,b,y);
  input [31:0]a,b;
  output [31:0]y;
  
  assign y = ~(a ^ b);
endmodule

module mod1(a,b,y);
  input [31:0]a,b;
  output [31:0]y;
  
  assign y = a % b;
endmodule

