SetActiveLib -work
comp -include "$dsn\src\RANDOM_GENERATOR.vhd" 
comp -include "$dsn\src\TestBench\random_generator_TB.vhd" 
asim +access +r TESTBENCH_FOR_random_generator 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg interrupt
wave -noreg random_floor
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\random_generator_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_random_generator 
