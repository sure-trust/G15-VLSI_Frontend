class scoreboard;
mailbox mon2sco;
reg count;
transaction tr,tr1;
function new(mailbox mon2sco);
this.mon2sco=mon2sco;
endfunction
task get_msg;
 tr1=new();
forever begin
mon2sco.get(tr);
tr1.d_in=tr.d_in;
tr1.state=tr.state;
ref_logic();
compare();
end
endtask
task ref_logic();
  case(tr1.state)
    2'b00:begin
  tr1.ss<=1'b0;
  tr1.mosi<=1'b0;
  tr1.done<=1'b0;
  tr1.state<=2'b01;
    end
  2'b01:
    begin
   tr1.ss<=1'b1;
   count<=tr1.d_in;
   tr1.done<=1'b0;
   if(count==4'b1111)
        begin
        tr1.mosi<=tr1.mosi;
        tr1.state<=2'b10;
        end
    else
      tr1.state<=2'b01;
   end
  2'b10:
    begin
      tr1.ss<=1'b1;
      tr1.done<=1'b1;
      tr1.state<=2'b11;
    end
  2'b11:
    tr1.done=1'b0;
  endcase
endtask
task compare();
  $display("scoreboard");
  if(tr1.state==tr.state) begin
$display("matched outputs");
    $display("state=%0b",tr.state);
    $display("state=%0b",tr1.state);
    end 
  else begin
$display("outputs are not matched");
 $display("state=%0b",tr.state);
    $display("state=%0b",tr1.state);
  end
endtask
endclass