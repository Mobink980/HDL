SetActiveLib -work
comp -include "$dsn\src\ELEVATOR.vhd" 
comp -include "$dsn\src\TestBench\elevator_TB.vhd" 
asim +access +r TESTBENCH_FOR_elevator 
wave 
wave -noreg clk
wave -noreg ONE_SECOND_CLOCK
wave -noreg Reset
wave -noreg start
wave -noreg pres_floor
wave -noreg targ_floor
wave -noreg trans_time
wave -noreg wait_time
wave -noreg address
wave -noreg rand_floor
wave -noreg inter
wave -noreg counter_down
wave -noreg time_initial
wave -noreg state
wave -noreg Memory_Out
wave -noreg Floor
wave -noreg Timer
wave -noreg LiftDir
wave -noreg LiftDoor
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\elevator_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_elevator 
