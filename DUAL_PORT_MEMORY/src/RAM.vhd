-------------------------------------------------------------------------------
--
-- Title       : RAM
-- Design      : DUAL_PORT_MEMORY
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : RAM.vhd
-- Generated   : Sun Jun 14 16:58:18 2020
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
	AddrWidth: integer := 8;
	DataWidth: integer := 8
	); 
	
	port(
	clk: in std_logic;
	CS1, CS2, WE1, WE2: in std_logic;
	Addr1, Addr2: in std_logic_vector(AddrWidth-1 downto 0);
	Data1, Data2: inout std_logic_vector(DataWidth-1 downto 0)
	);
end RAM;

--}} End of automatically maintained section

architecture RTL of RAM is
type MyMem is array (2**AddrWidth-1 downto 0) of std_logic_vector(DataWidth-1 downto 0);
signal Mem: MyMem := (others=>(others=>'0'));
begin
	
	process (clk)
	begin
		if clk'event and clk='1' then
			if (CS1 = '1' and WE1 = '1') then
				Mem(to_integer(unsigned(Addr1))) <= Data1;
			elsif (CS2 = '1' and WE2 = '1') then
				Mem(to_integer(unsigned(Addr2))) <= Data2;
			end if;
		end if;
				
		
	end process;
	
	
	Data1 <= Mem(to_integer(unsigned(Addr1))) when (CS1 = '1' and WE1 = '0') 
	else (others => 'Z');
		
	Data2 <= Mem(to_integer(unsigned(Addr2))) when (CS2 = '1' and WE2 = '0') 
	else (others => 'Z');
	

end architecture RTL;
