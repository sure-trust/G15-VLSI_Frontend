class scoreboard;
  transaction tx, tx_ref;
  mailbox mon2scb;
  function new(mailbox mon2scb);
    this.mon2scb=mon2scb;
  endfunction
  task get_msg();
    tx_ref=new();
    repeat(10) begin
      mon2scb.get(tx);
// tx.display("scb");
      tx_ref.in=tx.in;
      
      tx_ref.out<=tx_ref.out<<1;
      tx_ref.out[0]<=tx_ref.in;
      tx.out=tx_ref.out;
      


      if (tx.out==tx_ref.out) begin
        $display("----------output:%0b--------",tx_ref.out);
        $display("---- ----test pass------------");
        tx.display("actual");
        tx_ref.display("expected");
      end
      else begin
        $display("---------input:%0b---------",tx_ref.in);
        $display("--test fail------ -");
        tx.display("actual");
        tx_ref.display("expected");
      end
    end
  endtask
endclass