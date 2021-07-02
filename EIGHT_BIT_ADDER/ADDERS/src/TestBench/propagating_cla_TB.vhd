library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity propagating_cla_tb is
end propagating_cla_tb;

architecture TB_ARCHITECTURE of propagating_cla_tb is 
-- CREATING A CONSTANT NAMED DELAY
constant DELAY: delay_length := 10ns;
	-- Component declaration of the tested unit
	component propagating_cla
	port(
		x : in STD_LOGIC_VECTOR(7 downto 0);
		y : in STD_LOGIC_VECTOR(7 downto 0);
		s : out STD_LOGIC_VECTOR(7 downto 0);
		carry0 : out STD_LOGIC;
		carry4 : out STD_LOGIC;
		carry8 : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal x : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal y : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	-- Observed signals - signals mapped to the output ports of tested entity
	signal s : STD_LOGIC_VECTOR(7 downto 0);
	signal carry0 : STD_LOGIC;
	signal carry4 : STD_LOGIC;
	signal carry8 : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : propagating_cla
		port map (
			x => x,
			y => y,
			s => s,
			carry0 => carry0,
			carry4 => carry4,
			carry8 => carry8
		);

	-- Stimulus generation
	STIM1: x <= "01101000" after DELAY, "10101010" after 2*DELAY, "00110010" after 3*DELAY,
	"00100101" after 4*DELAY, "01000010" after 5*DELAY, "00111110" after 6*DELAY;
	STIM2: y <= "10111101" after DELAY, "01010101" after 2*DELAY, "01110101" after 3*DELAY,
	"01100101" after 4*DELAY, "00101010" after 5*DELAY, "11110010" after 6*DELAY;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_propagating_cla of propagating_cla_tb is
	for TB_ARCHITECTURE
		for UUT : propagating_cla
			use entity work.propagating_cla(rtl);
		end for;
	end for;
end TESTBENCH_FOR_propagating_cla;

