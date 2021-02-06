-------------------------------------------------------------------------------
--
-- Title       : CACHE
-- Design      : CACHE_MEMORY
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : CACHE_DIRECT_MAPPED.vhd
-- Generated   : Sun Jan 24 19:31:09 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.numeric_std.all;

entity CACHE is	 
	
	generic (
	AddrWidth	: integer := 12;  -- LENGTH OF ADDRESS
	DataWidth	: integer := 16;  -- LENGTH OF DATA  
	Offset   	: integer := 1;   -- TO SELECT BYTE WITHIN THE BLOCK
	Index    	: integer := 7;   -- FOR SELECTING A ROW (OR BLOCK) IN CACHE
	Tag      	: integer := 4;   -- TO DIFFERENTIATE BETWEEN MEMORY BLOCKS THAT ARE MAPPED TO THE SAME LOCCATION 
	CacheWidth	: integer := 21	  -- WIDTH OF CACHE	(valid + Tag + DataWidth)
	); 
	
	port (
	clk: 			in std_logic; -- for synchronization
	memory_addr: 	in std_logic_vector(AddrWidth-1 downto 0);	-- memory address
	
	cache_row:   	out std_logic_vector(CacheWidth-1 downto 0);	  -- cache row
	cache_block : 	out std_logic_vector(DataWidth-1 downto 0);	  -- cache output
	hit : 			out std_logic 		   -- cache hit
	);
end CACHE;

--}} End of automatically maintained section

architecture RTL of CACHE is  
type MyMem is array (2**AddrWidth-1 downto 0) of std_logic_vector(DataWidth-1 downto 0);
signal Mem: MyMem := (others=>(others=>'Z')); -- Memory via initialization 	
type MyCache is array (2**Index-1 downto 0) of std_logic_vector(CacheWidth-1 downto 0);
signal Cache: MyCache := (others=>(others=>'0'));  -- Cache via initialization 

signal cache_tag: std_logic_vector (Tag-1 downto 0);  -- Different parts of the memory address
signal cache_index: std_logic_vector (Index-1 downto 0);
signal cache_offset: std_logic;	 

signal cache_data: std_logic_vector (CacheWidth-1 downto 0); 
signal tag_part: std_logic_vector (Tag-1 downto 0);	-- the tag part in the cache  
signal compare_out: std_logic; 
begin
	
	
	
	cache_tag <= memory_addr (11 downto 8);	  -- Address parts
	cache_index <= memory_addr (7 downto 1);
	cache_offset <= memory_addr(0);	  
	
	

	-- Selecting the row which cache_index points at
	cache_data <= Cache(to_integer(unsigned(cache_index)));	  
	cache_row <= cache_data;
	
	--the Rightmost 16 bits which is the data will go to the output
	cache_block <= cache_data (DataWidth-1 downto 0); 
	
	-- the bits from 19 downto 16 (4 bits) are tag in the cache	
	tag_part <= cache_data (19 downto 16);
	
	
	-- instantiating the comparator
	Comparator0: entity work.FOUR_BIT_COMPARATOR(FOUR_BIT_COMPARATOR)
		port map (data_one => cache_tag, data_two => tag_part, F => compare_out);
	
	
	-- cache hit result (the Leftmost bit in the cache row is used for validity)
	hit <= compare_out and cache_data(CacheWidth-1);
	
	
	
	
	Cache(0) 		<= "001110000101101011010";	-- initializing some cache rows 
	Cache(1) 		<= "001000100101101010101";
	Cache(2)	 	<= "010100111011010110110";
	Cache(3)	 	<= "011100101111100001010"; 
	Cache(4)	 	<= "010100011101011010100"; 
	Cache(5)	 	<= "011001010000001111010"; 	
	Cache(6) 		<= "101001000100110011000";	
	Cache(7) 		<= "011000110100111111111";
	Cache(8)	 	<= "001010010101111101111";
	Cache(9)	 	<= "111111110000011111101"; 	
	Cache(10)	 	<= "111111111001110111010"; 
	Cache(11)	 	<= "111100111101101111111"; 
	Cache(12)	 	<= "101010001011011010111"; --core EX
	Cache(13)	 	<= "011101100000110001101"; 
	Cache(14)	 	<= "111001010110101100111"; 
	Cache(15)	 	<= "011110010101010100111"; 
	Cache(16)	 	<= "111111001110111000011"; 
	Cache(17)	 	<= "100111011100001111111"; 
	Cache(18)	 	<= "111011110011101110001"; 
	Cache(19)	 	<= "110011101110000111111"; 
	Cache(20)	 	<= "110011101110111111000"; 
	

end architecture RTL;
