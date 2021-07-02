-------------------------------------------------------------------------------
--
-- Title       : COMPRESSOR_6_TO_2
-- Design      : MULTIPLIERS
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : COMPRESSOR_6_TO_2.vhd
-- Generated   : Sat May 22 22:24:08 2021
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
--{entity {COMPRESSOR_6_TO_2} architecture {COMPRESSOR_6_TO_2}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity COMPRESSOR_6_TO_2 is	
	port ( --port declaration 
		signal x: in std_logic_vector(5 downto 0); -- input bits
		signal cin1: in std_logic; -- side input carry
		signal cin2: in std_logic; -- side input carry
		signal cin3: in std_logic; -- side input carry
		signal cout1: out std_logic; --side output carry	  
		signal cout2: out std_logic; --side output carry  
		signal cout3: out std_logic; --side output carry
		signal s: out std_logic;-- sum
		signal c: out std_logic -- carry_out
		); 
end COMPRESSOR_6_TO_2;

--}} End of automatically maintained section

architecture RTL of COMPRESSOR_6_TO_2 is
-- middle signals for storing the results of CSAs
signal t0: std_logic;  
signal t1: std_logic;  
signal t2: std_logic;
begin
	-- instantiating the CSA unit
	CSA0: entity work.FA(RTL)
		port map (a => x(0), b => x(1), cin => x(2), sum => t0, cout => cout1);	
		
	-- instantiating the CSA unit
	CSA1: entity work.FA(RTL)
		port map (a => t0, b => x(3), cin => cin1, sum => t1, cout => cout2);		 
		
	-- instantiating the CSA unit
	CSA2: entity work.FA(RTL)
		port map (a => t1, b => x(4), cin => cin2, sum => t2, cout => cout3);  
		
	-- instantiating the CSA unit
	CSA3: entity work.FA(RTL)
		port map (a => t2, b => x(5), cin => cin3, sum => s, cout => c);

end architecture RTL;
