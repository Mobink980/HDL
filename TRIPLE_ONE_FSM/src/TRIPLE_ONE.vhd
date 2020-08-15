-------------------------------------------------------------------------------
--
-- Title       : TRIPLE_ONE
-- Design      : TRIPLE_ONE
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : TRIPLE_ONE.vhd
-- Generated   : Sun Apr 26 17:54:39 2020
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
--{entity {TRIPLE_ONE} architecture {TRIPLE_ONE}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity TRIPLE_ONE is 
	port (
	d: in std_logic;  --the input of the FSM
	reset, clk: in std_logic; --clk is the clock, and reset is the asynchronous reset
	q: out std_logic	  -- the output of the FSM
	);
end TRIPLE_ONE;

--}} End of automatically maintained section

architecture example of TRIPLE_ONE is
TYPE states is (state0, state1, state2, state3);
signal pr_state, nx_state: states;	
signal temp: std_logic;
begin				  
	--%%%%%%%%%%%%%%%%%%%%% LOWER SECTION (sequential)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	process (reset, clk)
	begin		
		if (reset = '1') then  --if the reset is one, we will make the output 0 immediately!
			pr_state <= state0; --go to state0
			
		
		elsif (clk'Event and clk = '1') then --in rising edge of the clock
			pr_state <= nx_state;  --go to next state
			q <= temp;			   -- put temp in the output
			
			
		end if;
		
	end process;
	
	
	--%%%%%%%%%%%%%%%%%%%%% UPPER SECTION (combinational)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	   
	process (pr_state, d)
	begin		 
		--using case-when statements to determine the next state as well as output
		case pr_state is 
			when state0 =>
				temp <= '0';
				if(d = '1') then
					nx_state <= state1;
				else
					nx_state <= state0;
				end if;
				
			when state1 =>
				temp <= '0'; 
				if(d = '1') then
					nx_state <= state2;
				else
					nx_state <= state0;
				end if;	  
				
			when state2 =>
				temp <= '0'; 
				if(d = '1') then
					nx_state <= state3;
					temp <= '1'; --we set it to one in order to prevent the delay of the next state
				else
					nx_state <= state0;
				end if;
				
			when state3 =>
				temp <= '1'; 
				if(d = '1') then
					nx_state <= state3;
				else
					nx_state <= state0;
					temp <= '0';  --we reset it in order to prevent the delay of the next state
				end if;
					
		end case;
		
	end process;
	
	 

end architecture example;
