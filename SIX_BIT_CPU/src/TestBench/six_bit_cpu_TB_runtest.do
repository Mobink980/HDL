SetActiveLib -work
comp -include "$dsn\src\SIX_BIT_CPU.vhd" 
comp -include "$dsn\src\TestBench\six_bit_cpu_TB.vhd" 
asim +access +r TESTBENCH_FOR_six_bit_cpu 
wave 
wave -noreg clk
wave -noreg R0
wave -noreg R1
wave -noreg R2
wave -noreg R3
wave -noreg PC
wave -noreg IR
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\six_bit_cpu_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_six_bit_cpu 
