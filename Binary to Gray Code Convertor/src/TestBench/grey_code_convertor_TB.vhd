library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity grey_code_convertor_tb is
end grey_code_convertor_tb;

architecture TB_ARCHITECTURE of grey_code_convertor_tb is
	-- Component declaration of the tested unit
	component grey_code_convertor
	port(
		B : in STD_LOGIC_VECTOR(7 downto 0);
		G : out STD_LOGIC_VECTOR(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal B : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');	--initializing the input vector
	-- Observed signals - signals mapped to the output ports of tested entity
	signal G : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');	--initializing the output vector

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : grey_code_convertor
		port map (
			B => B,
			G => G
		);

	-- Stimulating the input vector each 20ns to see the results on output vector (G)
	B <= "00010000" after 20ns,
	"01010100" after 40ns,
	"11110000" after 60ns,
	"10101010" after 80ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_grey_code_convertor of grey_code_convertor_tb is
	for TB_ARCHITECTURE
		for UUT : grey_code_convertor
			use entity work.grey_code_convertor(example);
		end for;
	end for;
end TESTBENCH_FOR_grey_code_convertor;

