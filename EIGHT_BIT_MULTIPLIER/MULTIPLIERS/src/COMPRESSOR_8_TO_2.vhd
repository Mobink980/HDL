-------------------------------------------------------------------------------
--
-- Title       : COMPRESSOR_8_TO_2
-- Design      : MULTIPLIERS
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : COMPRESSOR_8_TO_2.vhd
-- Generated   : Sat May 22 22:24:55 2021
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
--{entity {COMPRESSOR_8_TO_2} architecture {COMPRESSOR_8_TO_2}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity COMPRESSOR_8_TO_2 is	
	port ( --port declaration 
		signal x: in std_logic_vector(7 downto 0); -- input bits
		signal cin1: in std_logic; -- side input carry
		signal cin2: in std_logic; -- side input carry
		signal cin3: in std_logic; -- side input carry	
		signal cin4: in std_logic; -- side input carry 	
		signal cin5: in std_logic; -- side input carry 
		signal cout1: out std_logic; --side output carry	  
		signal cout2: out std_logic; --side output carry  
		signal cout3: out std_logic; --side output carry 
		signal cout4: out std_logic; --side output carry
		signal cout5: out std_logic; --side output carry
		signal s: out std_logic;-- sum
		signal c: out std_logic -- carry_out
		); 
end COMPRESSOR_8_TO_2;

--}} End of automatically maintained section

architecture RTL of COMPRESSOR_8_TO_2 is
-- middle signals for storing the results of CSAs
signal t0: std_logic;  
signal t1: std_logic;  
signal t2: std_logic; 
signal t3: std_logic;
signal t4: std_logic;
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
		port map (a => t2, b => x(5), cin => cin3, sum => t3, cout => cout4);	  
		
	-- instantiating the CSA unit
	CSA4: entity work.FA(RTL)
		port map (a => t3, b => x(6), cin => cin4, sum => t4, cout => cout5); 
		
	-- instantiating the CSA unit
	CSA5: entity work.FA(RTL)
		port map (a => t4, b => x(7), cin => cin5, sum => s, cout => c);

end architecture RTL;
