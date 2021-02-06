library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;  
use ieee.math_real.all;

	-- Add your library and packages declaration here ...

entity cache_tb is
	-- Generic declarations of the tested unit
		generic(
		AddrWidth : INTEGER := 12;
		DataWidth : INTEGER := 16;
		Offset : INTEGER := 1;
		Index : INTEGER := 7;
		Tag : INTEGER := 4;
		CacheWidth : INTEGER := 21 );
end cache_tb;

architecture TB_ARCHITECTURE of cache_tb is	 
constant DELAY	: delay_length := 5ns;	
signal num_bin: std_logic_vector (AddrWidth-1 downto 0); --random number

	-- Component declaration of the tested unit
	component cache
		generic(
		AddrWidth : INTEGER := 12;
		DataWidth : INTEGER := 16;
		Offset : INTEGER := 1;
		Index : INTEGER := 7;
		Tag : INTEGER := 4;
		CacheWidth : INTEGER := 21 );
	port(
		clk : in STD_LOGIC;
		memory_addr : in STD_LOGIC_VECTOR(AddrWidth-1 downto 0);
		cache_row : out STD_LOGIC_VECTOR(CacheWidth-1 downto 0);
		cache_block : out STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		hit : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC := '0';
	signal memory_addr : STD_LOGIC_VECTOR(AddrWidth-1 downto 0) := "010100011001";
	-- Observed signals - signals mapped to the output ports of tested entity
	signal cache_row : STD_LOGIC_VECTOR(CacheWidth-1 downto 0);
	signal cache_block : STD_LOGIC_VECTOR(DataWidth-1 downto 0);
	signal hit : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : cache
		generic map (
			AddrWidth => AddrWidth,
			DataWidth => DataWidth,
			Offset => Offset,
			Index => Index,
			Tag => Tag,
			CacheWidth => CacheWidth
		)

		port map (
			clk => clk,
			memory_addr => memory_addr,
			cache_row => cache_row,
			cache_block => cache_block,
			hit => hit
		);

	-- STIMMULATION FOR THE CLOCK 
	STIM0: clk <= not clk after DELAY; 	
	
	-- STINULATION FOR memory_addr
	NOLABEL:
    process
    variable seed1 :positive ;
    variable seed2 :positive ;
    variable re1 : integer;
    variable re2 : real ;
    begin  

    	uniform (seed1,seed2,re2); -- generating random vectors
    	re1 := integer (re2 * real(2**5 -1));  
    	num_bin <= std_logic_vector ( to_unsigned (re1, AddrWidth));

    	wait until rising_edge(clk); 
		
		memory_addr <= num_bin;

    end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_cache of cache_tb is
	for TB_ARCHITECTURE
		for UUT : cache
			use entity work.cache(rtl);
		end for;
	end for;
end TESTBENCH_FOR_cache;

