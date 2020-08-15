-------------------------------------------------------------------------------
--
-- Title       : CONTROL_UNIT
-- Design      : CPU
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : CONTROL_UNIT.vhd
-- Generated   : Thu Jul  9 22:56:03 2020
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
--{entity {CONTROL_UNIT} architecture {CONTROL_UNIT}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CONTROL_UNIT is
generic (
	AddrWidth: integer := 6;
	DataWidth: integer := 6
	); 
	
port(
	clk: 		in std_logic;
	ZR0: 		in std_logic;
	ZR1: 		in std_logic;
	ZR2: 		in std_logic;
	ZR3: 		in std_logic;
	ROUTIR: 	in std_logic_vector(DataWidth-1 downto 0);
	
	LD0: 		out std_logic;	 
	LD1: 		out std_logic;
	LD2: 		out std_logic;
	LD3: 		out std_logic;
	LDPC: 		out std_logic;
	LDIR: 		out std_logic;
	S00: 		out std_logic;
	S01: 		out std_logic;	 
	S10: 		out std_logic;
	S11: 		out std_logic;
	Bus_Sel: 	out std_logic;
	CMD: 		out std_logic;
	INC: 		out std_logic;
	RST: 		out std_logic
	
	);
end CONTROL_UNIT;

--}} End of automatically maintained section

architecture RTL of CONTROL_UNIT is	 
-- additional states are present to prevent the compiler from ignoring others (16 states)
TYPE states is (S0, LOADIR, S1, S2, S3, S4, S5, S6, S7, S8, St9, St10, St11, St12, St13, St14);
signal pr_state, nx_state: states;	
signal temp: std_logic;
begin  
	
	--%%%%%%%%%%%%%%%%%%%%% SEQUENTIAL SECTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	process (clk)
	begin			
		if (clk'Event and clk = '1') then --in rising edge of the clock
			pr_state <= nx_state;  --go to next state
						
		end if;
		
	end process;
	
	
	--%%%%%%%%%%%%%%%%%%%%% NEXT STATE LOGIC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	   
	process (pr_state, ROUTIR, ZR0, ZR1, ZR2, ZR3)
	begin		 
		--using case-when statements to determine the next state as well as output
		case pr_state is 
			
--			when start =>
--				nx_state <= S0; -- Delay state
				
			when S0 =>
				nx_state <= LOADIR; -- Fetching state
				
			when LOADIR =>
				nx_state <= S1;
				
			when S1 =>
				if (ROUTIR = "000000") then
					nx_state <= S2;
					
				else
					if (ROUTIR(5) = '0' and ROUTIR(4) = '0') then 
						nx_state <= S3; -- The Load instruction
						
					else
						if (ROUTIR(5) = '0' and ROUTIR(4) = '1') then
							nx_state <= S4; -- The Add instruction
							
						else
							if (ROUTIR(5) = '1' and ROUTIR(4) = '0') then
								nx_state <= S5; --The Sub instruction
								
							else
								if (ROUTIR(3) = '0' and ROUTIR(2) = '0') then
									-- This means that the destination register is R0
									if (ZR0 = '1') then
										nx_state <= S7;
									else
										nx_state <= S6;
									end if;
								
								elsif (ROUTIR(3) = '0' and ROUTIR(2) = '1') then
									-- This means that the destination register is R1
									if (ZR1 = '1') then
										nx_state <= S7;
									else
										nx_state <= S6;
									end if;	
									
								elsif (ROUTIR(3) = '1' and ROUTIR(2) = '0') then
									-- This means that the destination register is R2
									if (ZR2 = '1') then
										nx_state <= S7;
									else
										nx_state <= S6;
									end if;	  
									
									
									
								else
									-- This means that the destination register is R3
									if (ZR3 = '1') then
										nx_state <= S7;
									else
										nx_state <= S6;
									end if;
									
								end if;	 
								
							end if;	
							
						end if;	
							
					end if;
					
				end if;	 
				
				
				
				
			when S2 =>
				nx_state <= S2;
			
			
			when S3 =>
				nx_state <= LOADIR;
				
				
			when S4 =>
				nx_state <= LOADIR;
				
				
			when S5 =>
				nx_state <= LOADIR;
				
				
			when S6 =>
				nx_state <= LOADIR;
				
				
			when S7 =>
				nx_state <= LOADIR;
			
				
			when others =>
				nx_state <= S0;
			
		end case;
		
	end process;
 
	
--%%%%%%%%%%%%%%%%%%%%% OUTPUT LOGIC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

process (pr_state, ROUTIR)
begin 
	-- Initializing the Control Unit Outputs by ZEROS
	LD0		<= '0';	 
	LD1		<= '0';	
	LD2		<= '0';	
	LD3		<= '0';	
	LDPC	<= '0';	
	LDIR	<= '0';	
	S00		<= '0';	
	S01		<= '0';		 
	S10		<= '0';	
	S11		<= '0';	
	Bus_Sel	<= '0';	
	CMD		<= '0';	
	INC		<= '0';	
	RST		<= '0';	
	
	case pr_state is 
		

		
		when S0 =>
			RST <= '1';	-- Reset PC to Zero
		
			
		-- This state will bring the ROUTIR to the Control Unit exactly when state S1 comes
		when LOADIR =>
			LDIR <= '1'; -- IR register Load will be permitted
			Bus_Sel <= '0';	-- Memory Data will be written on the Bus
		
			
		when S1 =>
			LDIR <= '1'; -- IR register Load will be permitted
			INC <= '1';	 -- PC <= PC + 1
			Bus_Sel <= '0';	-- Memory Data will be written on the Bus
				
		
			
		when S2 =>
			RST <= '0'; -- After seeing Halt, we do nothing
		
		
		when S3 => 
			INC <= '1';	 -- PC <= PC + 1
			Bus_Sel <= '0';	-- Memory Data will be written on the Bus 
			
			if (ROUTIR(3) = '0' and ROUTIR(2) = '0') then 
				-- This means that the destination register is R0
				LD0 <= '1'; -- R0 register Load will be permitted 
				
			elsif (ROUTIR(3) = '0' and ROUTIR(2) = '1') then 
				-- This means that the destination register is R1
				LD1 <= '1'; -- R1 register Load will be permitted 
				
			elsif (ROUTIR(3) = '1' and ROUTIR(2) = '0') then 
				-- This means that the destination register is R2
				LD2 <= '1'; -- R2 register Load will be permitted
				
				
			else
				-- This means that the destination register is R3
				LD3 <= '1'; -- R3 register Load will be permitted
				
			end if;
		
		
		when S4 =>
			CMD <= '0';	 -- The ALU will operate Addition on its inputs
			Bus_Sel <= '1';	-- ALU Result will be written on the Bus 
			S01 <= ROUTIR(3); -- Setting Mux Selectors
			S00 <= ROUTIR(2);
			S11 <= ROUTIR(1);
			S10 <= ROUTIR(0);
			
			if (ROUTIR(3) = '0' and ROUTIR(2) = '0') then 
				-- This means that the destination register is R0
				LD0 <= '1'; -- R0 register Load will be permitted 
				
			elsif (ROUTIR(3) = '0' and ROUTIR(2) = '1') then 
				-- This means that the destination register is R1
				LD1 <= '1'; -- R1 register Load will be permitted 
				
			elsif (ROUTIR(3) = '1' and ROUTIR(2) = '0') then 
				-- This means that the destination register is R2
				LD2 <= '1'; -- R2 register Load will be permitted
				
				
			else
				-- This means that the destination register is R3
				LD3 <= '1'; -- R3 register Load will be permitted
				
			end if;
			
		
		
		when S5 =>
			CMD <= '1';	 -- The ALU will operate Subtraction on its inputs
			Bus_Sel <= '1';	-- ALU Result will be written on the Bus 
			S01 <= ROUTIR(3); -- Setting Mux Selectors
			S00 <= ROUTIR(2);
			S11 <= ROUTIR(1);
			S10 <= ROUTIR(0);
			
			if (ROUTIR(3) = '0' and ROUTIR(2) = '0') then 
				-- This means that the destination register is R0
				LD0 <= '1'; -- R0 register Load will be permitted 
				
			elsif (ROUTIR(3) = '0' and ROUTIR(2) = '1') then 
				-- This means that the destination register is R1
				LD1 <= '1'; -- R1 register Load will be permitted 
				
			elsif (ROUTIR(3) = '1' and ROUTIR(2) = '0') then 
				-- This means that the destination register is R2
				LD2 <= '1'; -- R2 register Load will be permitted
				
				
			else
				-- This means that the destination register is R3
				LD3 <= '1'; -- R3 register Load will be permitted
				
			end if;
		
		
		when S6 =>
			LDPC <= '1'; -- PC register Load will be permitted for Jump operation
			Bus_Sel <= '0';	 -- Memory Data will be written on the Bus
		
		
		when S7 =>
			INC <= '1'; -- PC <= PC + 1
		
		
		when others => 
			RST <= '1'; -- In other cases Reset PC to ZERO
		
			
	end case;
		
	
end process;


end architecture RTL;
