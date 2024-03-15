class transaction;
  rand logic [7:0] w_data;
  logic enb=1;
  logic wr;
  logic rd;
  rand logic [4:0] w_addr;
  logic [4:0] r_addr;
  logic [7:0] r_data;;
  constraint w_addr1 {w_addr <= 16'h000f;}
  
  function void display(string name);
    $display("----%s------%0t",name,$time);
    $display("wr=%0h, rd=%0h, w_addr=%0h, w_data=%0h, r_addr=%0h, r_data=%0h,enb=%0b", wr, rd, w_addr, w_data, r_addr, r_data, enb);
  endfunction
endclass