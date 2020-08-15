-------------------------------------------------------------------------------
--
-- Title       : fadd1
-- Design      : PRODUCTOR
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : fadd1.vhd
-- Generated   : Wed Apr 22 15:03:04 2020
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
--{entity {fadd1} architecture {fadd1}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity fadd1 is
	port(
	opa, opb, cin: in std_logic;
	sum, cout: out std_logic	
	);	
end entity fadd1;

--}} End of automatically maintained section

architecture dfl of fadd1 is
begin

	P1: sum <= opa xor opb xor cin;
	P2: cout <= (opa and opb) or (opa and cin) or (opb and cin);

end dfl;

