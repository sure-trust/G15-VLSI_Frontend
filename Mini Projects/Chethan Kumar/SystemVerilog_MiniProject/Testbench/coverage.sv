class coverage;
  mailbox mon2cov;
  transaction trans;

  covergroup cov_g;
    
    //covering write enable
    coverpoint trans.wr_en{
      bins b1={1'b0};
      bins b2={1'b1};
    }
    
    //covering read enable
    coverpoint trans.rd_en{
      bins b1={1'b0};
      bins b2={1'b1};
    }
    
    //covering is FIFO full
    coverpoint trans.full{
      bins b1={1'b0};
      bins b2={1'b1};
    }
    
    //covering is FIFO empty
    coverpoint trans.empty{
      bins b1={1'b0};
      bins b2={1'b1};
    }
    
    //covering FIFO's read pointer did it covered all the points
    coverpoint trans.rd_ptr{
      bins b1={0};
      bins b2={1};
      bins b3={2};
      bins b4={3};
      bins b5={4};
      bins b6={5};
      bins b7={6};
      bins b8={7};
    }
    
    //covering FIFO's write pointer did it covered all the points
    coverpoint trans.wr_ptr{
      bins b1={0};
      bins b2={1};
      bins b3={2};
      bins b4={3};
      bins b5={4};
      bins b6={5};
      bins b7={6};
      bins b8={7};
    }
    
    // Covering FIFO count variable did covered all the values
    coverpoint trans.count{
      bins b1={0};
      bins b2={1};
      bins b3={2};
      bins b4={3};
      bins b5={4};
      bins b6={5};
      bins b7={6};
      bins b8={7};
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
      $display("----------------------------> [ Coverage ] = %.2f%%  <--------------------------------",cov_g.get_coverage());
      $display("............................................................................................................");
    end
  endtask
endclass