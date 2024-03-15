class generator;
  mailbox gen2driv;
  transaction trans;
  
  function new(mailbox gen2driv);
    this.gen2driv=gen2driv;
  endfunction
  
  task put_msg;
    repeat(8)begin
      trans=new();
      trans.randomize() with {wr_en==1 && rd_en==0;};
      trans.display("generator");
      gen2driv.put(trans);
    end
    repeat(8)begin
      trans=new();
      trans.randomize() with {wr_en==0 && rd_en==1 && din==0;};
      trans.display("[ Generator ]");
      gen2driv.put(trans);
    end
    
  endtask
endclass