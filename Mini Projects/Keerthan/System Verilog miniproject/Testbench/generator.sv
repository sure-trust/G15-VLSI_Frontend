class generator;
  mailbox gen2driv;
  transaction t;
  covergroup cg_generator;
    coverpoint t.wr_en {
      bins b0 = {1'b1};
      bins b1 = {1'b0};
    }
  endgroup
  
  function new(mailbox gen2driv);
    this.gen2driv = gen2driv;
    cg_generator = new();
  endfunction

  task run();
    repeat(32) begin
      t = new();
      t.t1.constraint_mode(1);
      assert(t.randomize());
      cg_generator.sample(); 
      gen2driv.put(t);
      $display("Coverage Percentage: %.2f%%", cg_generator.get_inst_coverage());
    end
  endtask
endclass
