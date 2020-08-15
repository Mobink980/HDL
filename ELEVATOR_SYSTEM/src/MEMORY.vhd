-------------------------------------------------------------------------------
--
-- Title       : MEMORY
-- Design      : ELEVATOR
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : MEMORY.vhd
-- Generated   : Wed Jul 22 13:11:23 2020
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
	AddrWidth: integer := 6;  -- FOUR BITS IS ENOUGH FOR 10 FLOORS
	DataWidth: integer := 8	  -- ASSUMING THAT THE ELEVATOR WON'T WAIT IN A FLOOR MORE THAN A MINUTE 
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
	
	
	-- THE FOLLOWING IS THE LIST CONTAINING THE TIME THE ELAVATOR NEEDS TO STOP IN EACH FLOOR IN SECONDS
	
	Mem(0) 		<= "00111000";	-- initializing memory cells 
	Mem(1) 		<= "00100010";
	Mem(2)	 	<= "01010011";
	Mem(3)	 	<= "01110010"; 
	Mem(4)	 	<= "01010001"; 
	Mem(5)	 	<= "01100101"; 	
	Mem(6) 		<= "10100100";	
	Mem(7) 		<= "01100011";
	Mem(8)	 	<= "00101001";
	Mem(9)	 	<= "11111111"; 
	
	
	-- Our memory is Read Only Memory (ROM),
	-- thus no writing procedure is specified
	Data <= Mem(to_integer(unsigned(Address)));
	 

end architecture RTL;
