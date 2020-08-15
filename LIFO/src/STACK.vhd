-------------------------------------------------------------------------------
--
-- Title       : STACK
-- Design      : MEMORY_STACK
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : STACK.vhd
-- Generated   : Tue Jul  7 09:34:02 2020
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
--{entity {STACK} architecture {STACK}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity STACK is	
	
	
	Generic (
		constant DATA_WIDTH  : positive := 12; -- the size of the DataIn and DataOut Buses
		constant ADDR_WIDTH	 : positive := 12   -- the size of the address bus
	);
	Port ( 
		CLK			: in  STD_LOGIC;  -- in position of clk
		RESET		: in  STD_LOGIC;  -- in position of reset
		PUSH		: in  STD_LOGIC;  -- in position of WRITE ENABLE 
		POP			: in  STD_LOGIC;   -- in position of READ ENABLE
		DataIn		: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0); -- input data
		
		
		Stack_Empty	: out STD_LOGIC;  -- in position of FIFOFull
		Stack_Full	: out STD_LOGIC;  -- in position of FIFOEmpty 
		Data   : out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0)	 
		
	);
	
end STACK;

--}} End of automatically maintained section

architecture RTL of STACK is 
-- FIFO_DEPTH indicates the size of the internal memory
constant FIFO_DEPTH: integer:= 2**ADDR_WIDTH; 
-- The following middle signals are created in order to instantiate the memory
signal WE1: std_logic;
signal WE2: std_logic;
signal Addr1: std_logic_vector(ADDR_WIDTH-1 downto 0); 
signal Addr2: std_logic_vector(ADDR_WIDTH-1 downto 0);	 
signal DataOut1: std_logic_vector(DATA_WIDTH-1 downto 0);
signal DataOut2: std_logic_vector(DATA_WIDTH-1 downto 0);
begin

	
	-- instantiating the memory	
	-- We only use the first port of the Dual_Port_Memory for our purpose
	Memory0: entity work.RAM(RTL)
		port map (clk => clk, CS1 => '1', CS2 => '0', WE1 => WE1, WE2 => WE2, 
			Addr1 => Addr1, Addr2 => Addr2, Data1 => DataOut1, Data2 => DataOut2 ); 
		
		
		-- Memory Pointer Process
	-- the following process is used to create the lifo on the memory
	lifo_proc : process (CLK)
	
		--head is the pointer that belongs to the writer and increments whenever something is written
		variable Head : natural range 0 to FIFO_DEPTH - 1;  
		--tail is the pointer that belongs to the reader, increases whenever reader reads a memory cell
		variable Tail : natural range 0 to FIFO_DEPTH - 1;
			
		
	begin	
		
		-- At first, WE1 should be 1 as stack is empty and we are allowed to write 
		WE1 <= '1'; 
		if rising_edge(CLK) then
			if reset = '1' then  
				-- initializing head and tail to 0
				Head := 0;
				Tail := 0;
				
				
				-- at first the stack is empty and nothing is written
				Stack_Full  <= '0';
				Stack_Empty <= '1';
			else	
				-- if pop is active, it means that we should do the reading
				if (pop = '1' and push = '0') then	 
					-- if head is zero, it means that the stack is empty; thus, ther's nothing to read 
					if (Head /= 0) then
						--if head is  not zero, we are allowed to read while head becomes zero again
					
						-- converting the integer Head to the std_logic_vector Addr2 
						Addr1 <= std_logic_vector(to_unsigned(Head, ADDR_WIDTH));

											
						
						-- Update Head pointer as needed
						if (Head = 0) then
							-- if the head is on the first memory cell, the memory is empty 
							-- this means we should stop reading 
							WE1 <= '1'; -- writing is allowed
							Stack_Empty <= '1';
						else   
							--decrement the pointer head when we read
							Head := Head - 1; 
							Stack_Empty <= '0';
						end if;
						
						
					end if;
					
					
				
				
				-- if push is active, it means that we should do the writing
				elsif (push = '1' and pop = '0') then	  
					-- if head is FIFO_DEPTH - 1, it means that the stack is full and we should stop writing
					if (Head /= FIFO_DEPTH - 1) then
						-- if head is not indicating to the last memory cell, it means that we are allowed to write
						
						-- converting the integer head to the std_logic_vector Addr1 
						Addr1 <= std_logic_vector(to_unsigned(Head, ADDR_WIDTH)); 
						
						
						
						-- Update Head pointer as needed
						if (Head = FIFO_DEPTH - 1) then
							-- if the head is on the last memory cell, it means that the stack is full
							-- This means that we should stop writing
							WE1 <= '0'; -- writing is not permitted
							Stack_Full <= '1';
						else
							--increment the pointer head when we write
							Head := Head + 1;
							Stack_Full <= '0';
						end if;
					end if;
				end if;
				
				-- Update Empty and Full flags 
				-- If head is zero, it means stack is empty
				if (Head = 0) then 
					Stack_Empty	<= '1';
					Stack_Full	<= '0';
					
				-- if head is FIFO_DEPTH - 1, it means the stack is full
				elsif (Head = FIFO_DEPTH - 1) then 
					Stack_Empty	<= '0';
					Stack_Full	<= '1';				

				else   
					-- otherwise the memory is neither empty nor full
					Stack_Empty	<= '0';
					Stack_Full	<= '0';
				end if;
			end if;
		end if;
	end process; 
	

	
	
	
	
	-- showing the results in the waveform
	-- when something from the memory is being written on the bus, we can watch it here
	Data <= DataOut1;
	

end architecture RTL;
