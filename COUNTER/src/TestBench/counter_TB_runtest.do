SetActiveLib -work
comp -include "$dsn\src\COUNTER.vhd" 
comp -include "$dsn\src\TestBench\counter_TB.vhd" 
asim +access +r TESTBENCH_FOR_counter 
wave 
wave -noreg Clk
wave -noreg CountEn
wave -noreg Q
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\counter_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_counter 
