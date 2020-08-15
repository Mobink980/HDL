-------------------------------------------------------------------------------
--
-- Title       : STPR
-- Design      : SERIAL_TO_PARALLEL
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : STPR.vhd
-- Generated   : Sat May 30 01:49:28 2020
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
--{entity {STPR} architecture {STPR}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity STPR is
	port (
	X: in std_logic; -- 1-bit serial input
	start: in std_logic; --input which starts the conversion
	clk: in std_logic;	 -- clock of the whole circuit
	sr_clk: in std_logic;  -- clock of the shift register
	reset: in std_logic;   -- asynchronous reset
	
	state: out std_ulogic_vector(1 downto 0); -- an output to understand the state of our FSM
	counter: out integer;  -- an output to see the counter counting
	Y: out std_logic_vector(63 downto 0);  -- the output that we will send after 64 clock cycle
	finish: out std_logic	   -- the control output that becomes 1 when the job is done.
	);
	
end STPR;

--}} End of automatically maintained section

architecture RTL of STPR is	 
subtype states is std_logic; --defining the states of our FSM
constant S0: states := '0'; 
constant S1: states := '1';
signal pr_state, nx_state: states;

--defining helper signals to do the job of instantiation
signal Load: std_logic;
signal ShL: std_logic;
signal ShR: std_logic;
signal input: std_logic;  
signal Q: std_logic_vector(63 downto 0);
	
signal fsm_state: std_ulogic_vector(1 downto 0); --for saving the state of the fsm
signal COUNT: integer range 0 to 63; -- counter which counts from 0 to 63
signal control: integer;  -- an integer signal used to control the behavior of FSM
begin 
	
	--instantiating from our FSM
	ShiftRegister0: entity work.Register_64bit(RTL)
		port map (Clk => sr_clk, Reset => reset, ShL => ShL, ShR => ShR, Load => Load, D => input, Q => Q);
		
	--input <= x"effaaddaf4352221";
	--input <= (63 => 'Z',62 downto 0 => '0');   
	--input(63) <= '1';

	
	--%%%%%%%%%%%%%%%%%%%%% SEQUENTIAL PROCESS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	process (reset, clk)
	begin		
		if (reset = '1') then  --if the reset is one, we will make the output 0 immediately!
			pr_state <= S0; --go to S0
			
		
		elsif (clk'Event and clk = '1') then --in rising edge of the clock
			pr_state <= nx_state;  --go to next state
								
		end if;
		
	end process;
	
	

	--%%%%%%%%%%%%%%%%%%%%% SHIFT REGISTER PROCESS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	 
	--This process is used to control the behavior of shift register. The behavior is as the following:
	-- If control = 0, it means that we should operate, thus in each clock of the shift register:
		-- we load if tmp = 0 and we rigth shift if tmp = 1
	-- If control = 1, we do holding for the result of the shift register
	process(sr_clk, control)
	variable tmp: integer := 0;
	begin
		if (sr_clk'event and sr_clk = '1') then 
			if (control = 0) then	  -- control = 0 means that we are operating
				if(tmp = 0) then   --tmp = 0 means loading
					input <= X;
					Load <= '1';
					ShL <= '0';
					ShR <= '0';
					tmp := tmp + 1;
					Y <= Q;
				else 			   -- tmp = 1 means shifting right
					Load <= '0';
					ShL <= '0';
					ShR <= '1';
					tmp := tmp - 1;	
				end if;
			else 	   -- if control is not 0, it means that we must hold
				Load <= '0';
				ShL <= '0';
				ShR <= '0';
				
			end if;
				
		end if;
	end process;
	
	--%%%%%%%%%%%%%%%%%%%%% COMBINATIONAL PROCESS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
	-- In the following process we create the combinational part of our FSM
	process (pr_state, start, COUNT)
	begin		 
		--using case-when statements to determine the next state as well as output
		case pr_state is
			
			when S0 =>
				finish <= '1'; --we're not operating thus finish must be 1
				control <= 1;  -- hold the value
				if (start = '1') then
					nx_state <= S1;	--when the start is clicked, we start STPR
				else
					nx_state <= S0;	
				end if;	
				
			when S1 => 
				finish <= '0'; --we're operating thus finish must be 0
				control <= 0; -- in this state we must operate
				if (COUNT >= 63) then 
					nx_state <= S0;	--when 64 clock cycles has ended, we stop the process
				else
					nx_state <= S1;
					
				end if;
  
				
			when others => 
				finish <= '1'; -- Otherwise we finish the job and go straight to state S0
				nx_state <= S0;
				
		end case;
		
	end process; 
	
	
  	--%%%%%%%%%%%%%%%%%%%%% COUNTER PROCESS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
	  -- In this process we will run our counter (All processes are processed concurrently)
	process(clk, pr_state) 
	begin 
		  if rising_edge(clk) then
    	  	if pr_state = S0 or COUNT >= 63 then 
				 COUNT <= 0;  --reset the counter after 63, or when state is S0
    		else  
				COUNT <= COUNT + 1;
				
			end if;
  		end if; 
			  
	end process;
	
	--%%%%%%%%%%%%%%%%%%%%% STATE DECODER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
	-- The following process will work as a state decoder, showing the states our FSM is in
	-- S0 ==> 0
	-- S1 ==> 1
	-- Invalid state ==> 3
	process (pr_state)
	begin  
		case pr_state is
			when S0 =>
				fsm_state <= "00";
			
			when S1 =>
				fsm_state <= "01";
			
			when others =>
			 	fsm_state <= "11";
			
		end case;
		
	end process;
	
	state <= fsm_state;	--putting the fsm_state signal into the port state
	counter <= COUNT;

	 

end architecture RTL;

