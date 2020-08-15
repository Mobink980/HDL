SetActiveLib -work
comp -include "$dsn\src\STACK.vhd" 
comp -include "$dsn\src\TestBench\stack_TB.vhd" 
asim +access +r TESTBENCH_FOR_stack 
wave 
wave -noreg CLK
wave -noreg RESET
wave -noreg PUSH
wave -noreg POP
wave -noreg DataIn
wave -noreg Stack_Empty
wave -noreg Stack_Full
wave -noreg Data
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\stack_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_stack 
