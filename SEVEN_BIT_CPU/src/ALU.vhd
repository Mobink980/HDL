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
-- Generated   : Sun Jul 19 12:26:03 2020
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
	AddrWidth: integer := 7; --width of address
	DataWidth: integer := 7	 -- width of a memory cell
	); 
	
port(
	IN1: in std_logic_vector(DataWidth-1 downto 0);	
	IN2: in std_logic_vector(DataWidth-1 downto 0);	
	CMD: in std_logic_vector(1 downto 0);
	
	ALURes: out std_logic_vector(DataWidth-1 downto 0)
	);
end ALU;

--}} End of automatically maintained section

architecture RTL of ALU is
begin	
	

	-- ALU will do the Addition when CMD is zero and does Subtraction when CMD is one
	process (IN1, IN2, CMD)	
	-- The save variable is for saving the result of the multiplication and 
		-- only assigning the 7 less significant bits.
	variable save : std_logic_vector (13 downto 0);
	begin
		case CMD is
			
			when "00" => 
			-- ADDITION
			ALURes <= std_logic_vector(unsigned(IN1) + unsigned(IN2));
			
			when "01" => 
			-- SUBTRACTION
			ALURes <= std_logic_vector(unsigned(IN1) - unsigned(IN2));
			
			when "10" =>			  
			-- MULTIPLICATION
			save :=  std_logic_vector(unsigned(IN1) * unsigned(IN2));
			ALURes <=  save(6 downto 0);
			
			when others => 
			-- XOR OPERATION
			ALURes <= std_logic_vector(unsigned(IN1) XOR unsigned(IN2)); 
			
		end case;
					
		
	end process;


end architecture RTL;
