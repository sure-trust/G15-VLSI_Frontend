class generator;
mailbox gen2driv;
transaction trans;
  function new(mailbox gen2driv);
        this.gen2driv=gen2driv;
  endfunction
  task put_msg;
    repeat(1) begin
        trans=new();
        trans.randomize();
        trans.display("generator");
        gen2driv.put(trans);
    end
  endtask
endclass