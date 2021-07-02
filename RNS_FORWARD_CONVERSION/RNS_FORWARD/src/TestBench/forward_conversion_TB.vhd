library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity forward_conversion_tb is
	-- Generic declarations of the tested unit
		generic(
		N : INTEGER := 8 );
end forward_conversion_tb;

architecture TB_ARCHITECTURE of forward_conversion_tb is  
-- CREATING A CONSTANT NAMED DELAY
constant DELAY: delay_length := 10ns;
	-- Component declaration of the tested unit
	component forward_conversion
		generic(
		N : INTEGER := 8 );
	port(
		x : in STD_LOGIC_VECTOR((3*N)-1 downto 0);
		power_two_minus_one : out STD_LOGIC_VECTOR(N+1 downto 0);
		power_two : out STD_LOGIC_VECTOR(N+1 downto 0);
		power_two_plus_one : out STD_LOGIC_VECTOR(N+1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal x : STD_LOGIC_VECTOR((3*N)-1 downto 0) := "000000000000000100000100";
	-- Observed signals - signals mapped to the output ports of tested entity
	signal power_two_minus_one : STD_LOGIC_VECTOR(N+1 downto 0);
	signal power_two : STD_LOGIC_VECTOR(N+1 downto 0);
	signal power_two_plus_one : STD_LOGIC_VECTOR(N+1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : forward_conversion
		generic map (
			N => N
		)

		port map (
			x => x,
			power_two_minus_one => power_two_minus_one,
			power_two => power_two,
			power_two_plus_one => power_two_plus_one
		);

	-- Stimulus generation
	STIM1: x <= "010010000010000100001000" after DELAY, "101001010101101111001010" after 2*DELAY,
	"001000101011111010010010" after 3*DELAY;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_forward_conversion of forward_conversion_tb is
	for TB_ARCHITECTURE
		for UUT : forward_conversion
			use entity work.forward_conversion(rtl);
		end for;
	end for;
end TESTBENCH_FOR_forward_conversion;

