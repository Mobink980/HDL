-------------------------------------------------------------------------------
--
-- Title       : SP_CSA
-- Design      : RNS_FORWARD
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : SP_CSA.vhd
-- Generated   : Tue Jun 29 13:00:48 2021
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
--{entity {SP_CSA} architecture {SP_CSA}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity SP_CSA is
	port ( --port declaration
		signal opa, opb, cin: in std_logic;	--input signal ports
		signal sum, cout: out std_logic ); --output signal ports	
end SP_CSA;

--}} End of automatically maintained section

architecture RTL of SP_CSA is
begin							   
	-- Code for a special-purpose CSA (using posibits &  negabits)
	P1: sum <= opa xor opb xor cin;
	P2: cout <= (opa and (not opb)) or (opa and cin) or ((not opb) and cin);  
	
end architecture RTL;
