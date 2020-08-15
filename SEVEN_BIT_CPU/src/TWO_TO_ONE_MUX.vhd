-------------------------------------------------------------------------------
--
-- Title       : TWO_TO_ONE_MUX
-- Design      : CPU
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : TWO_TO_ONE_MUX.vhd
-- Generated   : Sun Jul 19 12:29:58 2020
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
--{entity {TWO_TO_ONE_MUX} architecture {TWO_TO_ONE_MUX}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity TWO_TO_ONE_MUX is
generic (
	AddrWidth: integer := 7; --width of address
	DataWidth: integer := 7	 -- width of a memory cell
	); 
	
port(
	I0: in std_logic_vector(DataWidth-1 downto 0);	
	I1: in std_logic_vector(DataWidth-1 downto 0);	
	S: in std_logic;
	
	Y: out std_logic_vector(DataWidth-1 downto 0)
	);
end TWO_TO_ONE_MUX;

--}} End of automatically maintained section

architecture RTL of TWO_TO_ONE_MUX is
begin
	
	Y <= I0 when (S = '0')
	else I1;
	 

end architecture RTL;
