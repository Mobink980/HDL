library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity carry_ripple_adder_tb is
end carry_ripple_adder_tb;

architecture TB_ARCHITECTURE of carry_ripple_adder_tb is 
-- CREATING A CONSTANT NAMED DELAY
constant DELAY: delay_length := 10ns;
	-- Component declaration of the tested unit
	component carry_ripple_adder
	port(
		a : in STD_LOGIC_VECTOR(7 downto 0);
		b : in STD_LOGIC_VECTOR(7 downto 0);
		s : out STD_LOGIC_VECTOR(7 downto 0);
		cout : out STD_LOGIC_VECTOR(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal a : STD_LOGIC_VECTOR(7 downto 0) := (others =>'0');
	signal b : STD_LOGIC_VECTOR(7 downto 0) := (others =>'0');
	-- Observed signals - signals mapped to the output ports of tested entity
	signal s : STD_LOGIC_VECTOR(7 downto 0);
	signal cout : STD_LOGIC_VECTOR(7 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : carry_ripple_adder
		port map (
			a => a,
			b => b,
			s => s,
			cout => cout
		);

	-- Stimulus generation
	STIM1: a <= "00001000" after DELAY, "10101010" after 2*DELAY, "00110010" after 3*DELAY;
	STIM2: b <= "00000101" after DELAY, "01010101" after 2*DELAY, "01110101" after 3*DELAY;
	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_carry_ripple_adder of carry_ripple_adder_tb is
	for TB_ARCHITECTURE
		for UUT : carry_ripple_adder
			use entity work.carry_ripple_adder(rtl);
		end for;
	end for;
end TESTBENCH_FOR_carry_ripple_adder;

