-------------------------------------------------------------------------------
--
-- Title       : COUNTER
-- Design      : BCD_COUNTER
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : COUNTER.vhd
-- Generated   : Thu May 14 16:13:56 2020
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
--{entity {COUNTER} architecture {COUNTER}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity COUNTER is
	port(
	Clk, CountEn: in std_logic;
	Q: out integer range 0 to 55
	);
end COUNTER;

--}} End of automatically maintained section

architecture RTL of COUNTER is
signal COUNT: integer range 0 to 55;  
begin 
-- THIS PROCESS WILL CREATE A COUNTER THAT WILL ONLY RUN WHEN CcountEn IS ONE
	process(Clk, CountEn) 
	begin		
	
	if (CountEn = '1') then		  
		
	 if (Clk'event and Clk = '1') then 
		if (COUNT >= 55) then --COUNTING TO 55
			 COUNT <= 0;	
		else 
			COUNT <= COUNT + 1;
		  
		end if;
		
	end if;
		 
	else
		COUNT <= COUNT; --IF CountEn is zero, then we will hold the last value
		
	end if;
	
	end process;


	Q <= COUNT; -- TRANSFERING THE RESULT INTO THE OUTPUT 

end architecture RTL;
