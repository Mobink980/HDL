library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity ks_adder_tb is
end ks_adder_tb;

architecture TB_ARCHITECTURE of ks_adder_tb is
-- CREATING A CONSTANT NAMED DELAY
constant DELAY: delay_length := 10ns;
	-- Component declaration of the tested unit
	component ks_adder
	port(
		x : in STD_LOGIC_VECTOR(7 downto 0);
		y : in STD_LOGIC_VECTOR(7 downto 0);
		s : out STD_LOGIC_VECTOR(7 downto 0);
		cout : out STD_LOGIC_VECTOR(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal x : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal y : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	-- Observed signals - signals mapped to the output ports of tested entity
	signal s : STD_LOGIC_VECTOR(7 downto 0);
	signal cout : STD_LOGIC_VECTOR(7 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : ks_adder
		port map (
			x => x,
			y => y,
			s => s,
			cout => cout
		);

	-- Stimulus generation
	STIM1: x <= "01101000" after DELAY, "10101010" after 2*DELAY, "00110010" after 3*DELAY,
	"00100101" after 4*DELAY, "01000010" after 5*DELAY, "00111110" after 6*DELAY;
	STIM2: y <= "10111101" after DELAY, "01010101" after 2*DELAY, "01110101" after 3*DELAY,
	"01100101" after 4*DELAY, "00101010" after 5*DELAY, "11110010" after 6*DELAY;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_ks_adder of ks_adder_tb is
	for TB_ARCHITECTURE
		for UUT : ks_adder
			use entity work.ks_adder(rtl);
		end for;
	end for;
end TESTBENCH_FOR_ks_adder;

