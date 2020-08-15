-------------------------------------------------------------------------------
--
-- Title       : RAM
-- Design      : MEMORY_STACK
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : RAM.vhd
-- Generated   : Tue Jul  7 09:37:23 2020
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
--{entity {RAM} architecture {RAM}}


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity RAM is
	generic (
	AddrWidth: integer := 12;
	DataWidth: integer := 12
	); 
	
	port(
	clk: in std_logic;
	CS1, CS2, WE1, WE2: in std_logic;  -- CS1, and CS2 are for selecting one of the Dual ports for the operation
	Addr1, Addr2: in std_logic_vector(AddrWidth-1 downto 0);  -- two address bus data
	Data1, Data2: inout std_logic_vector(DataWidth-1 downto 0)	-- the ports used for READ & WRITE
	);
end RAM;

--}} End of automatically maintained section

architecture RTL of RAM is
type MyMem is array (2**AddrWidth-1 downto 0) of std_logic_vector(DataWidth-1 downto 0);
signal Mem: MyMem := (others=>(others=>'0'));
begin
	
	process (clk)
	begin			
		-- we first check the first port to see whether it is active and WE1 is set
		-- if one of those conditions are not met, we check the same conditions for the second port
		-- By using elsif in one process, we ensure that two ports are not allowed to write at the same time
		if clk'event and clk='1' then
			if (CS1 = '1' and WE1 = '1') then
				Mem(to_integer(unsigned(Addr1))) <= Data1;
			elsif (CS2 = '1' and WE2 = '1') then
				Mem(to_integer(unsigned(Addr2))) <= Data2;
			end if;
		end if;
				
		
	end process;
	
	
	--As we have Registered Dataout, if one of the ports are active, and Write is not enabled,
	-- it means that port should do the reading and this is what we do in the following.
	Data1 <= Mem(to_integer(unsigned(Addr1))) when (CS1 = '1' and WE1 = '0') 
	else (others => 'Z');
		
	Data2 <= Mem(to_integer(unsigned(Addr2))) when (CS2 = '1' and WE2 = '0') 
	else (others => 'Z');
	

end architecture RTL;

