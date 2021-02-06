library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity four_bit_comparator_tb is
	-- Generic declarations of the tested unit
		generic(
		Length : INTEGER := 4 );
end four_bit_comparator_tb;

architecture TB_ARCHITECTURE of four_bit_comparator_tb is
	-- Component declaration of the tested unit
	component four_bit_comparator
		generic(
		Length : INTEGER := 4 );
	port(
		data_one : in STD_LOGIC_VECTOR(Length-1 downto 0);
		data_two : in STD_LOGIC_VECTOR(Length-1 downto 0);
		F : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal data_one : STD_LOGIC_VECTOR(Length-1 downto 0) := "0101";
	signal data_two : STD_LOGIC_VECTOR(Length-1 downto 0) := "0101";
	-- Observed signals - signals mapped to the output ports of tested entity
	signal F : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : four_bit_comparator
		generic map (
			Length => Length
		)

		port map (
			data_one => data_one,
			data_two => data_two,
			F => F
		);

	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_four_bit_comparator of four_bit_comparator_tb is
	for TB_ARCHITECTURE
		for UUT : four_bit_comparator
			use entity work.four_bit_comparator(four_bit_comparator);
		end for;
	end for;
end TESTBENCH_FOR_four_bit_comparator;

