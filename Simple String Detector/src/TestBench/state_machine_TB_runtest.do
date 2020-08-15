SetActiveLib -work
comp -include "$dsn\src\STATE_MACHINE.vhd" 
comp -include "$dsn\src\TestBench\state_machine_TB.vhd" 
asim +access +r TESTBENCH_FOR_state_machine 
wave 
wave -noreg X
wave -noreg rst
wave -noreg clk
wave -noreg start
wave -noreg stop
wave -noreg state
wave -noreg Busy
wave -noreg Z
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\state_machine_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_state_machine 
