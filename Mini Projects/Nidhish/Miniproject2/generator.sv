class generator;
  transaction tx;
  mailbox gen2drv;
  
  logic [1:0]addr;
 
  
  function new(mailbox gen2drv);
    this.gen2drv=gen2drv;
    endfunction
  
  task write();
    repeat(1) begin
      tx=new();
      tx.randomize();
      tx.wr_en=1;
      tx.rd_en=0;
      
     
      addr = tx.addr;
      
      gen2drv.put(tx);
      tx.display("GENERATOR writing");
    end
  endtask
  task read();
    repeat(1) begin
      tx=new();
      tx.wr_en=0;
      tx.rd_en=1;
      tx.addr=addr;
      gen2drv.put(tx);
      tx.display("GENERATOR reading");
    end
  endtask
  
  task read_write();
    repeat(1) begin
      tx=new();
      tx.randomize();
      tx.wr_en=1;
      tx.rd_en=0;
      addr = tx.addr;
      gen2drv.put(tx);
      tx.display("GENERATOR reading_writing wr");
    end
      
      #10 repeat(1) begin
      
      tx.wr_en=0;
      tx.rd_en=1;
      tx.addr=addr;
        
      tx.wdata=8'b0101;
      gen2drv.put(tx);
      tx.display("GENERATOR reading_writing rd");
    end
    
    
    
  endtask
  
endclass
