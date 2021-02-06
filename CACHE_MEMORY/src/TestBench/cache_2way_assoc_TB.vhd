library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;  
use ieee.math_real.all;

	-- Add your library and packages declaration here ...

entity cache_2way_assoc_tb is
	-- Generic declarations of the tested unit
		generic(
		AddrWidth : INTEGER := 12;
		DataWidth : INTEGER := 16;
		Offset : INTEGER := 1;
		Index : INTEGER := 7;
		Tag : INTEGER := 4;
		CacheWidth : INTEGER := 21 );
end cache_2way_assoc_tb;

architecture TB_ARCHITECTURE of cache_2way_assoc_tb is	
constant DELAY	: delay_length := 5ns;
	-- Component declaration of the tested unit
	component cache_2way_assoc
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
		cache_row_one : out STD_LOGIC_VECTOR(CacheWidth-1 downto 0);
		cache_row_two : out STD_LOGIC_VECTOR(CacheWidth-1 downto 0);
		cache_block : out STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		hit : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC := '0';
	signal memory_addr : STD_LOGIC_VECTOR(AddrWidth-1 downto 0) := (others => '0'); 
	-- Observed signals - signals mapped to the output ports of tested entity
	signal cache_row_one : STD_LOGIC_VECTOR(CacheWidth-1 downto 0);
	signal cache_row_two : STD_LOGIC_VECTOR(CacheWidth-1 downto 0);
	signal cache_block : STD_LOGIC_VECTOR(DataWidth-1 downto 0);
	signal hit : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : cache_2way_assoc
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
			cache_row_one => cache_row_one,
			cache_row_two => cache_row_two,
			cache_block => cache_block,
			hit => hit
		);

	-- STIMMULATION FOR THE CLOCK 
	STIM0: clk <= not clk after DELAY; 
	
	-- STINULATION FOR memory_addr
	STIM1: memory_addr <= "010100011001" after 10ns,
	"101100100101" after 50ns, 
	"101101101101" after 70ns,
	"100100001110" after 80ns,
	"001100001101" after 90ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_cache_2way_assoc of cache_2way_assoc_tb is
	for TB_ARCHITECTURE
		for UUT : cache_2way_assoc
			use entity work.cache_2way_assoc(cache_2way_assoc);
		end for;
	end for;
end TESTBENCH_FOR_cache_2way_assoc;

