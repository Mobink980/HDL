-------------------------------------------------------------------------------
--
-- Title       : ALU
-- Design      : CPU
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : ALU.vhd
-- Generated   : Fri Jul 10 12:15:51 2020
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
--{entity {ALU} architecture {ALU}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;	 
use IEEE.numeric_std.all;

entity ALU is
	
generic (
	AddrWidth: integer := 6; --width of address
	DataWidth: integer := 6	 -- width of a memory cell
	); 
	
port(
	IN1: in std_logic_vector(DataWidth-1 downto 0);	
	IN2: in std_logic_vector(DataWidth-1 downto 0);	
	CMD: in std_logic;
	
	ALURes: out std_logic_vector(DataWidth-1 downto 0)
	);
end ALU;

--}} End of automatically maintained section

architecture RTL of ALU is
begin	
	

	-- ALU will do the Addition when CMD is zero and does Subtraction when CMD is one
	ALURes <= std_logic_vector(unsigned(IN1) + unsigned(IN2)) when (CMD = '0') 
	else std_logic_vector(unsigned(IN1) - unsigned(IN2));

end architecture RTL;
