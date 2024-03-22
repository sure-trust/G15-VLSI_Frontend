class scoreboard;
  transaction tx,tx_ref;
  mailbox mbx;
  function new(mailbox mon2scb);
    mbx=mon2scb;
    
  endfunction
  task run();
    repeat(1) begin
      mbx.get(tx);
      tx.display("scb");
      tx_ref=new();
      tx_ref.wr_en=tx.wr_en;
      tx_ref.rd_en=tx.rd_en;
      tx_ref.addr[1:0]=tx.addr[1:0];
      tx_ref.wdata[7:0]=tx.wdata[7:0];
      
      #1;
      
      if(tx.rdata==tx_ref.rdata)begin
        $display("----------------test pass------------");
        tx.display("actual");
        tx_ref.display("expected");
      end
      else begin
        $display("-----------test fail------------");
       tx.display("actual");
        tx_ref.display("expected");
      end
    end
  endtask
endclass
        