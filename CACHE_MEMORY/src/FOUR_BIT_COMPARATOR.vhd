-------------------------------------------------------------------------------
--
-- Title       : FOUR_BIT_COMPARATOR
-- Design      : CACHE_MEMORY
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : FOUR_BIT_COMPARATOR.vhd
-- Generated   : Sun Jan 24 20:32:09 2021
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
--{entity {FOUR_BIT_COMPARATOR} architecture {FOUR_BIT_COMPARATOR}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FOUR_BIT_COMPARATOR is 
	generic (
		Length	: integer := 4  -- LENGTH OF INPUT DATA
	); 	   
	
	port (
	data_one: in std_logic_vector(Length-1 downto 0);
	data_two: in std_logic_vector(Length-1 downto 0);
	
	F		: out std_logic
	);
end FOUR_BIT_COMPARATOR;

--}} End of automatically maintained section

architecture FOUR_BIT_COMPARATOR of FOUR_BIT_COMPARATOR is 
signal xnor_results: std_logic_vector (Length -1 downto 0);
begin
	
	xnor_generator: for I in Length -1 downto 0 generate
		xnor_results(I) <= data_one(I) xnor data_two(I);
	end generate xnor_generator;  
	
	

	F <= xnor_results(0) and xnor_results(1) and xnor_results(2) and xnor_results(3);

	 

end FOUR_BIT_COMPARATOR;
