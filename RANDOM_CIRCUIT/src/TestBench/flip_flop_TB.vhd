library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity flip_flop_tb is
end flip_flop_tb;

architecture TB_ARCHITECTURE of flip_flop_tb is	 
constant DELAY: delay_length := 5ns;
	-- Component declaration of the tested unit
	component flip_flop
	port(
		clk : in STD_LOGIC;
		d : in STD_LOGIC;
		q : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC := '0';
	signal d : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal q : STD_LOGIC := '0';

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : flip_flop
		port map (
			clk => clk,
			d => d,
			q => q
		);

	-- Add your stimulus here ...
	STIM0: Clk <= not Clk after DELAY;
	
	STIM1: d <= '1' after 6ns,
	'0' after 22ns,
	'1' after 27ns,
	'0' after 33ns,
	'1' after 37ns,
	'0' after 48ns,
	'1' after 65ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_flip_flop of flip_flop_tb is
	for TB_ARCHITECTURE
		for UUT : flip_flop
			use entity work.flip_flop(rtl);
		end for;
	end for;
end TESTBENCH_FOR_flip_flop;

