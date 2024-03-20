///////////////////////	FSM SEQ DETECTOR 0110/////////////////////////////////////////////////////////
module seq0110(input bit clk, rst, a, output out);
  bit [3:0] st, n_st;

  always @(posedge clk or negedge rst) begin
    if (!rst) begin 
      st <= 4'h1;
    end
    else begin
      st <= n_st;
    end
  end

  always @(st or a) begin
    case(st)
      4'h1: begin
        if (a == 0) n_st = 4'h2;
        else n_st = 4'h1;
      end
      4'h2: begin
        if (a== 1) n_st = 4'h3;
        else n_st = 4'h2;
      end
      4'h3: begin
        if (a == 1) n_st = 4'h4;
        else n_st = 4'h2;
      end
      4'h4: begin
        if (a == 0) n_st = 4'h1; 
        else n_st = 4'h1;
      end
      default: n_st = 4'h1;
    endcase
  end

  assign out = (st == 4'h4) && (a == 0) ? 1 : 0;
endmodule

//TEST BENCH
module tb();
  reg clk, reset, a;
  wire out;

  seq0110 d(clk, reset, a, out);
  initial clk = 0;
  always #2 clk = ~clk;

  initial begin
    a = 0;
    #1 reset = 0;
    #2 reset = 1;
    

    #4 a = 0;
    #4 a = 1;
    #4 a = 1;
    #4 a = 0;
    
     #4 a = 1;
    #4 a = 1;
    #4 a = 1;
    #4 a = 0;
    
     #4 a = 1;
    #4 a = 1;
    #4 a = 0;
    #4 a = 0;

    
    
    $finish;
  end

  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
endmodule
