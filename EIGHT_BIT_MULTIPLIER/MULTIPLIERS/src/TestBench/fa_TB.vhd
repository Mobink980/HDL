library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity fa_tb is
end fa_tb;

architecture TB_ARCHITECTURE of fa_tb is 
-- CREATING A CONSTANT NAMED DELAY
constant DELAY: delay_length := 10ns;
	-- Component declaration of the tested unit
	component fa
	port(
		a : in STD_LOGIC;
		b : in STD_LOGIC;
		cin : in STD_LOGIC;
		sum : out STD_LOGIC;
		cout : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal a : STD_LOGIC := '0';
	signal b : STD_LOGIC := '0';
	signal cin : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal sum : STD_LOGIC;
	signal cout : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : fa
		port map (
			a => a,
			b => b,
			cin => cin,
			sum => sum,
			cout => cout
		);

	-- Stimulus generation
	STIM1: a <= not a after DELAY;
	STIM2: b <= not b after 2*DELAY;
	STIM3: cin <= not cin after 4*DELAY;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_fa of fa_tb is
	for TB_ARCHITECTURE
		for UUT : fa
			use entity work.fa(fa);
		end for;
	end for;
end TESTBENCH_FOR_fa;

