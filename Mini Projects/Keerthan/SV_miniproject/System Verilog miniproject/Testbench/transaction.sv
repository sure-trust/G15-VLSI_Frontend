class transaction;
  rand bit [4:0] data_input;
  rand bit [4:0] address;
   rand bit wr_en;
  bit [4:0] data_out;
  
 constraint t1 {
   wr_en inside{0,1};
}

  
  
  function void display(string name);
    $display("%s display statements:",name); $display("address=%h,wr_en=%h,data_input=%h,data_output=%h",address,wr_en,data_input,data_out);
  endfunction
  
endclass