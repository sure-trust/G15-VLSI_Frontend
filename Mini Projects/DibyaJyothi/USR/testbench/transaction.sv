class transaction;
rand bit[7:0]d;
rand bit [1:0]ctrl;
bit [7:0]q;
  //constraint c1{ctrl==0;};
  constraint c1{ctrl==1;};
  //constraint c1{ctrl==2;};
  //constraint c1{ctrl==3;};
  function void display(string name);
    $display("display from %s",name);
    $display("d=%0b,ctrl=%0b,q=%0b",d,ctrl,q);
endfunction
 
endclass