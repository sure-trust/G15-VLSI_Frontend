class scoreboard;
  mailbox mon2sco;
  transaction trans;
  transaction trans1;
  
  function new(mailbox mon2sco);
    this.mon2sco=mon2sco;
  endfunction
  
  task get_msg;
    forever begin
      trans1=new();
      mon2sco.get(trans);
      trans1.din=trans.din;
      trans1.wr=trans.wr;
      trans1.rd=trans.rd;
      
      ref_logic();
      compare();
    end
  endtask
  
  task ref_logic();
    if(trans1.wr==1 && trans1.rd==0) begin
      trans1.fifo_mem[trans1.wr_ptr]=trans1.din;
      trans1.wr_ptr++;
      trans1.fifo_cnt++;
    end
    else if(trans1.wr==0 && trans1.rd==1) begin
      trans1.dout=trans1.fifo_mem[trans1.rd_ptr];
      trans1.rd_ptr++;
      trans1.fifo_cnt--;
    end
    
  endtask
  
  task compare();
    $display("scoreboard");
    if(trans1.dout==trans.dout)begin
      $display("din=%0d dout=%0d wr=%0b rd=%0b fifo_cnt=%0d",trans1.din,trans1.dout,trans1.wr,trans1.rd,trans1.fifo_cnt);
      $display("outputs are matched");
    end
    else begin
      $display("din=%0d dout=%0d wr=%0b rd=%0b fifo_cnt=%0d",trans1.din,trans1.dout,trans1.wr,trans1.rd,trans1.fifo_cnt);
      $display("outputs are didn't matches");
    end
  endtask
  
endclass