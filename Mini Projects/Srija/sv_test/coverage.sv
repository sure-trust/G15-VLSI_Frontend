class coverage;
  mailbox mon2cov;
  transaction trans;

  covergroup cov_g;
    in :coverpoint trans.in{
      bins b1={1'b0};
      bins b2={1'b1};
      bins b3=(1=>0);
      bins b4=(0=>1);
      illegal_bins b5={1'bz};
      ignore_bins b6={1'bx};
    }
  endgroup
  
  function new(mailbox mon2cov);
    this.mon2cov=mon2cov;
    cov_g=new();
  endfunction
  
  task cov_run;
    forever begin
      mon2cov.get(trans);
      cov_g.sample();
      $display("get coverage=%0d",cov_g.get_coverage());
    end
  endtask
endclass