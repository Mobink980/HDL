SetActiveLib -work
comp -include "$dsn\src\PRODUCTOR.vhd" 
comp -include "$dsn\src\TestBench\productor_TB.vhd" 
asim +access +r TESTBENCH_FOR_productor 
wave 
wave -noreg A
wave -noreg B
wave -noreg F
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\productor_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_productor 
