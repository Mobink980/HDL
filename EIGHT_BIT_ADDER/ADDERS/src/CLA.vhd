-------------------------------------------------------------------------------
--
-- Title       : CLA
-- Design      : ADDERS
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : CLA.vhd
-- Generated   : Thu May 20 21:26:42 2021
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
--{entity {CLA} architecture {CLA}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CLA is 
	port ( --port declaration 
		signal a: in std_logic_vector(3 downto 0);	-- 4-bit input
		signal b: in std_logic_vector(3 downto 0);	-- 4-bit input	
		signal cin: in std_logic; -- group carry-in
		signal sum: out std_logic_vector(3 downto 0);	-- 4-bit sum
		signal cout: out std_logic	-- group carry-out 	
		); 
end CLA;

--}} End of automatically maintained section

architecture RTL of CLA is 
signal c0, c1, c2, c3, c4: std_logic; --Middle signals for carries
signal G0, G1, G2, G3: std_logic; -- Gi = Ai and Bi
signal P0, P1, P2, P3: std_logic; -- Pi = Ai or Pi
begin  
	-- c0 is group carry-in
	c0 <= cin;
	-- Generated Carries
	G0 <= a(0) and b(0);  
	G1 <= a(1) and b(1);
	G2 <= a(2) and b(2);
	G3 <= a(3) and b(3); 
	-- Propagated Carries
	P0 <= a(0) or b(0);	 
	P1 <= a(1) or b(1);
	P2 <= a(2) or b(2);
	P3 <= a(3) or b(3);
	
	-- Calculating Carries
	c1 <= G0 or (c0 and P0);
	c2 <= G1 or (G0 and P1) or (c0 and P1 and P0);
	c3 <= G2 or (G1 and P2) or (G0 and P2 and P1) or (c0 and P2 and P1 and P0);
	c4 <= G3 or (G2 and P3) or (G1 and P3 and P2) or (G0 and P3 and P2 and P1) or (c0 and P3 and P2 and P1 and P0);
	
	-- Calculating the Final SUM
	sum(0) <= a(0) xor b(0) xor c0;	 
	sum(1) <= a(1) xor b(1) xor c1;
	sum(2) <= a(2) xor b(2) xor c2;
	sum(3) <= a(3) xor b(3) xor c3;	
	
	-- Group Carry-out
	cout <= c4;

end architecture RTL;
