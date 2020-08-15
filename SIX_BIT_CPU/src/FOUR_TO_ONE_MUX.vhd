-------------------------------------------------------------------------------
--
-- Title       : FOUR_TO_ONE_MUX
-- Design      : CPU
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : FOUR_TO_ONE_MUX.vhd
-- Generated   : Fri Jul 10 13:06:50 2020
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
--{entity {FOUR_TO_ONE_MUX} architecture {FOUR_TO_ONE_MUX}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FOUR_TO_ONE_MUX is 
generic (
	AddrWidth: integer := 6; --width of address
	DataWidth: integer := 6	 -- width of a memory cell
	); 
	
port(
	I0: in std_logic_vector(DataWidth-1 downto 0);	
	I1: in std_logic_vector(DataWidth-1 downto 0);
	I2: in std_logic_vector(DataWidth-1 downto 0);
	I3: in std_logic_vector(DataWidth-1 downto 0);
	S0: in std_logic;
	S1: in std_logic;
	
	Y: out std_logic_vector(DataWidth-1 downto 0)
	);
end FOUR_TO_ONE_MUX;

--}} End of automatically maintained section

architecture RTL of FOUR_TO_ONE_MUX is
begin
  
-- 4 x 1 MUX implementation in one process
p_mux : process(I0, I1, I2, I3, S1, S0)
begin
  	if (S1 = '0' and S0 = '0') then
	  	Y <= I0;
		  
	elsif (S1 = '0' and S0 = '1') then
		Y <= I1;  
		
	elsif (S1 = '1' and S0 = '0') then
		Y <= I2;
		
	else
		Y <= I3;
		
	end if;
	
end process p_mux;

end architecture RTL;
