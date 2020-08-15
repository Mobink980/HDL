-------------------------------------------------------------------------------
--
-- Title       : MEMORY
-- Design      : CPU
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : MEMORY.vhd
-- Generated   : Fri Jul 10 01:26:32 2020
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
--{entity {MEMORY} architecture {MEMORY}}

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.numeric_std.all;

entity MEMORY is
generic (
	AddrWidth: integer := 6;
	DataWidth: integer := 6
	); 
	
port(
	Address: in std_logic_vector(AddrWidth-1 downto 0);
	Data: out std_logic_vector(DataWidth-1 downto 0)
	);
end MEMORY;

--}} End of automatically maintained section

architecture RTL of MEMORY is
type MyMem is array (2**AddrWidth-1 downto 0) of std_logic_vector(DataWidth-1 downto 0);
signal Mem: MyMem := (others=>(others=>'Z')); -- Memory via initialization 
begin  
--	Mem(0) 		<= "101111";	-- initializing memory cells (In simulation for the memory)
--	Mem(18) 	<= "100011";
--	Mem(15) 	<= "101101";
--	Mem(58) 	<= "110011"; 
	
--	Mem(0) 		<= "000011";	-- initializing memory cells (ADDING TWO NUMBERS)
--	Mem(1) 		<= "000101";
--	Mem(2)	 	<= "000111";
--	Mem(3)	 	<= "000011"; 
--	Mem(4)	 	<= "010001"; 
--	Mem(5)	 	<= "000000";  
	
	
	Mem(0) 		<= "000011";	-- initializing memory cells (MULTIPLYING TWO NUMBERS)
	Mem(1) 		<= "001000";
	Mem(2)	 	<= "000111";
	Mem(3)	 	<= "001000"; 
	Mem(4)	 	<= "001011"; 
	Mem(5)	 	<= "000110"; 	
	Mem(6) 		<= "001111";	
	Mem(7) 		<= "000001";
	Mem(8)	 	<= "010001";
	Mem(9)	 	<= "101011"; 
	Mem(10)	 	<= "111011";
	Mem(11)	 	<= "001000"; 
	Mem(12)	 	<= "000000";
	
	
	-- Our memory is Read Only Memory (ROM),
	-- thus no writing procedure is specified
	Data <= Mem(to_integer(unsigned(Address)));
	 

end architecture RTL;
