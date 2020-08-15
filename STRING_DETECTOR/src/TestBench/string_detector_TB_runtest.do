SetActiveLib -work
comp -include "$dsn\src\STRING_DETECTOR.vhd" 
comp -include "$dsn\src\TestBench\string_detector_TB.vhd" 
asim +access +r TESTBENCH_FOR_string_detector 
wave 
wave -noreg X
wave -noreg reset
wave -noreg clk
wave -noreg state
wave -noreg Y
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\string_detector_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_string_detector 
