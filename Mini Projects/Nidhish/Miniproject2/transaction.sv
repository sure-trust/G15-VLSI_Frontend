class transaction;
  rand bit rd_en;
  rand bit wr_en;
  rand bit [1:0]addr;
  rand bit [7:0]wdata;
  bit [7:0]rdata;
  
  constraint wr_rd_c {rd_en!=wr_en;};
  
  function void display(string name);
    $display("time = %d name=%s",$time,name);
    $display("addr=%0h , wr_en=%h , rd_en=%0h , wdata=%0h,rdata=%0h",addr,wr_en,rd_en,wdata,rdata);
  endfunction
  
endclass
