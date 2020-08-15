SetActiveLib -work
comp -include "$dsn\src\RAM.vhd" 
comp -include "$dsn\src\TestBench\ram_TB.vhd" 
asim +access +r TESTBENCH_FOR_ram 
wave 
wave -noreg clk
wave -noreg CS1
wave -noreg CS2
wave -noreg WE1
wave -noreg WE2
wave -noreg Addr1
wave -noreg Addr2
wave -noreg Data1
wave -noreg Data2
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\ram_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_ram 
