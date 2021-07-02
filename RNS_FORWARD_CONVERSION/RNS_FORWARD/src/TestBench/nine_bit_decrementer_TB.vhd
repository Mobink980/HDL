library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity nine_bit_decrementer_tb is
end nine_bit_decrementer_tb;

architecture TB_ARCHITECTURE of nine_bit_decrementer_tb is
	-- Component declaration of the tested unit
	component nine_bit_decrementer
	port(
		x : in STD_LOGIC_VECTOR(8 downto 0);
		carry : in STD_LOGIC;
		y : out STD_LOGIC_VECTOR(8 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal x : STD_LOGIC_VECTOR(8 downto 0) := "000001011";
	signal carry : STD_LOGIC := '1';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal y : STD_LOGIC_VECTOR(8 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : nine_bit_decrementer
		port map (
			x => x,
			carry => carry,
			y => y
		);

	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_nine_bit_decrementer of nine_bit_decrementer_tb is
	for TB_ARCHITECTURE
		for UUT : nine_bit_decrementer
			use entity work.nine_bit_decrementer(rtl);
		end for;
	end for;
end TESTBENCH_FOR_nine_bit_decrementer;

