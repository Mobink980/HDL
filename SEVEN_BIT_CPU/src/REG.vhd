-------------------------------------------------------------------------------
--
-- Title       : REG
-- Design      : CPU
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : REG.vhd
-- Generated   : Sun Jul 19 12:28:55 2020
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
--{entity {REG} architecture {REG}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity REG is 
	
generic (
	AddrWidth: integer := 7; --width of address
	DataWidth: integer := 7	 -- width of a memory cell
	); 	
	
port (
	clk: in std_logic; 
	LD: in std_logic;  -- Load permission
	RIN: in std_logic_vector (DataWidth-1 downto 0); -- register input
	
	ZR: out std_logic;	-- Becomes one whenever register content is zero
	ROUT: out std_logic_vector (DataWidth-1 downto 0) --register output
	); 
	
end REG;

--}} End of automatically maintained section

architecture RTL of REG is
signal Reg_Input: std_logic_vector (DataWidth-1 downto 0); 
signal Q_Reg: std_logic_vector (DataWidth-1 downto 0);
begin					 
	
	
		-- THIS PROCESS SPECIFIES THE BEHAVIOR OF A REGISTER
	process (clk)
	begin
		
		if Clk'event and Clk = '1' then
			Q_Reg <= Reg_Input;
			
		end if;
		
	end process; 
	
	-- THIS PROCESS DETERMINES THE Reg_Input, WHICH IS THE NEXT OUTPUT
	process (LD, Q_Reg, RIN)	 
	begin
		if (LD = '1') then	
			-- allowing data to be written into the register
			Reg_Input <= RIN;
			
		else  -- If LD is zero then we do holding
			Reg_Input <= Q_Reg;
			
		end if;
					
	end process;	 
	
	-- Setting the output ROUT 
	ROUT <= Q_Reg;		
	
	-- Setting the output ZR
	ZR <= '1' when (Q_Reg = "0000000")
	else '0';
	

	 

end architecture RTL;
