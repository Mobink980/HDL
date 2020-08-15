SetActiveLib -work
comp -include "$dsn\src\TRIPLE_ONE.vhd" 
comp -include "$dsn\src\TestBench\triple_one_TB.vhd" 
asim +access +r TESTBENCH_FOR_triple_one 
wave 
wave -noreg d
wave -noreg reset
wave -noreg clk
wave -noreg q
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\triple_one_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_triple_one 
