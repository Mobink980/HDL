SetActiveLib -work
comp -include "$dsn\src\GREY_CODE_CONVERTOR.vhd" 
comp -include "$dsn\src\TestBench\grey_code_convertor_TB.vhd" 
asim +access +r TESTBENCH_FOR_grey_code_convertor 
wave 
wave -noreg B
wave -noreg G
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\grey_code_convertor_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_grey_code_convertor 
