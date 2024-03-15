class scoreboard;
  mailbox mon2sco;
  transaction tarr[32];
  transaction t;

  function new(mailbox mon2sco);
    this.mon2sco = mon2sco;
  endfunction

  task run();
    repeat(32) begin
      mon2sco.get(t);

      if (t.wr_en == 1'b1) begin
        if (tarr[t.address] == null) begin
          tarr[t.address] = new();
          tarr[t.address].data_input = t.data_input;
          $display("[SCO] : Data stored");
          t.display("scoreboard");
          $display("-----------------------------------------------");
        end
      end else begin
        if (tarr[t.address] == null) begin
          if (t.data_out == 8'h00) begin
            $display("[SCO] : Data read Test Passed");
            t.display("scoreboard");
            $display("-----------------------------------------------");
          end else begin
            $display("[SCO] : Data read Test Failed");
            t.display("scoreboard");
            $display("-----------------------------------------------");
          end
        end else begin
          if (t.data_out == tarr[t.address].data_input) begin
            $display("[SCO] : Data read Test Passed");
            t.display("scoreboard");
            $display("-----------------------------------------------");
          end else begin
            $display("[SCO] : Data read Test Failed");
            t.display("scoreboard");
            $display("-----------------------------------------------");
          end
        end
      end
    end
  endtask
endclass
