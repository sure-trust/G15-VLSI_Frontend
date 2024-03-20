class scoreboard;
mailbox mon2sco;
transaction tr,tr1;
bit [7:0] data[256] = '{default:0};
function new(mailbox mon2sco);
this.mon2sco=mon2sco;
endfunction
task get_msg;
tr1=new();
forever begin
  mon2sco.get(tr);
  tr1.strb=tr.strb;
  tr1.we=tr.we;
  tr1.addr=tr.addr;
  tr1.wdata=tr.wdata;
  if(tr1.strb == 1'b0) 
            begin
            $display("[SCO] : INVALID STROBE");
            end
    else 
      begin
          
        if(tr1.we == 1'b1)
                      begin
                        data[tr1.addr] = tr1.wdata;
                        $display("[SCO] : DATA WRITE DATA : %0d ADDR : %0d", tr1.wdata, tr1.addr);
                      end  
          else begin
            if(tr1.rdata == 8'h11)
                     begin
                     $display("[SCO] : DATA MATCHED : DEFAULT VALUE READ");
                     end
            else if (tr1.rdata == data[tr1.addr])
                     begin
                       $display("[SCO] : DATA MATCHED DATA : %0d ADDR : %0d", tr1.wdata, tr1.addr);
                       $display("[SCO] : DATA MATCHED DATA : %0d ADDR : %0d", tr.wdata, tr.addr);
                     end
                     else
                     begin
                       $display("[SCO] : DATA MISMATCHED DATA : %0d ADDR : %0d", tr1.wdata, tr1.addr);
                       $display("[SCO] : DATA MISMATCHED DATA : %0d ADDR : %0d", tr.wdata, tr.addr);
                     end 
             end
      end    
   end
endtask
endclass