-------------------------------------------------------------------------------
--
-- Title       : FA
-- Design      : MULTIPLIERS
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : FA.vhd
-- Generated   : Sat May 22 22:22:22 2021
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
--{entity {FA} architecture {FA}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FA is  
	port ( --port declaration 
		signal a: in std_logic; -- first bit
		signal b: in std_logic; -- second bit
		signal cin: in std_logic; -- carry_in
		signal sum: out std_logic;-- sum
		signal cout: out std_logic -- carry_out
		); 
end FA;

--}} End of automatically maintained section

architecture RTL of FA is
begin	  
	sum <= a xor b xor cin;	  -- CSA structure
	cout <= (a and b) or (a and cin) or (b and cin);
	
end architecture RTL;
