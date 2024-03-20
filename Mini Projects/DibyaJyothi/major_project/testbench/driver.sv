class driver;
mailbox gen2driv;
transaction tr;
virtual intf vif;
function new(mailbox gen2driv ,virtual intf vif);
this.gen2driv=gen2driv;
this.vif=vif;
endfunction
  task reset();
   vif.we    <= 0;
   vif.addr  <= 0;
   vif.wdata <= 0;
   vif.strb  <= 0;
   $display("[DRV] : RESET DONE");
  endtask
 
  task write();
  $display("[DRV] : DATA WRITE MODE");
  vif.we    <= 1'b1;
  vif.strb  <= 1'b1;
  vif.addr  <= tr.addr;
  vif.wdata <= tr.wdata;
  @(posedge vif.ack);
  endtask
  
  task read();
  $display("[DRV] : DATA READ MODE");
  vif.rst   <= 1'b0;
  vif.we    <= 1'b0;
  vif.strb  <= 1'b1;
  vif.addr  <= tr.addr;
  @(posedge vif.ack);
  endtask
  
  task random();
  $display("[DRV] : RANDOM MODE");
  vif.we    <= tr.we;
  vif.strb  <= tr.strb;
  vif.addr  <= tr.addr;
  if(tr.we == 1'b1)
  begin
  vif.wdata <= tr.wdata;
  end
  endtask
  
  
  task get_msg();
   forever begin
     @(vif.driv_cb);
     gen2driv.get(tr);
     vif.we=tr.we;
     vif.strb=tr.strb;
     vif.addr=tr.addr;
     vif.wdata=tr.wdata;
     tr.display("driver");
     @(vif.driv_cb);
     if(tr.opmode == 0) 
     begin
       write();
     end  
     else if (tr.opmode == 1) 
     begin
       read();
     end  
     else if(tr.opmode == 2) 
     begin
       random();
     end  
   end
  endtask
  
endclass

