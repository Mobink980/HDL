-------------------------------------------------------------------------------
--
-- Title       : FLIP_FLOP
-- Design      : RANDOM_CIRCUIT
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : FLIP_FLOP.vhd
-- Generated   : Thu May 14 16:55:32 2020
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
--{entity {FLIP_FLOP} architecture {FLIP_FLOP}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FLIP_FLOP is
	port(
	signal clk, d: in std_logic;
	signal q: out std_logic
	);
end FLIP_FLOP;

--}} End of automatically maintained section

architecture RTL of FLIP_FLOP is
begin	
	
	process(clk) 
	begin  
		if (clk'event and clk = '1') then
			q <= d;
		
		end if;
		
	end process;

	 

end architecture RTL;
