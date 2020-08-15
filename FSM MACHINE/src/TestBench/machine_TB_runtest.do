SetActiveLib -work
comp -include "$dsn\src\MACHINE.vhd" 
comp -include "$dsn\src\TestBench\machine_TB.vhd" 
asim +access +r TESTBENCH_FOR_machine 
wave 
wave -noreg IR
wave -noreg Reset
wave -noreg Clk
wave -noreg state
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\machine_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_machine 
