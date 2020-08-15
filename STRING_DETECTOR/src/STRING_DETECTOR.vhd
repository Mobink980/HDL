-------------------------------------------------------------------------------
--
-- Title       : STRING_DETECTOR
-- Design      : DETECTOR
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : STRING_DETECTOR.vhd
-- Generated   : Fri May 29 20:02:42 2020
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
--{entity {STRING_DETECTOR} architecture {STRING_DETECTOR}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity STRING_DETECTOR is 
	port (
	X: in std_logic;  --the input of the FSM
	reset, clk: in std_logic; --clk is the clock, and reset is the asynchronous reset
	state: out std_ulogic_vector(2 downto 0);
	Y: out std_logic	  -- the output of the FSM
	);
end STRING_DETECTOR;

--}} End of automatically maintained section


-- S0 : got nothing
-- S1 : got 1
-- S2 : got 10
-- S3 : got 101
-- S4 : got 1010
-- S5 : got 10100

architecture RTL of STRING_DETECTOR is

subtype states is std_ulogic_vector(2 downto 0);
constant S0: states := "000"; 
constant S1: states := "001";
constant S2: states := "010";
constant S3: states := "011";
constant S4: states := "100";
constant S5: states := "101";
constant S6: states := "110";
constant S7: states := "111";

signal pr_state, nx_state: states;	
signal temp: std_logic; --for saving the output
signal fsm_state: std_ulogic_vector(2 downto 0); --for saving the state of the fsm
begin								 
	-- TWO PROCESS IMPLEMENTATION
	--%%%%%%%%%%%%%%%%%%%%% SEQUENTIAL PROCESS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	process (reset, clk)
	begin		
		if (reset = '1') then  --if the reset is one, we will make the output 0 immediately!
			pr_state <= S0; --go to S0
			
		
		elsif (clk'Event and clk = '1') then --in rising edge of the clock
			pr_state <= nx_state;  --go to next state
						
			
		end if;
		
	end process;
	
	
	--%%%%%%%%%%%%%%%%%%%%% COMBINATIONAL PROCESS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	   
	process (pr_state, X)
	begin		 
		--using case-when statements to determine the next state as well as output
		case pr_state is
			
			when S0 =>
				temp <= '0';
				if(X = '1') then
					nx_state <= S1;
				else
					nx_state <= S0;
				end if;
				
			when S1 =>
				temp <= '0'; 
				if(X = '1') then
					nx_state <= S1;
				else
					nx_state <= S2;
				end if;	  
				
			when S2 =>
				temp <= '0'; 
				if(X = '1') then
					nx_state <= S3;
					
				else
					nx_state <= S0;
				end if;
				
			when S3 =>
				temp <= '0'; 
				if(X = '1') then
					nx_state <= S1;
				else
					nx_state <= S4;
					
				end if;	
				
			when S4 =>
				temp <= '0'; 
				if(X = '1') then
					nx_state <= S3;
				else
					nx_state <= S5;
					
				end if;
				
			when S5 =>
				temp <= '1'; 
				if(X = '1') then
					nx_state <= S1;
				else
					nx_state <= S0;
				
				end if;
				
			when others =>
				temp <= '0';
				nx_state <= S0;
					
		end case;
		
	end process; 
	
	
	--%%%%%%%%%%%%%%%%%%%%% STATE DECODER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	process (pr_state)
	begin  
		case pr_state is
			when S0 =>
				fsm_state <= "000";	
			when S1 =>
				fsm_state <= "001";
			when S2 =>
				fsm_state <= "010";
			when S3 =>
				fsm_state <= "011";
			when S4 =>
				fsm_state <= "100";
			when S5 =>
				fsm_state <= "101";
			when S6 =>
				fsm_state <= "110";
			when S7 =>
				fsm_state <= "111";
			 when others =>
			 	fsm_state <= "000";
			
		end case;
		
	end process;
	
	Y <= temp; --putting the temp signal into the port Y
	state <= fsm_state;	--putting the fsm_state signal into the port state

end architecture RTL;
