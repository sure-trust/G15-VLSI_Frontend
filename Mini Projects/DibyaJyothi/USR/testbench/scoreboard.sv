class scoreboard;
mailbox mon2sco;
transaction trans;
function new(mailbox mon2sco);
this.mon2sco=mon2sco;
endfunction
task get_msg;
 trans1=new();
forever begin
mon2sco.get(trans);
trans1.d=trans.d;
trans1.ctrl=trans.ctrl;
ref_logic();
compare();
end
endtask
task ref_logic();
  case(trans1.ctrl)
    2'b00:trans1.q=trans1.q;
    2'b01:trans1.q={trans.q[7:1],trans1.d[0]}; 
    2'b10:trans1.q={trans1.d[7],trans.q[6:0]};
    2'b11:trans1.q=trans1.d;
  endcase
endtask
task compare();
$display("scoreboard");
  if(trans.q==trans1.q) begin
$display("matched outputs");
$display("d=%0b,ctrl=%0b,q=%0b",trans.d,trans.ctrl,trans.q);
$display("d=%0b,ctrl=%0b,q=%0b",trans1.d,trans1.ctrl,trans1.q);
    end 
  else begin
$display("outputs are not matched");
$display("d=%0b,ctrl=%0b,q=%0b",trans.d,trans.ctrl,trans.q);
$display("d=%0b,ctrl=%0b,q=%0b",trans1.d,trans1.ctrl,trans1.q);
  end
endtask
endclass