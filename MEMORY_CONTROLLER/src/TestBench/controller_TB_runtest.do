SetActiveLib -work
comp -include "$dsn\src\CONTROLLER.vhd" 
comp -include "$dsn\src\TestBench\controller_TB.vhd" 
asim +access +r TESTBENCH_FOR_controller 
wave 
wave -noreg CLK
wave -noreg RST
wave -noreg WriteEn
wave -noreg DataIn
wave -noreg ReadEn
wave -noreg DataOut
wave -noreg Empty
wave -noreg Full
wave -noreg Data1
wave -noreg Data2
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\controller_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_controller 
