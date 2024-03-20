 import uvm_pkg::*;
`include "uvm_macros.svh"


`include "transaction.sv"
`include "apb_sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "subscriber.sv"
`include "environment.sv"
`include "apb_test.sv"

module test;

   logic pclk;
   logic rst_n;
   logic [31:0] paddr;
   logic        psel;
   logic        penable;
   logic        pwrite;
   logic [31:0] prdata;
   logic [31:0] pwdata;
  
   dut_if apb_if();
  
   apb_slave dut(.dif(apb_if));

   initial begin
      apb_if.pclk=0;
   end

   
   always begin
      #10 apb_if.pclk = ~apb_if.pclk;
   end
 
  initial begin
    apb_if.rst_n=0;
    repeat (1) @(posedge apb_if.pclk);
    apb_if.rst_n=1;
    apb_if.penable=0;
  end
  always begin
    apb_if.psel=1;
    repeat (1) @(posedge apb_if.pclk);
    apb_if.penable=1;
    repeat (1) @(posedge apb_if.pclk);
    repeat (1) @(posedge apb_if.pclk);
    apb_if.psel=0;
    apb_if.penable=0;
    
    
  end
 
  initial begin
    
    uvm_config_db#(virtual dut_if)::set( null, "uvm_test_top", "vif", apb_if);
   
    run_test("apb_base_test");
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
///////////////////////////////////////////////transaction.sv ////////////////////////////////////
class transaction extends uvm_sequence_item;
  
  
  
  //typedef for READ/Write transaction type
  typedef enum {READ, WRITE} kind_e;
  rand bit   [31:0] addr;       
  rand bit [31:0] data;     
   bit psel;
   bit penable;
  rand kind_e  pwrite;      
  
  `uvm_object_utils_begin(transaction)
  `uvm_field_int(addr,UVM_ALL_ON)
  `uvm_field_int(data,UVM_ALL_ON)
  `uvm_field_int(psel,UVM_ALL_ON)
  `uvm_field_int(penable,UVM_ALL_ON)
  `uvm_field_enum(kind_e,pwrite,UVM_DEFAULT)
  `uvm_object_utils_end
  constraint c1{addr[31:0]>=32'd0; addr[31:0] <32'd256;};
  constraint c2{data[31:0]>=32'd0; data[31:0] <32'd256;};
  
  
  
  function new (string name = "transaction");
    super.new(name);
  endfunction
  
  function string convert2string();
    return $psprintf("pwrite=%s paddr=%0h data=%0h",pwrite,addr,data);
  endfunction
  
endclass
/////////////////////apb_sequence.sv/////////////////////
class apb_sequence extends uvm_sequence#(transaction);
 
  `uvm_object_utils(apb_sequence)
  

  
  function new (string name = "");
    super.new(name);
  endfunction
  
  task body();
    transaction rw_trans;
   
   
    repeat (80) begin
      rw_trans=new();
      rw_trans.c1.constraint_mode(1);
       rw_trans.c2.constraint_mode(1);
      start_item(rw_trans);
      assert(rw_trans.randomize());
     
      finish_item(rw_trans);
    end
  endtask
endclass
//////////////////////////sequencer.sv///////////////////////////

class sequencer extends uvm_sequencer#(transaction);
  
  `uvm_component_utils(sequencer)
  
  function new ( string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
endclass
////////////////////////driver.sv/////////////////////
class driver extends uvm_driver#(transaction);
  
  `uvm_component_utils(driver)
  
  virtual dut_if vif;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual dut_if)::get(this,"","vif",vif)) begin
      `uvm_error("build_phase","driver virtual interface failed")
    end
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    this.vif.master_cb.psel    <= 0;
    this.vif.master_cb.penable <= 0;

    forever begin
      transaction tr;
      @ (this.vif.master_cb);
      //First get an item from sequencer
      seq_item_port.get_next_item(tr);
      @ (this.vif.master_cb);
      uvm_report_info("APB_DRIVER ", $psprintf("Got Transaction %s",tr.convert2string()));
      //Decode the APB Command and call either the read/write function
      case (tr.pwrite)
        transaction::READ:  drive_read(tr.addr, tr.data);  
        transaction::WRITE: drive_write(tr.addr, tr.data);
      endcase
      //Handshake DONE back to sequencer
      seq_item_port.item_done();
    end
  endtask
  
  virtual protected task drive_read(input  bit   [31:0] addr, output logic [31:0] data);
    this.vif.master_cb.paddr   <= addr;
    this.vif.master_cb.pwrite  <= 0;
    this.vif.master_cb.psel    <= 1;
    @ (this.vif.master_cb);
    this.vif.master_cb.penable <= 1;
    @ (this.vif.master_cb);
    data = this.vif.master_cb.prdata;
    this.vif.master_cb.psel    <= 0;
    this.vif.master_cb.penable <= 0;
  endtask

  virtual protected task drive_write(input bit [31:0] addr, input bit [31:0] data);
    this.vif.master_cb.paddr   <= addr;
    this.vif.master_cb.pwdata  <= data;
    this.vif.master_cb.pwrite  <= 1;
    this.vif.master_cb.psel    <= 1;
    @ (this.vif.master_cb);
    this.vif.master_cb.penable <= 1;
    @ (this.vif.master_cb);
    this.vif.master_cb.psel    <= 0;
    this.vif.master_cb.penable <= 0;
  endtask

endclass
///////////////monitor.sv///////////////////
class monitor extends uvm_monitor;

  virtual dut_if vif;
 
  uvm_analysis_port#(transaction) ap;

  `uvm_component_utils(monitor)

   function new(string name, uvm_component parent);
     super.new(name, parent);
     ap = new("ap", this);
   endfunction

    function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     if (!uvm_config_db#(virtual dut_if)::get(this, "", "vif", vif)) begin
       `uvm_error("build_phase", "No virtual interface specified for this monitor instance")
       end
   endfunction

   virtual task run_phase(uvm_phase phase);
     super.run_phase(phase);
     forever begin
       transaction tr;
       // Wait for a SETUP cycle
       do begin
         @ (this.vif.monitor_cb);
         end
         while (this.vif.monitor_cb.psel !== 1'b1 ||
                this.vif.monitor_cb.penable !== 1'b0);
         //create a transaction object
         tr = transaction::type_id::create("tr", this);
        
         //populate fields based on values seen on interface
       tr.pwrite = (this.vif.monitor_cb.pwrite) ? transaction::WRITE : transaction::READ;
         tr.addr = this.vif.monitor_cb.paddr;

         @ (this.vif.monitor_cb);
         if (this.vif.monitor_cb.penable !== 1'b1) begin
            `uvm_error("APB", "APB protocol violation: SETUP cycle not followed by ENABLE cycle");
         end
         
       if (tr.pwrite == transaction::READ) begin
         tr.data = this.vif.monitor_cb.prdata;
       end
       else if (tr.pwrite == transaction::WRITE) begin
         tr.data = this.vif.monitor_cb.pwdata;
       end
       
         uvm_report_info("APB_MONITOR", $psprintf("Got Transaction %s",tr.convert2string()));
          ap.write(tr);
      end
   endtask

endclass
////////////////agent.sv//////////////////////
class agent extends uvm_agent;

  
   sequencer sqr;
   driver drv;
   monitor mon;

   virtual dut_if  vif;

  `uvm_component_utils_begin(agent)
      `uvm_field_object(sqr, UVM_ALL_ON)
      `uvm_field_object(drv, UVM_ALL_ON)
      `uvm_field_object(mon, UVM_ALL_ON)
   `uvm_component_utils_end
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   
   virtual function void build_phase(uvm_phase phase);
      sqr = sequencer::type_id::create("sqr", this);
      drv = driver::type_id::create("drv", this);
      mon = monitor::type_id::create("mon", this);
      
     if (!uvm_config_db#(virtual dut_if)::get(this, "", "vif", vif)) begin
       `uvm_fatal("build phase", "No virtual interface specified for this agent instance")
      end
     uvm_config_db#(virtual dut_if)::set( this, "sqr", "vif", vif);
     uvm_config_db#(virtual dut_if)::set( this, "drv", "vif", vif);
     uvm_config_db#(virtual dut_if)::set( this, "mon", "vif", vif);
   endfunction

   
   virtual function void connect_phase(uvm_phase phase);
      drv.seq_item_port.connect(sqr.seq_item_export);
     uvm_report_info("APB_AGENT", "connect_phase, Connected driver to sequencer");
   endfunction
endclass
/////////////////////environment.sv//////////////////////
class environment  extends uvm_env;
 
  `uvm_component_utils(environment);

    
   agent  agt;
   scoreboard scb;
   subscriber sub;
  
    
   virtual dut_if  vif;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   
   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     agt = agent::type_id::create("agt", this);
     scb = scoreboard::type_id::create("scb", this);
     sub=subscriber::type_id::create("sub",this);
     if (!uvm_config_db#(virtual dut_if)::get(this, "", "vif", vif)) begin
       `uvm_fatal("build phase", "No virtual interface specified for this env instance")
     end
     uvm_config_db#(virtual dut_if)::set( this, "agt", "vif", vif);
   endfunction
  
   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     agt.mon.ap.connect(scb.mon_export);
     agt.mon.ap.connect(sub.analysis_export);
   endfunction
endclass
///////////////////////////////////scorebaord.sv//////////////////
class scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(scoreboard)
  
  uvm_analysis_imp#(transaction, scoreboard) mon_export;
  
  transaction exp_queue[$];
  
  bit [31:0] sc_mem [0:256];
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
    mon_export = new("mon_export", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    foreach(sc_mem[i]) sc_mem[i] = i;
  endfunction
  

  function void write(transaction tr);
  
    exp_queue.push_back(tr);
  endfunction 
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    transaction expdata;
    
    forever begin
      wait(exp_queue.size() > 0);
      expdata = exp_queue.pop_front();
      
      if(expdata.pwrite ==  transaction::WRITE) begin
        sc_mem[expdata.addr] = expdata.data;
        `uvm_info("APB_SCOREBOARD",$sformatf("------ :: WRITE DATA       :: ------"),UVM_LOW)
        `uvm_info("",$sformatf("Addr: %0h",expdata.addr),UVM_LOW)
        `uvm_info("",$sformatf("Data: %0h",expdata.data),UVM_LOW)        
      end
      else if(expdata.pwrite == transaction::READ) begin
        if(sc_mem[expdata.addr] == expdata.data) begin
          `uvm_info("APB_SCOREBOARD",$sformatf("------ :: READ DATA Match :: ------"),UVM_LOW)
          `uvm_info("",$sformatf("Addr: %0h",expdata.addr),UVM_LOW)
          `uvm_info("",$sformatf("Expected Data: %0h Actual Data: %0h",sc_mem[expdata.addr],expdata.data),UVM_LOW)
        end
        else begin
          `uvm_error("APB_SCOREBOARD","------ :: READ DATA MisMatch :: ------")
          `uvm_info("",$sformatf("Addr: %0h",expdata.addr),UVM_LOW)
          `uvm_info("",$sformatf("Expected Data: %0h Actual Data: %0h",sc_mem[expdata.addr],expdata.data),UVM_LOW)
        end
      end
    end
  endtask 
  
endclass
/////////////////subscriber.sv/////////////////////
class subscriber extends uvm_subscriber#(transaction);
  
  `uvm_component_utils(subscriber)
  
  bit [31:0] addr;
  bit [31:0] data;
  bit psel;
  bit penable;
  
  
  covergroup cover_bus;
    coverpoint addr {
      bins a[16] = {[0:255]};
    }
    coverpoint data {
      bins d[16] = {[0:255]};
    }
    
  endgroup
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
    cover_bus=new;
  endfunction
  
  function void write(transaction t);
    `uvm_info("APB_SUBSCRIBER", $psprintf("Subscriber received tx %s", t.convert2string()), UVM_NONE);
   
    addr    = t.addr;
    data    = t.data;
    psel=t.psel;
    penable=t.penable;
    cover_bus.sample();
    $display("Coverage Percentage: %.2f%%", cover_bus.get_inst_coverage());
  endfunction
  
endclass
///////////////apb_test.sv///////////////////

class apb_base_test extends uvm_test;

 
  `uvm_component_utils(apb_base_test);
  
  environment  env;
  virtual dut_if vif;
  
  function new(string name = "apb_base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  
  function void build_phase(uvm_phase phase);
    env = environment::type_id::create("env", this);
  
    if (!uvm_config_db#(virtual dut_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("build_phase", "No virtual interface specified for this test instance")
    end 
    uvm_config_db#(virtual dut_if)::set( this, "env", "vif", vif);
  endfunction

 
  task run_phase( uvm_phase phase );
    apb_sequence apb_seq;
    apb_seq = apb_sequence::type_id::create("apb_seq");
    phase.raise_objection( this, "Starting apb_base_seqin main phase" );
    $display("%t Starting sequence apb_seq run_phase",$time);
    apb_seq.start(env.agt.sqr);
    #100ns;
    phase.drop_objection( this , "Finished apb_seq in main phase" );
  endtask
  
  
endclass
///////////run.do////////////////
vsim +access+r;
run -all;
acdb save;
acdb report -db fcover.acdb -txt -o cov.txt;
exit
