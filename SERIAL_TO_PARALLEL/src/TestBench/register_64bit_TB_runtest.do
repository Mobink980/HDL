SetActiveLib -work
comp -include "$dsn\src\Register_64bit.vhd" 
comp -include "$dsn\src\TestBench\register_64bit_TB.vhd" 
asim +access +r TESTBENCH_FOR_register_64bit 
wave 
wave -noreg Clk
wave -noreg Reset
wave -noreg Load
wave -noreg ShL
wave -noreg ShR
wave -noreg D
wave -noreg Q
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\register_64bit_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_register_64bit 
