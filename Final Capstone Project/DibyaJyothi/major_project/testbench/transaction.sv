class transaction;
 
  randc bit [1:0] opmode; /// write = 0, read = 1, random =2
  rand bit we;
  rand bit strb;
  rand bit [7:0] addr;
  rand bit [7:0] wdata;
  bit [7:0] rdata;
  bit ack;
   
   constraint c1 {
   opmode>=0; opmode<=3;}
  
   constraint c2 {
     addr == 5;  }
  constraint c {strb==1;}
   
   constraint c3 {
    wdata > 0; wdata <= 8;}
  
    function transaction copy();
    copy       = new();
    copy.opmode  = this.opmode;
    copy.we    = this.we;
    copy.strb  = this.strb;
    copy.addr  = this.addr;
    copy.wdata = this.wdata;
    copy.rdata = this.rdata;
    copy.ack   = this.ack;
    endfunction
  
  function void display(string name);
  $display("display from %s",name);
    $display(" MODE :%0d WE : %0b STRB : %0b ADDR : %0d WDATA : %0d RDATA : %0d",opmode, we,strb,addr,wdata,rdata);
  endfunction
  
  
endclass