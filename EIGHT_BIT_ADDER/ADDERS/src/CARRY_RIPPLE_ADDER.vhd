-------------------------------------------------------------------------------
--
-- Title       : CARRY_RIPPLE_ADDER
-- Design      : ADDERS
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : CARRY_RIPPLE_ADDER.vhd
-- Generated   : Thu May 20 19:24:40 2021
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
--{entity {CARRY_RIPPLE_ADDER} architecture {CARRY_RIPPLE_ADDER}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CARRY_RIPPLE_ADDER is 
	port ( --port declaration 
		signal a: in std_logic_vector(7 downto 0);	-- 8-bit input
		signal b: in std_logic_vector(7 downto 0);	-- 8-bit input
		signal s: out std_logic_vector(7 downto 0);	-- 8-bit sum
		signal cout: out std_logic_vector(7 downto 0)	-- 8-bit carry-out 	
		); 
end CARRY_RIPPLE_ADDER;

--}} End of automatically maintained section

architecture RTL of CARRY_RIPPLE_ADDER is  
signal c: std_logic_vector(8 downto 0);	-- 8-bit carry plus cout=c8 & cin='0'  

begin	  
	--carry-in to the adder is '0'
	c(0) <= '0';
	-- instantiating the Full Adder
	FA0: entity work.FA(RTL)
		port map (opa => a(0), opb => b(0), cin => c(0), sum => s(0), cout => c(1));
		
	-- instantiating the Full Adder
	FA1: entity work.FA(RTL)
		port map (opa => a(1), opb => b(1), cin => c(1), sum => s(1), cout => c(2));	 
		
	-- instantiating the Full Adder
	FA2: entity work.FA(RTL)
		port map (opa => a(2), opb => b(2), cin => c(2), sum => s(2), cout => c(3));
		
	-- instantiating the Full Adder
	FA3: entity work.FA(RTL)
		port map (opa => a(3), opb => b(3), cin => c(3), sum => s(3), cout => c(4));
		
	-- instantiating the Full Adder
	FA4: entity work.FA(RTL)
		port map (opa => a(4), opb => b(4), cin => c(4), sum => s(4), cout => c(5));
		
	-- instantiating the Full Adder
	FA5: entity work.FA(RTL)
		port map (opa => a(5), opb => b(5), cin => c(5), sum => s(5), cout => c(6));
		
	-- instantiating the Full Adder
	FA6: entity work.FA(RTL)
		port map (opa => a(6), opb => b(6), cin => c(6), sum => s(6), cout => c(7));
		
	-- instantiating the Full Adder
	FA7: entity work.FA(RTL)
		port map (opa => a(7), opb => b(7), cin => c(7), sum => s(7), cout => c(8));
	 
	   
	-- Showing output carries in the simulation
	cout(7 downto 0) <= c(8 downto 1);
end architecture RTL;
