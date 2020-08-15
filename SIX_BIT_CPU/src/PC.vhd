-------------------------------------------------------------------------------
--
-- Title       : PC
-- Design      : CPU
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : PC.vhd
-- Generated   : Fri Jul 10 16:20:27 2020
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
--{entity {PC} architecture {PC}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity PC is
	
generic (
	AddrWidth: integer := 6; --width of address
	DataWidth: integer := 6	 -- width of a memory cell
	); 	
	
port (
	clk: in std_logic; 
	LD: in std_logic;  -- Load permission 
	INC: in std_logic;  -- Incrementing the PC register for pointing to the next memory cell
	CLR: in std_logic;  -- Resetting the PC register to ZERO to point to the first memory cell
	RIN: in std_logic_vector (DataWidth-1 downto 0); -- register input
	
	ROUT: out std_logic_vector (DataWidth-1 downto 0) --register output
	); 
	
end PC;

--}} End of automatically maintained section

architecture RTL of PC is
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
	process (LD, INC, CLR, Q_Reg, RIN)	 
	begin 
		-- priority: LOAD > CLEAR > INCRIMENT > HOLD
		if (LD = '1') then	
			-- Allowing data to be written into the register
			Reg_Input <= RIN;
			
		elsif (CLR = '1') then 
			-- Resetting the register to ZERO
			Reg_Input <= (others => '0');
			
		elsif (INC = '1') then
			-- Incrimenting the PC
			Reg_Input <= std_logic_vector(unsigned(Q_Reg) + 1);			
			
		else  -- If all are zero then we do holding
			Reg_Input <= Q_Reg;
			
		end if;
					
	end process;	 
	
	-- Setting the output ROUT 
	ROUT <= Q_Reg;		
	

end architecture RTL;
