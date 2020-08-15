SetActiveLib -work
comp -include "$dsn\src\CIRCUIT.vhd" 
comp -include "$dsn\src\TestBench\circuit_TB.vhd" 
asim +access +r TESTBENCH_FOR_circuit 
wave 
wave -noreg Clk
wave -noreg Reset
wave -noreg lfsr_data
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\circuit_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_circuit 
