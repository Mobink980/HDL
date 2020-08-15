-------------------------------------------------------------------------------
--
-- Title       : Register_64bit
-- Design      : SERIAL_TO_PARALLEL
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : Register_64bit.vhd
-- Generated   : Sat May 30 01:51:16 2020
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
--{entity {Register_64bit} architecture {Register_64bit}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Register_64bit is
	port (
	Clk, Reset, Load, ShL, ShR: in std_logic; --control inputs
	D: in std_logic;		-- 1-bit input
	Q: out std_logic_vector (63 downto 0)  --64-bit output
	);
end Register_64bit;

--}} End of automatically maintained section

architecture RTL of Register_64bit is 
signal Reg_Input, Q_Reg: std_logic_vector (63 downto 0);
begin
	
	-- THIS PROCESS SPECIFIES THE BEHAVIOR OF A REGISTER
	process (Clk, Reset)
	begin
		if (Reset = '1') then
			Q_Reg <= (others => '0');
		
		elsif Clk'event and Clk = '1' then
			Q_Reg <= Reg_Input;
			
		end if;
		
	end process; 
	
	-- THIS PROCESS DETERMINES THE Reg_Input, WHICH IS THE NEXT OUTPUT
	process (Q_Reg, D, Load, ShL, ShR)	 
	begin  
		if (Load = '1') then
			Reg_Input(63) <= D;
			
		elsif (ShL = '1' and ShR = '0') then  -- SHIFT LEFT
			Reg_Input <= to_stdlogicvector(to_bitvector(Q_Reg) sll 1);	  
			
		elsif (ShL = '0' and ShR = '1') then  -- SHIFT RIGHT
			Reg_Input <= to_stdlogicvector(to_bitvector(Q_Reg) srl 1);
			
		elsif (ShL = '1' and ShR = '1') then -- If both ShL and SHR are one 
			Reg_Input(63) <= not D; -- the not of the input will go to output
			
		else  -- If all are zero then we do holding
			Reg_Input <= Q_Reg;
			
		end if;
					
	end process;	 
	
	Q <= Q_Reg;

end architecture RTL;

