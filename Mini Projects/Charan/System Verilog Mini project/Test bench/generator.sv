 class generator;
  mailbox gen2driv;
  transaction trans;
  
  function new(mailbox gen2driv);
    this.gen2driv=gen2driv;
  endfunction
  
  task put_msg;
    repeat(5)begin
      trans=new();
      trans.randomize() with {wr==1 && rd==0;din inside{[0:225]};};
      trans.display("generator");
      gen2driv.put(trans);
    end
    repeat(5)begin
      trans=new();
      trans.randomize() with {wr==0 && rd==1;din inside{[0:225]};};
      trans.display("generator");
      gen2driv.put(trans);
    end
    
  endtask
endclass