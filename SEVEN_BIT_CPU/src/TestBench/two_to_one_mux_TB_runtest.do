SetActiveLib -work
comp -include "$dsn\src\TWO_TO_ONE_MUX.vhd" 
comp -include "$dsn\src\TestBench\two_to_one_mux_TB.vhd" 
asim +access +r TESTBENCH_FOR_two_to_one_mux 
wave 
wave -noreg I0
wave -noreg I1
wave -noreg S
wave -noreg Y
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\two_to_one_mux_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_two_to_one_mux 
