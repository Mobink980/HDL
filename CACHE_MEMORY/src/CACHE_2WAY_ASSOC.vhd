-------------------------------------------------------------------------------
--
-- Title       : CACHE_2WAY_ASSOC
-- Design      : CACHE_MEMORY
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : CACHE_2WAY_ASSOC.vhd
-- Generated   : Sun Jan 24 23:36:47 2021
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
--{entity {CACHE_2WAY_ASSOC} architecture {CACHE_2WAY_ASSOC}}

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.numeric_std.all;

entity CACHE_2WAY_ASSOC is 
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
	
	cache_row_one:   	out std_logic_vector(CacheWidth-1 downto 0);	  -- cache row
	cache_row_two:   	out std_logic_vector(CacheWidth-1 downto 0);	  -- cache row
	cache_block : 	out std_logic_vector(DataWidth-1 downto 0);	  -- cache output
	hit : 			out std_logic 		   -- cache hit
	);
end CACHE_2WAY_ASSOC;

--}} End of automatically maintained section

architecture CACHE_2WAY_ASSOC of CACHE_2WAY_ASSOC is  
type MyCache is array (2**Index-1 downto 0) of std_logic_vector(CacheWidth-1 downto 0);
signal Cache_one: MyCache := (others=>(others=>'0'));  -- Cache via initialization 
signal Cache_two: MyCache := (others=>(others=>'0'));  -- Cache via initialization 

signal cache_tag: std_logic_vector (Tag-1 downto 0);  -- Different parts of the memory address
signal cache_index: std_logic_vector (Index-1 downto 0);
signal cache_offset: std_logic;	 

signal cache_data_one: std_logic_vector (CacheWidth-1 downto 0);  
signal cache_data_two: std_logic_vector (CacheWidth-1 downto 0);

signal tag_part_one: std_logic_vector (Tag-1 downto 0);	-- the tag part in the cache  
signal tag_part_two: std_logic_vector (Tag-1 downto 0);	-- the tag part in the cache 

signal compare_out_one: std_logic; 
signal compare_out_two: std_logic; 

signal sel_0: std_logic;
signal sel_1: std_logic;

signal cache_block_one: std_logic_vector (DataWidth-1 downto 0);
signal cache_block_two: std_logic_vector (DataWidth-1 downto 0);
begin

	cache_tag <= memory_addr (11 downto 8);	 -- Address parts
	cache_index <= memory_addr (7 downto 1);
	cache_offset <= memory_addr(0);	
	
	-- Selecting the row which cache_index points at
	cache_data_one <= Cache_one(to_integer(unsigned(cache_index)));	  
	cache_row_one <= cache_data_one; 
	
	cache_data_two <= Cache_two(to_integer(unsigned(cache_index)));	  
	cache_row_two <= cache_data_two;
	
	--the Rightmost 16 bits is the data that will go to the cpu
	cache_block_one <= cache_data_one (DataWidth-1 downto 0);  
	cache_block_two <= cache_data_two (DataWidth-1 downto 0);
	
	
	-- the bits from 19 downto 16 (4 bits) are tag in the cache	
	tag_part_one <= cache_data_one (19 downto 16);
	tag_part_two <= cache_data_two (19 downto 16);
	
	
	-- instantiating the comparators
	Comparator0: entity work.FOUR_BIT_COMPARATOR(FOUR_BIT_COMPARATOR)
		port map (data_one => cache_tag, data_two => tag_part_one, F => compare_out_one);	
		
	Comparator1: entity work.FOUR_BIT_COMPARATOR(FOUR_BIT_COMPARATOR)
		port map (data_one => cache_tag, data_two => tag_part_two, F => compare_out_two);
		
		
	-- cache hit for each part is calculated separately 
	--(the Leftmost bit in the cache row is used for validity)
	sel_0 <= compare_out_one and cache_data_one(CacheWidth-1); 
	sel_1 <= compare_out_two and cache_data_two(CacheWidth-1);	
	
	-- Determining the value of cache hit
	hit <= 	sel_0 or sel_1;
	
	--%%%%%%%%%%%%%%%%%%%%% Determining the value cache_block %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	process (sel_0, sel_1, cache_block_one, cache_block_two )
	begin		
		if (sel_0 = '1' and sel_1 = '0') then 
			cache_block <= cache_block_one;
		
		elsif (sel_0 = '0' and sel_1 = '1') then
			cache_block <= cache_block_two;
			
		elsif (sel_0 = '1' and sel_1 = '1') then
			cache_block <= cache_block_one; -- if we have hit on both sides, then we use first one
			
		else
			cache_block <= (others => 'Z');
			
		end if;
		
	end process;
	--%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INITIALIZING CACHE ROWS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	

	Cache_one(0) 		<= "001110000101101011010";	-- initializing some cache rows 
	Cache_one(1) 		<= "001000100101101010101";
	Cache_one(2)	 	<= "010100111011010110110";
	Cache_one(3)	 	<= "011100101111100001010"; 
	Cache_one(4)	 	<= "010100011101011010100"; 
	Cache_one(5)	 	<= "011001010000001111010"; 	
	Cache_one(6) 		<= "101001000100110011000";	
	Cache_one(7) 		<= "110010110100111111111";	--ex
	Cache_one(8)	 	<= "001010010101111101111";
	Cache_one(9)	 	<= "111111110000011111101"; 	
	Cache_one(10)	 	<= "111111111001110111010"; 
	Cache_one(11)	 	<= "111100111101101111111"; 
	Cache_one(12)	 	<= "101010001011011010111"; --core EX (valid with the same Tag)
	Cache_one(13)	 	<= "011101100000110001101"; 
	Cache_one(14)	 	<= "111001010110101100111"; 
	Cache_one(15)	 	<= "011110010101010100111"; 
	Cache_one(16)	 	<= "111111001110111000011"; 
	Cache_one(17)	 	<= "100111011100001111111"; 
	Cache_one(18)	 	<= "101011110010100110011"; --ex
	Cache_one(19)	 	<= "110011101110000111111"; 
	Cache_one(20)	 	<= "110011101110111111000"; 
	
	
	
	Cache_two(0) 		<= "001110000101101011010";	-- initializing some cache rows 
	Cache_two(1) 		<= "001000100101101010101";
	Cache_two(2)	 	<= "010100111011010110110";
	Cache_two(3)	 	<= "011100101111100001010"; 
	Cache_two(4)	 	<= "010100011101011010100"; 
	Cache_two(5)	 	<= "011001010000001111010"; 	
	Cache_two(6) 		<= "101001000100110011000";	
	Cache_two(7) 		<= "110010110100111111111";	--ex
	Cache_two(8)	 	<= "001010010101111101111";
	Cache_two(9)	 	<= "111111110000011111101"; 	
	Cache_two(10)	 	<= "111111111001110111010"; 
	Cache_two(11)	 	<= "111100111101101111111"; 
	Cache_two(12)	 	<= "100110001011010010000"; --core EX (valid but with a different Tag)
	Cache_two(13)	 	<= "011101100000110001101"; 
	Cache_two(14)	 	<= "111001010110101100111"; 
	Cache_two(15)	 	<= "011110010101010100111"; 
	Cache_two(16)	 	<= "111111001110111000011"; 
	Cache_two(17)	 	<= "100111011100001111111"; 
	Cache_two(18)	 	<= "110111110011101110001"; --ex
	Cache_two(19)	 	<= "110011101110000111111"; 
	Cache_two(20)	 	<= "110011101110111111000"; 
	
	
	
end CACHE_2WAY_ASSOC;
