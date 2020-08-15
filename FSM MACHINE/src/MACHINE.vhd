-------------------------------------------------------------------------------
--
-- Title       : MACHINE
-- Design      : MACHINE
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : MACHINE.vhd
-- Generated   : Sat May 30 00:22:13 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {MACHINE} architecture {MACHINE}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MACHINE is 
port (
	IR: in std_logic_vector(1 downto 0);  --the input of the FSM
	Reset, Clk: in std_logic; --clk is the clock, and reset is the asynchronous reset
	state: out std_ulogic_vector(3 downto 0) -- the output of the FSM  
	);
end MACHINE;

--}} End of automatically maintained section

architecture RTL of MACHINE is	

subtype states is std_ulogic_vector(3 downto 0);
constant FETCH1: states := "0000"; 
constant FETCH2: states := "0001";
constant FETCH3: states := "0010";
constant ADD1:   states := "0011";
constant ADD2:   states := "0100";
constant AND1:   states := "0101";
constant AND2:   states := "0110";
constant JMP1:   states := "0111";
constant INC1:   states := "1000"; 

constant DUMMY1:   states := "1001";
constant DUMMY2:   states := "1010";
constant DUMMY3:   states := "1011";
constant DUMMY4:   states := "1100";
constant DUMMY5:   states := "1101";
constant DUMMY6:   states := "1110"; 
constant DUMMY7:   states := "1111";

signal pr_state, nx_state: states;	
signal fsm_state: std_ulogic_vector(3 downto 0); --for saving the state of the fsm
begin 
	
		-- TWO PROCESS IMPLEMENTATION
	--%%%%%%%%%%%%%%%%%%%%% SEQUENTIAL PROCESS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	process (reset, clk)
	begin		
		if (reset = '1') then  --if the reset is one, we will make the output 0 immediately!
			pr_state <= FETCH1; --go to S0
			
		
		elsif (clk'Event and clk = '1') then --in rising edge of the clock
			pr_state <= nx_state;  --go to next state
						
			
		end if;
		
	end process;
	
	
		--%%%%%%%%%%%%%%%%%%%%% COMBINATIONAL PROCESS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	   
	process (pr_state, IR)
	begin		 
		--using case-when statements to determine the next state as well as output
		case pr_state is
			
			when FETCH1 =>
				nx_state <= FETCH2;	   
			
			when FETCH2 =>
				nx_state <= FETCH3;
					
			when FETCH3 =>
				if (IR = "00") then
					nx_state <= ADD1;
					
				elsif (IR = "01") then
					nx_state <= AND1;
					
				elsif (IR = "10") then
					nx_state <= JMP1;
					
				else
					nx_state <= INC1;
					
				end if;
				
			when ADD1 =>
				nx_state <= ADD2;
			
			when AND1 => 
				nx_state <= AND2;
			
			when ADD2 =>
				nx_state <= FETCH1;
				
			when AND2 =>
				nx_state <= FETCH1;
			
			when JMP1 =>
				nx_state <= FETCH1;

			when INC1 =>
				nx_state <= FETCH1;
			 
			when others =>
				nx_state <= FETCH1;
		end case;
		
	end process; 
	
	
	--%%%%%%%%%%%%%%%%%%%%% STATE DECODER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	process (pr_state)
	begin  
		case pr_state is
			when FETCH1 =>
				fsm_state <= "0000";	
			
			when FETCH2 =>
				fsm_state <= "0001";
			
			when FETCH3 =>
				fsm_state <= "0010";
			
			when ADD1 =>
				fsm_state <= "0011";
			
			when ADD2 =>
				fsm_state <= "0100";
			
			when AND1 =>
				fsm_state <= "0101";
			
			when AND2 =>
				fsm_state <= "0110";
			
			when JMP1 =>
				fsm_state <= "0111";	  
			
			when INC1 =>
				fsm_state <= "1000";
			
			when others =>
			 	fsm_state <= "1111";
			
		end case;
		
	end process;
	
	state <= fsm_state;	--putting the fsm_state signal into the port state
	

end architecture RTL;
