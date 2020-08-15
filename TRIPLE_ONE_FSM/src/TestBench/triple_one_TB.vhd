library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity triple_one_tb is
end triple_one_tb;

architecture TB_ARCHITECTURE of triple_one_tb is 
--defining constant DELAY
constant DELAY: delay_length := 5ns;
	-- Component declaration of the tested unit
	component triple_one
	port(
		d : in STD_LOGIC;
		reset : in STD_LOGIC;
		clk : in STD_LOGIC;
		q : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal d : STD_LOGIC :='0';
	signal reset : STD_LOGIC :='0';
	signal clk : STD_LOGIC :='0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal q : STD_LOGIC :='0';

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : triple_one
		port map (
			d => d,
			reset => reset,
			clk => clk,
			q => q
		);

	-- STIMULATION FOR CLOCK	 
	STIM0: clk <= not clk after DELAY;
	
	-- STIMULATION OF THE INPUT OF THE FSM
	STIM1: d <= '1' after 20ns,
	'0' after 60ns,
	'1' after 70ns,
	'0' after 90ns, 
	'1' after 100ns,
	'0' after 200ns;
	
	-- STIMULATION OF THE ASYNCHRONOUS RESET
	STIM2: reset <= '1' after 110ns,
	'0' after 130ns;
	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_triple_one of triple_one_tb is
	for TB_ARCHITECTURE
		for UUT : triple_one
			use entity work.triple_one(example);
		end for;
	end for;
end TESTBENCH_FOR_triple_one;

