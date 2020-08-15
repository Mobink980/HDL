SetActiveLib -work
comp -include "$dsn\src\STPR.vhd" 
comp -include "$dsn\src\TestBench\stpr_TB.vhd" 
asim +access +r TESTBENCH_FOR_stpr 
wave 
wave -noreg X
wave -noreg start
wave -noreg clk
wave -noreg sr_clk
wave -noreg reset
wave -noreg state
wave -noreg counter
wave -noreg Y
wave -noreg finish
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\stpr_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_stpr 
