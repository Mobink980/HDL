-------------------------------------------------------------------------------
--
-- Title       : HA
-- Design      : RNS_FORWARD
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : HA.vhd
-- Generated   : Tue Jun 29 12:59:10 2021
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
--{entity {HA} architecture {HA}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity HA is 
	port ( --port declaration 
		signal a: in std_logic; -- first bit
		signal b: in std_logic; -- second bit
		signal sum: out std_logic;-- sum
		signal cout: out std_logic -- carry_out
		); 
end HA;

--}} End of automatically maintained section

architecture RTL of HA is
begin 
	sum <= a xor b;
	cout <= a and b;

end architecture RTL;
