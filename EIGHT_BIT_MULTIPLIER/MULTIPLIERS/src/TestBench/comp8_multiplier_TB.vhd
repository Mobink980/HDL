library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity comp8_multiplier_tb is
end comp8_multiplier_tb;

architecture TB_ARCHITECTURE of comp8_multiplier_tb is
-- CREATING A CONSTANT NAMED DELAY
constant DELAY: delay_length := 20ns;
	-- Component declaration of the tested unit
	component comp8_multiplier
	port(
		op0 : in STD_LOGIC_VECTOR(7 downto 0);
		op1 : in STD_LOGIC_VECTOR(7 downto 0);
		answer : out STD_LOGIC_VECTOR(15 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal op0 : STD_LOGIC_VECTOR(7 downto 0) := "10111110";
	signal op1 : STD_LOGIC_VECTOR(7 downto 0) := "01100101";
	-- Observed signals - signals mapped to the output ports of tested entity
	signal answer : STD_LOGIC_VECTOR(15 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : comp8_multiplier
		port map (
			op0 => op0,
			op1 => op1,
			answer => answer
		);

	--STIMULATION OF INPUT SIGNALS
	STIM0: op0 <= "01010100" after DELAY, "00001011" after 2*DELAY, "00000011" after 3*DELAY, 
	"00001000" after 4*DELAY, "00011011" after 5*DELAY, "00001011" after 6*DELAY, 
	"00001011" after 7*DELAY, "00001011" after 8*DELAY;    
	STIM1: op1 <= "00010100" after DELAY, "00001011" after 2*DELAY, "00000101" after 3*DELAY, 
	"00000100" after 4*DELAY, "00001011" after 5*DELAY, "11111110" after 6*DELAY, 
	"00000011" after 7*DELAY, "00001000" after 8*DELAY;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_comp8_multiplier of comp8_multiplier_tb is
	for TB_ARCHITECTURE
		for UUT : comp8_multiplier
			use entity work.comp8_multiplier(rtl);
		end for;
	end for;
end TESTBENCH_FOR_comp8_multiplier;

