class generator;
  transaction tx;
  mailbox gen2driv;
  
  function new(mailbox gen2driv);
    this.gen2driv=gen2driv;
  endfunction
  
  task put_msg();
    repeat(10) begin
      tx=new();
      tx.in=1;
      tx.randomize();
      gen2driv.put(tx);
    end
  endtask
endclass