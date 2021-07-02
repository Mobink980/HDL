library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity eight_bit_incrementer_tb is
end eight_bit_incrementer_tb;

architecture TB_ARCHITECTURE of eight_bit_incrementer_tb is
	-- Component declaration of the tested unit
	component eight_bit_incrementer
	port(
		x : in STD_LOGIC_VECTOR(7 downto 0);
		cin : in STD_LOGIC;
		y : out STD_LOGIC_VECTOR(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal x : STD_LOGIC_VECTOR(7 downto 0) := "00101110";
	signal cin : STD_LOGIC := '1';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal y : STD_LOGIC_VECTOR(7 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : eight_bit_incrementer
		port map (
			x => x,
			cin => cin,
			y => y
		);

	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_eight_bit_incrementer of eight_bit_incrementer_tb is
	for TB_ARCHITECTURE
		for UUT : eight_bit_incrementer
			use entity work.eight_bit_incrementer(rtl);
		end for;
	end for;
end TESTBENCH_FOR_eight_bit_incrementer;

