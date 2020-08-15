library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity counter_tb is
end counter_tb;

architecture TB_ARCHITECTURE of counter_tb is
	constant DELAY: delay_length := 2.5ns;
	-- Component declaration of the tested unit
	component counter
	port(
		Clk : in STD_LOGIC;
		CountEn : in STD_LOGIC;
		Q : out INTEGER range 0 to 55 );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal Clk : STD_LOGIC := '0';
	signal CountEn : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Q : INTEGER range 0 to 55 := 0;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : counter
		port map (
			Clk => Clk,
			CountEn => CountEn,
			Q => Q
		);

	-- Add your stimulus here ... 
	STIM0: Clk <= not Clk after DELAY;
	STIM1: CountEn <= '1' after 5ns,
	'0' after 50ns,
	'1' after 65ns;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_counter of counter_tb is
	for TB_ARCHITECTURE
		for UUT : counter
			use entity work.counter(rtl);
		end for;
	end for;
end TESTBENCH_FOR_counter;

