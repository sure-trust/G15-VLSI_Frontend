class generator;
  mailbox gen2driv;
  transaction trans;
  
  function new(mailbox gen2driv);
    this.gen2driv=gen2driv;
  endfunction
  
  task put_msg;
    
    repeat(8)begin
      trans=new();
      assert(trans.randomize() with {wr==1 && rd==0;})
        $display("Randomization succesful");
      trans.display("[ Generator ]");
      gen2driv.put(trans);
      
    end
    repeat(8)begin
      trans=new();
      assert(trans.randomize() with {wr==0 && rd==1 && din==0;})
        $display("Randomization succesful");
      trans.display("[ Generator ]");
      gen2driv.put(trans);
     
    end
    
  endtask
endclass