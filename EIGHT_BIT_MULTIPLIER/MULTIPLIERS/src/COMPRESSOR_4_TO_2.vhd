-------------------------------------------------------------------------------
--
-- Title       : COMPRESSOR_4_TO_2
-- Design      : MULTIPLIERS
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : COMPRESSOR_4_TO_2.vhd
-- Generated   : Sat May 22 22:23:29 2021
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
--{entity {COMPRESSOR_4_TO_2} architecture {COMPRESSOR_4_TO_2}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity COMPRESSOR_4_TO_2 is
	port ( --port declaration 
		signal x: in std_logic_vector(3 downto 0); -- input bits
		signal cin: in std_logic; -- side input carry	
		signal cout: out std_logic; --side output carry
		signal s: out std_logic;-- sum
		signal c: out std_logic -- carry_out
		); 
end COMPRESSOR_4_TO_2;

--}} End of automatically maintained section

architecture RTL of COMPRESSOR_4_TO_2 is   
-- middle signals for storing the results of CSAs
signal t0: std_logic; 
begin
	-- instantiating the CSA unit
	CSA0: entity work.FA(RTL)
		port map (a => x(0), b => x(1), cin => x(2), sum => t0, cout => cout);	
		
	-- instantiating the CSA unit
	CSA1: entity work.FA(RTL)
		port map (a => t0, b => x(3), cin => cin, sum => s, cout => c);	

	 

end architecture RTL;
