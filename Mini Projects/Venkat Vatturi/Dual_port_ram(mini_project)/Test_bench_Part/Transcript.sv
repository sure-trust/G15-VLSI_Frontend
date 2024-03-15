(Specify +UVM_NO_RELNOTES to turn off this notice)

----GENERATOR writing------0
wr=1, rd=0, w_addr=b, w_data=dc, r_addr=xx, r_data=xx,enb=1
----DRIVER with output------1
wr=1, rd=0, w_addr=b, w_data=dc, r_addr=xx, r_data=xx,enb=1
----COLLECTED IN MOONITOR------3
wr=1, rd=0, w_addr=b, w_data=dc, r_addr=xx, r_data=xx,enb=1
----scb------3
wr=1, rd=0, w_addr=b, w_data=dc, r_addr=xx, r_data=xx,enb=1
----GENERATOR reading------54
wr=0, rd=1, w_addr=xx, w_data=xx, r_addr=b, r_data=xx,enb=1
----DRIVER with output------55
wr=0, rd=1, w_addr=xx, w_data=xx, r_addr=b, r_data=xx,enb=1
----COLLECTED IN MOONITOR------57
wr=0, rd=1, w_addr=xx, w_data=xx, r_addr=b, r_data=dc,enb=1
----scb------57
wr=0, rd=1, w_addr=xx, w_data=xx, r_addr=b, r_data=dc,enb=1
----GENERATOR reading_writing wr------108
wr=1, rd=0, w_addr=6, w_data=87, r_addr=xx, r_data=xx,enb=1
----DRIVER with output------109
wr=1, rd=0, w_addr=6, w_data=87, r_addr=xx, r_data=xx,enb=1
----COLLECTED IN MOONITOR------111
wr=1, rd=0, w_addr=6, w_data=87, r_addr=xx, r_data=dc,enb=1
----scb------111
wr=1, rd=0, w_addr=6, w_data=87, r_addr=xx, r_data=dc,enb=1
----GENERATOR reading_writing rd------118
wr=0, rd=1, w_addr=6, w_data=87, r_addr=6, r_data=xx,enb=1
----DRIVER with output------119
wr=0, rd=1, w_addr=6, w_data=87, r_addr=6, r_data=xx,enb=1
----COLLECTED IN MOONITOR------131
wr=0, rd=1, w_addr=6, w_data=87, r_addr=6, r_data=87,enb=1
----scb------131
wr=0, rd=1, w_addr=6, w_data=87, r_addr=6, r_data=87,enb=1
$finish called from file "testbench.sv", line 18.
$finish at simulation time                 1010
           V C S   S i m u l a t i o n   R e p o r t 
Time: 1010 ns
CPU Time:      0.820 seconds;       Data structure size:   0.2Mb
Fri Mar 15 09:46:02 2024
Finding VCD file...
./dump.vcd
[2024-03-15 13:46:02 UTC] Opening EPWave...
Done