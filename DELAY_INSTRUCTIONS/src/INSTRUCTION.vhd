-------------------------------------------------------------------------------
--
-- Title       : INSTRUCTION
-- Design      : INSTRUCTIONS
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : INSTRUCTION.vhd
-- Generated   : Fri May 29 18:02:24 2020
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
--{entity {INSTRUCTION} architecture {INSTRUCTION}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity INSTRUCTION is 
	port(
	qin: in std_logic;
	Y1, Y2, Y3, Y4, Y5: out std_logic
	);
end INSTRUCTION;

--}} End of automatically maintained section

architecture RTL of INSTRUCTION is
begin 
	
	Y1 <= qin;	-- no delay is specified, so the delay is infinitesimal
	Y2 <= qin after 1ns; -- 1ns of delay is specified (default delay in VHDL is inertial delay)
	Y3 <= inertial qin after 1ns; -- the behavior is same as Y2, as the default delay is inertial delay
	Y4 <= transport qin after 1ns; -- Y4 will follow the qin after 1ns no matter the glitches
	Y5 <= reject 500ps inertial qin after 1ns; -- only impulses greater than 500ps or 0.5ns will be transmitted 

	 

end architecture RTL;
