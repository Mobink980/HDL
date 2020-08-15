SetActiveLib -work
comp -include "$dsn\src\PRIORITY_ENCODER.vhd" 
comp -include "$dsn\src\TestBench\priority_encoder_TB.vhd" 
asim +access +r TESTBENCH_FOR_priority_encoder 
wave 
wave -noreg D
wave -noreg Q
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\priority_encoder_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_priority_encoder 
