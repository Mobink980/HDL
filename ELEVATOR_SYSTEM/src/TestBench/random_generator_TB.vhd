library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity random_generator_tb is
end random_generator_tb;

architecture TB_ARCHITECTURE of random_generator_tb is
	constant DELAY: delay_length := 20ns;
	-- Component declaration of the tested unit
	component random_generator
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		interrupt : out STD_LOGIC;
		random_floor : out STD_LOGIC_VECTOR(3 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '1';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal interrupt : STD_LOGIC;
	signal random_floor : STD_LOGIC_VECTOR(3 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : random_generator
		port map (
			clk => clk,
			reset => reset,
			interrupt => interrupt,
			random_floor => random_floor
		);

	-- STIMULATION FOR CLOCK
	STIM0: clk <= not clk after DELAY; 	
	
	-- STIMULATION FOR RESET
	STIM1: reset <= '0' after 24ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_random_generator of random_generator_tb is
	for TB_ARCHITECTURE
		for UUT : random_generator
			use entity work.random_generator(rtl);
		end for;
	end for;
end TESTBENCH_FOR_random_generator;

