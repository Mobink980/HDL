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
-- Generated   : Sun Jul 19 12:28:16 2020
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
	AddrWidth: integer := 7;
	DataWidth: integer := 7
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
	
	Mem(0) 		<= "0000011";	-- initializing memory cells with our program
	Mem(1) 		<= "0001000";
	Mem(2)	 	<= "0000111";
	Mem(3)	 	<= "0000101"; 
	Mem(4)	 	<= "0001011"; 
	Mem(5)	 	<= "0000011"; 	
	Mem(6) 		<= "0001111";	
	Mem(7) 		<= "0000001";
	Mem(8)	 	<= "0110001";
	Mem(9)	 	<= "1000001"; 
	Mem(10)	 	<= "0101011";
	Mem(11)	 	<= "1111011"; 
	Mem(12)	 	<= "0001001";
	Mem(13)	 	<= "0011100";
	Mem(14)	 	<= "0000000";
	
	
	-- Our memory is Read Only Memory (ROM),
	-- thus no writing procedure is specified
	Data <= Mem(to_integer(unsigned(Address)));
	 

end architecture RTL;
