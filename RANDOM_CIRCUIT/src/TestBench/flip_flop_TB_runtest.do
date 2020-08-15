SetActiveLib -work
comp -include "$dsn\src\FLIP_FLOP.vhd" 
comp -include "$dsn\src\TestBench\flip_flop_TB.vhd" 
asim +access +r TESTBENCH_FOR_flip_flop 
wave 
wave -noreg clk
wave -noreg d
wave -noreg q
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\flip_flop_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_flip_flop 
