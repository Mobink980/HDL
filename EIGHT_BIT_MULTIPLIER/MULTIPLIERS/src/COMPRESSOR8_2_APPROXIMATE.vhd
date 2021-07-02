-------------------------------------------------------------------------------
--
-- Title       : COMPRESSOR8_2_APPROXIMATE
-- Design      : MULTIPLIERS
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : COMPRESSOR8_2_APPROXIMATE.vhd
-- Generated   : Fri Jun 25 18:31:25 2021
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
--{entity {COMPRESSOR8_2_APPROXIMATE} architecture {COMPRESSOR8_2_APPROXIMATE}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity COMPRESSOR8_2_APPROXIMATE is
	port ( --port declaration 
		signal a, b, c, d, e, f, g, h: in std_logic; -- input bits
		signal cin0: in std_logic; -- side input carry
		signal cin1: in std_logic; -- side input carry
		signal cin2: in std_logic; -- side input carry	
		signal cin3: in std_logic; -- side input carry 	
		signal cin4: in std_logic; -- side input carry 
		signal cout0: out std_logic; --side output carry	  
		signal cout1: out std_logic; --side output carry  
		signal cout2: out std_logic; --side output carry 
		signal cout3: out std_logic; --side output carry
		signal cout4: out std_logic; --side output carry
		signal sum: out std_logic;-- sum
		signal carry: out std_logic -- carry_out
		); 
end COMPRESSOR8_2_APPROXIMATE;

--}} End of automatically maintained section

architecture RTL of COMPRESSOR8_2_APPROXIMATE is 
-- middle signals 
signal t0, t1, t2, t3, t4: std_logic; 
signal t5, t6, t7, t8, t9, t10: std_logic;
begin
	--FIRST LEVEL
	t0 <= a xnor b;
	t1 <= c xnor d;
	t2 <= g xnor h;
	t3 <= cin1 xnor cin2; 
	
	--SECOND LEVEL
	t4 <= e xnor t0;
	t5 <= t1 xnor f;
	t6 <= cin0 xnor t2;
	t7 <= t3 xnor cin3;
	
	--THIRD LEVEL
	t8 <= t4 nor t5;
	t9 <= t6 nor t7;
	
	--FOURTH LEVEL
	t10 <= t8 xor t9;
	
	--FIFTH LEVEL
	sum <= t10 xor cin4;
	
	--OTHER OUTPUTS
	cout0 <= a;
	cout1 <= d;
	cout2 <= f;
	cout3 <= h;
	cout4 <= cin1;
	carry <= cin4; 

end architecture RTL;
