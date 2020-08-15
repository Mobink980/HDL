-------------------------------------------------------------------------------
--
-- Title       : PRIORITY_ENCODER
-- Design      : PRIORITY_ENCODER
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : PRIORITY_ENCODER.vhd
-- Generated   : Mon Apr 20 12:23:28 2020
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
--{entity {PRIORITY_ENCODER} architecture {PRIORITY_ENCODER}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity PRIORITY_ENCODER is 
	port (
	D: in std_logic_vector (15 downto 0);
	Q: out std_logic_vector (3 downto 0)
	);
end PRIORITY_ENCODER;

--}} End of automatically maintained section

architecture example of PRIORITY_ENCODER is
begin

	process (D)
	variable temp: integer;
	begin		  
		--initializing temp with an unusual value to check when the input is invalid
		temp := 20;  
		-- looping from msb (most significant bit) to lsb (least significant bit)
		-- As we are implementing a priority encoder, the first 1 that we see is the end of the loop
		for I in 15 downto 0 loop
			if (D(I) = '1') then
				temp := I;
				exit;
			end if;
						
		end loop;
		
		--using the variable temp to determine the value of output based on the input
		case temp is
			when 0 =>
			Q <= "0000";
			
			when 1 =>
			Q <= "0001";
			
			when 2 =>
			Q <= "0010";
			
			when 3 =>
			Q <= "0011";
			
			when 4 =>
			Q <= "0100";
			
			when 5 =>
			Q <= "0101";
			
			when 6 =>
			Q <= "0110";
			
			when 7 =>
			Q <= "0111";
			
			when 8 =>
			Q <= "1000";
			
			when 9 =>
			Q <= "1001";
			
			when 10 =>
			Q <= "1010";
			
			when 11 =>
			Q <= "1011";
			
			when 12 =>
			Q <= "1100";
			
			when 13 =>
			Q <= "1101";
			
			when 14 =>
			Q <= "1110";
			
			when 15 =>
			Q <= "1111";
			
			when others =>
			Q <= "----";  
			
		end case;
			
				
	end process;

end example;
