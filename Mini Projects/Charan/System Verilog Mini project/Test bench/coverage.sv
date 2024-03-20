class coverage;
  mailbox mon2cov;
  transaction trans;

  covergroup cov_g;
    
    
    coverpoint trans.wr{
      bins b1={1'b0};
      bins b2={1'b1};
    }
    
    
    coverpoint trans.rd{
      bins b1={1'b0};
      bins b2={1'b1};
    }
    

    coverpoint trans.full{
      bins b1={1'b0};
      bins b2={1'b1};
    }
    
  
    coverpoint trans.empty{
      bins b1={1'b0};
      bins b2={1'b1};
    }
    
   
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
    
   
    coverpoint trans.fifo_cnt{
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