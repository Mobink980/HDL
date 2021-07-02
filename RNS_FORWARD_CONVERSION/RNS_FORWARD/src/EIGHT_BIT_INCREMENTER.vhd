-------------------------------------------------------------------------------
--
-- Title       : EIGHT_BIT_INCREMENTER
-- Design      : RNS_FORWARD
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : EIGHT_BIT_INCREMENTER.vhd
-- Generated   : Tue Jun 29 13:56:36 2021
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
--{entity {EIGHT_BIT_INCREMENTER} architecture {EIGHT_BIT_INCREMENTER}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity EIGHT_BIT_INCREMENTER is
	port ( --port declaration 
		signal x:   in  std_logic_vector(7 downto 0);	-- 8-bit input 
		signal cin: in std_logic;
		signal y:   out std_logic_vector(7 downto 0)	-- 8-bit output
		);
end EIGHT_BIT_INCREMENTER;

--}} End of automatically maintained section

architecture RTL of EIGHT_BIT_INCREMENTER is 
--middle signals
signal t0, t1, t2, t3, t4, t5, t6, t7: std_logic;
begin

	-- instantiating the HA unit
	HA0: entity work.HA(RTL)
		port map (a => x(0), b => cin, sum => y(0), cout => t0);	
		
	-- instantiating the HA unit
	HA1: entity work.HA(RTL)
		port map (a => x(1), b => t0, sum => y(1), cout => t1);
		
	-- instantiating the HA unit
	HA2: entity work.HA(RTL)
		port map (a => x(2), b => t1, sum => y(2), cout => t2);
		
	-- instantiating the HA unit
	HA3: entity work.HA(RTL)
		port map (a => x(3), b => t2, sum => y(3), cout => t3);
		
	-- instantiating the HA unit
	HA4: entity work.HA(RTL)
		port map (a => x(4), b => t3, sum => y(4), cout => t4);
		
	-- instantiating the HA unit
	HA5: entity work.HA(RTL)
		port map (a => x(5), b => t4, sum => y(5), cout => t5);
		
	-- instantiating the HA unit
	HA6: entity work.HA(RTL)
		port map (a => x(6), b => t5, sum => y(6), cout => t6);
		
	-- instantiating the HA unit
	HA7: entity work.HA(RTL)
		port map (a => x(7), b => t6, sum => y(7), cout => t7);

end architecture RTL;
