-------------------------------------------------------------------------------
--
-- Title       : PROPAGATING_CLA
-- Design      : ADDERS
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : PROPAGATING_CLA.vhd
-- Generated   : Thu May 20 21:28:20 2021
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
--{entity {PROPAGATING_CLA} architecture {PROPAGATING_CLA}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity PROPAGATING_CLA is 
	port ( --port declaration 
		signal x: in std_logic_vector(7 downto 0);	-- 8-bit input
		signal y: in std_logic_vector(7 downto 0);	-- 8-bit input	
		signal s: out std_logic_vector(7 downto 0);	-- 8-bit sum 
		signal carry0, carry4, carry8: out std_logic -- group carries
		
		); 
end PROPAGATING_CLA;

--}} End of automatically maintained section

architecture RTL of PROPAGATING_CLA is	 
signal c0, c4, c8: std_logic; -- group carries (as middle signals)
begin
	--carry-in to the adder is '0'
	c0 <= '0';
	
	-- instantiating the 4-bit Carry Look-Ahead Adder
	CLA0: entity work.CLA(RTL)
		port map (a => x(3 downto 0), b => y(3 downto 0), cin => c0, sum => s(3 downto 0), cout => c4);	  
		
	-- instantiating the 4-bit Carry Look-Ahead Adder
	CLA1: entity work.CLA(RTL)
		port map (a => x(7 downto 4), b => y(7 downto 4), cin => c4, sum => s(7 downto 4), cout => c8);

	 
	-- Showing Group Carries in the output
	carry0 <= c0; 
	carry4 <= c4;
	carry8 <= c8;

end architecture RTL;
