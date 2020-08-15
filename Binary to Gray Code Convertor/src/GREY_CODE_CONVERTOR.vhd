-------------------------------------------------------------------------------
--
-- Title       : GREY_CODE_CONVERTOR
-- Design      : CAD_HW01
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : GREY_CODE_CONVERTOR.vhd
-- Generated   : Mon Apr 20 11:39:16 2020
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
--{entity {GREY_CODE_CONVERTOR} architecture {GREY_CODE_CONVERTOR}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

--in entity we define the input and output ports (which are signals by default)
entity GREY_CODE_CONVERTOR is  
	port(
	B: in std_logic_vector (7 downto 0); --8-bit std_logic_vector for input
	G: out std_logic_vector (7 downto 0) --8-bit std_logic_vector for output
	);
end GREY_CODE_CONVERTOR;

--}} End of automatically maintained section

-- The following is an eample architecture of the implementation of GREY_CODE_CONVERTOR 
architecture example of GREY_CODE_CONVERTOR is
begin
	--Defining a process to do the job
	process(B)
	begin
		G(7) <= B(7); --the last bit is always the same
		for I in 6 downto 0 loop  
			G(I) <= B(I + 1) xor B(I); --other values are acquired by xor operation			
		end loop;
		
		
	end process;

end example;
