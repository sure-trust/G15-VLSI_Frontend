class scoreboard;
  mailbox mon2sco;
  transaction trans,trans1;
  
  function new(mailbox mon2sco);
    this.mon2sco=mon2sco;
  endfunction
  
  task init();
    trans1.count=0;
    trans1.wr_ptr=0;
    trans1.rd_ptr=0;
    //assign trans1.empty=(trans1.count==0);
    //assign trans1.full=(trans1.count==8);
  endtask
  
  task init_ef();
    if(trans1.count==0)
      trans1.empty=1;
    else
      trans1.empty=0;
    
    if(trans1.count==8)
      trans1.full=1;
    else
      trans1.full=0;
  endtask
  
  task get_msg;
    
    trans1=new();
    init();
    forever begin
      mon2sco.get(trans);
      //trans1.dout=trans.dout;
      trans1.din=trans.din;
      trans1.rd_en=trans.rd_en;
      trans1.wr_en=trans.wr_en;
      //trans1.full=trans.full;
      //trans1.count=trans.count;
      //trans1.empty=trans.empty;
      ref_logic();
      compare();
    end
  endtask
  
  
    
  task ref_logic();
    init_ef();
    if(trans1.wr_en==1 && trans1.rd_en==0 && !(trans1.full)) begin
        trans1.fifo_mem[trans1.wr_ptr]<=trans1.din;
        trans1.wr_ptr<=trans1.wr_ptr+1;
        trans1.count<=trans1.count+1;
      end
    else if(trans1.wr_en==0 && trans1.rd_en==1 && !(trans1.empty)) begin
        trans1.dout<=trans1.fifo_mem[trans1.rd_ptr];
        trans1.rd_ptr<=trans1.rd_ptr+1;
        trans1.count<=trans1.count-1;
      end
  endtask
  
  task compare();
    $display("Display from [ Scoreboard ]");
    if(trans1.dout==trans.dout)begin
      $display("din: %0d | dout: %0d | rd_en: %0d | wr_en: %0d | full: %0d | empty: %0d | count: %0d |rd_ptr: %0d | wr_ptr: %0d",trans1.din,trans1.dout,trans1.rd_en,trans1.wr_en,trans1.full,trans1.empty,trans1.count,trans1.rd_ptr,trans1.wr_ptr);
      $display("------------------------------------------------------------------------------------------------------------");
      $display("-----------------------------------");
      $display("------> Outputs matched <----------");
      $display("-----------------------------------");
      $display("------------------------------------------------------------------------------------------------------------");
    end
    else begin
      $display("din: %0d | dout: %0d | rd_en: %0d | wr_en: %0d | full: %0d | empty: %0d | count: %0d |rd_ptr: %0d | wr_ptr: %0d",trans1.din,trans1.dout,trans1.rd_en,trans1.wr_en,trans1.full,trans1.empty,trans1.count,trans1.rd_ptr,trans1.wr_ptr);
      $display("------------------------------------------------------------------------------------------------------------");
      $display("-----------------------------------");
      $display(">< >< >< outputs didn't matched >< >< ><");
      $display("-----------------------------------");
      $display("------------------------------------------------------------------------------------------------------------");
    end
  endtask
  
endclass