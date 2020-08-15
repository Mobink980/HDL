SetActiveLib -work
comp -include "$dsn\src\MULTIPLIER.vhd" 
comp -include "$dsn\src\TestBench\multiplier_TB.vhd" 
asim +access +r TESTBENCH_FOR_multiplier 
wave 
wave -noreg A
wave -noreg B
wave -noreg F
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\multiplier_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_multiplier 
