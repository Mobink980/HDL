SetActiveLib -work
comp -include "$dsn\src\MEMORY.vhd" 
comp -include "$dsn\src\TestBench\memory_TB.vhd" 
asim +access +r TESTBENCH_FOR_memory 
wave 
wave -noreg Address
wave -noreg Data
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\memory_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_memory 
