-------------------------------------------------------------------------------
--
-- Title       : CONTROLLER
-- Design      : _CONTROLLER
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : CONTROLLER.vhd
-- Generated   : Sun Jun 14 18:20:05 2020
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
--{entity {CONTROLLER} architecture {CONTROLLER}}

library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity CONTROLLER is
--	generic (
--	AddrWidth: integer := 8;
--	DataWidth: integer := 8
--	); 
--	
--	port(
--	clk: in std_logic;
--	reset, FIFOWrite, FIFORead: in std_logic; 
--	FIFOEmpty, FIFOFull: out std_logic;
--	FIFODataIn: in std_logic_vector (DataWidth-1 downto 0);
--	FIFODataOut: in std_logic_vector (DataWidth-1 downto 0)
--	);	
	
	
	
	Generic (
		constant DATA_WIDTH  : positive := 8; -- the size of the DataIn and DataOut Buses
		constant ADDR_WIDTH	 : positive := 8   -- the size of the address bus
	);
	Port ( 
		CLK		: in  STD_LOGIC;  -- in position of clk
		RST		: in  STD_LOGIC;  -- in position of reset
		WriteEn	: in  STD_LOGIC;  -- in position of FIFOWrite
		DataIn	: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0); -- in position of FIFODataIn
		ReadEn	: in  STD_LOGIC;   -- in position of FIFORead
		DataOut	: inout STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0); -- in position of FIFODataOut
		Empty	: out STD_LOGIC;  -- in position of FIFOFull
		Full	: out STD_LOGIC;  -- in position of FIFOEmpty 
		
		-- The two following inout ports are unnecessary and are used to monitor 
		-- the Data1 and Data2 of the memory in the simulation
		Data1   : inout STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);	 
		Data2   : inout STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0)
	);
	
end CONTROLLER;

--}} End of automatically maintained section

architecture RTL of CONTROLLER is  
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
	Memory0: entity work.RAM(RTL)
		port map (clk => clk, CS1 => '1', CS2 => '1', WE1 => WE1, WE2 => WE2, 
		Addr1 => Addr1, Addr2 => Addr2, Data1 => DataOut1, Data2 => DataOut2 ); 
	
	-- Memory Pointer Process
	-- the following process is used to create the fifo on the memory
	fifo_proc : process (CLK)
	
		--head is the pointer that belongs to the writer and increments whenever something is written
		variable Head : natural range 0 to FIFO_DEPTH - 1;  
		--tail is the pointer that belongs to the reader, increases whenever reader reads a memory cell
		variable Tail : natural range 0 to FIFO_DEPTH - 1;
		
		-- the variable looped becomes true whenever writer reaches the end and stars from the first cell
		variable Looped : boolean;
	begin
		if rising_edge(CLK) then
			if RST = '1' then  
				-- initializing head and tail to 0
				Head := 0;
				Tail := 0;
				
				-- at first looped should be false
				Looped := false;
				
				-- at first the queue is empty and nothing is written
				Full  <= '0';
				Empty <= '1';
			else
				if (ReadEn = '1') then
					if ((Looped = true) or (Head /= Tail)) then
						--(if head and tail are not the same, meaning the queue is not empty, we read the data from memory to databus)
						-- Update data output
						WE2 <= '0';	 -- in the time of reading, we read by the second port
						-- converting the integer tail to the std_logic_vector Addr2 
						Addr2 <= std_logic_vector(to_unsigned(Tail, ADDR_WIDTH));

						
						--DataOut <= Memory(Tail);
						
						-- Update Tail pointer as needed
						if (Tail = FIFO_DEPTH - 1) then
							-- if the tail is on the last memory cell, we reset it to the first
							Tail := 0;
							--allowing the write into the FIFO
							Looped := false;
						else   
							--increment the pointer tail when we read
							Tail := Tail + 1;
						end if;
						
						
					end if;
				end if;
				
				if (WriteEn = '1') then
					if ((Looped = false) or (Head /= Tail)) then
						-- Write Data to Memory	
						WE1 <= '1';	 -- in the time of writing, we writy by the first port 
						-- converting the integer head to the std_logic_vector Addr1 
						Addr1 <= std_logic_vector(to_unsigned(Head, ADDR_WIDTH)); 
						
						--Memory(Head) := DataIn;
						
						-- Increment Head pointer as needed
						if (Head = FIFO_DEPTH - 1) then
							-- if the head is on the last memory cell, we reset it to the first
							Head := 0;
							--allowing the read from the FIFO
							Looped := true;
						else
							--increment the pointer head when we write
							Head := Head + 1;
						end if;
					end if;
				end if;
				
				-- Update Empty and Full flags
				if (Head = Tail) then
					if Looped then 
						-- if looped is true and head = tail, it means that the memory is Full
						Full <= '1';
					else	  
						-- if looped is false and head = tail, it means that the memory is Empty
						Empty <= '1';
					end if;
				else   
					-- otherwise the memory is neither empty nor full
					Empty	<= '0';
					Full	<= '0';
				end if;
			end if;
		end if;
	end process; 
	
	-- We work with Data1 only for writing into the memory
	DataOut1 <= DataIn;					  
	-- We work with Data2 only for reading from the memory
	DataOut2 <= DataOut;
	
	
	
	
	-- showing the results in the waveform
	Data1 <= DataOut1;
	Data2 <= DataOut2;
	 

end architecture RTL;










