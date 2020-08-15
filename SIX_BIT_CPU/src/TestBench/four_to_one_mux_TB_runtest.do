SetActiveLib -work
comp -include "$dsn\src\FOUR_TO_ONE_MUX.vhd" 
comp -include "$dsn\src\TestBench\four_to_one_mux_TB.vhd" 
asim +access +r TESTBENCH_FOR_four_to_one_mux 
wave 
wave -noreg I0
wave -noreg I1
wave -noreg I2
wave -noreg I3
wave -noreg S0
wave -noreg S1
wave -noreg Y
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\four_to_one_mux_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_four_to_one_mux 
