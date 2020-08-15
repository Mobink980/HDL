-------------------------------------------------------------------------------
--
-- Title       : STATE_MACHINE
-- Design      : TEN_ELEVEN_DETECTOR
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : STATE_MACHINE.vhd
-- Generated   : Tue Jul  7 12:21:38 2020
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
--{entity {STATE_MACHINE} architecture {STATE_MACHINE}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity STATE_MACHINE is
port (
	X: in std_logic;  --the input of the FSM
	rst, clk: in std_logic; --clk is the clock, and reset is the asynchronous reset	
	start: in std_logic;
	stop: in std_logic;
	
	state: out std_ulogic_vector(2 downto 0);  
	Busy: out std_logic;
	Z: out std_logic	  -- the output of the FSM
	);
end STATE_MACHINE;

--}} End of automatically maintained section


-- S0 : waiting for the start
-- S1 : got nothing
-- S2 : got 1
-- S3 : got 10
-- S4 : got 101
-- S5 : got 1011

architecture RTL of STATE_MACHINE is	

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
--signal temp: std_logic; --for saving the output
signal fsm_state: std_ulogic_vector(2 downto 0); --for saving the state of the fsm
	
begin
	-- TWO PROCESS IMPLEMENTATION
	--%%%%%%%%%%%%%%%%%%%%% SEQUENTIAL PROCESS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	process (rst, clk)
	begin		
		if (rst = '1') then  --if the reset is one, we will make the output 0 immediately!
			pr_state <= S0; --go to S0
			
		
		elsif (clk'Event and clk = '1') then --in rising edge of the clock
			pr_state <= nx_state;  --go to next state
						
			
		end if;
		
	end process;
	
	
	--%%%%%%%%%%%%%%%%%%%%% COMBINATIONAL PROCESS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	   
	process (pr_state, X)
	variable temp: std_logic := '0';
	begin	 
		  temp := temp;
		if (stop = '1') then
			temp := temp;
			Busy <= '0';
		else
			
		--using case-when statements to determine the next state as well as output
		case pr_state is
				 
			when S0 => 	
				Busy <= '0'; 
				if(start = '1') then
					nx_state <= S1;
					Busy <= '1';
				else
					nx_state <= S0;
				end if;
				
			when S1 => 
				if(X = '1') then
					nx_state <= S2;
				else
					nx_state <= S1;
				end if;	  
				
			when S2 =>

				if(X = '1') then
					nx_state <= S2;
					
				else
					nx_state <= S3;
				end if;
				
			when S3 =>
	
				if(X = '1') then
					nx_state <= S4;
				else
					nx_state <= S1;
					
				end if;	
				
			when S4 =>
			
				if(X = '1') then
					nx_state <= S5;
				else
					nx_state <= S3;
					
				end if;
				
			when S5 =>
			    temp := not temp;
				if(X = '1') then
					nx_state <= S2;
				else
					nx_state <= S3;
				
				end if;
				
			when others =>
				temp := temp;
				nx_state <= S0;
					
		end case; 
		
		end if;
		
			Z <= temp; --putting the temp signal into the port Z
		
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
	

	state <= fsm_state;	--putting the fsm_state signal into the port state
	

end architecture RTL;
