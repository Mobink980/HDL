-------------------------------------------------------------------------------
--
-- Title       : adder4
-- Design      : MULTIPLIER
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : adder4.vhd
-- Generated   : Wed Apr 22 13:22:29 2020
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
--{entity {adder4} architecture {adder4}}

	

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity adder4 is
	port (
	signal a, b: in std_logic_vector(3 downto 0); --operands
	signal cin: in std_logic; --input carry
	signal sum: out std_logic_vector (3 downto 0); --sum
	signal cout: out std_logic --output carry	
	);
end adder4;



--}} End of automatically maintained section

architecture dfl of adder4 is 
signal ci: std_logic_vector(0 to 4);
begin 
	ci(0) <= cin;
	STAGES: for k in 0 to 3 generate
		BS:	 sum(k) <= a(k) xor b(k) xor ci(k);
		BCO: ci(k + 1) <= (a(k) and b(k)) or (a(k) and ci(k)) or (b(k) and ci(k));
	end generate STAGES;
	cout <= ci(4);	 

end architecture dfl; 





