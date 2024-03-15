class scoreboard;
  transaction tx,tx_ref;
  mailbox mbx;
  function new(mailbox mon2scb);
    mbx=mon2scb;
  endfunction
  task run();
    repeat(1)begin
      mbx.get(tx);
      tx.display("scb");
      tx_ref=new();
      tx_ref.enb=tx.enb;
      tx_ref.wr=tx.wr;
      tx_ref.rd=tx.rd;
      tx_ref.w_addr[4:0]=tx.w_addr[4:0];
      tx_ref.r_addr[4:0]=tx.r_addr[4:0];
      tx_ref.w_data[7:0]=tx.w_data[7:0];
      
      #1;
      
    end
  endtask
endclass