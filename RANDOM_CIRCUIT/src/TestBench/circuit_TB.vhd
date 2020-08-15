library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity circuit_tb is
end circuit_tb;

architecture TB_ARCHITECTURE of circuit_tb is
constant DELAY: delay_length := 5ns;
	-- Component declaration of the tested unit
	component circuit
	port(
		Clk : in STD_LOGIC;
		Reset : in STD_LOGIC;
		lfsr_data : out STD_LOGIC_VECTOR(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal Clk : STD_LOGIC := '0';
	signal Reset : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal lfsr_data : STD_LOGIC_VECTOR(7 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : circuit
		port map (
			Clk => Clk,
			Reset => Reset,
			lfsr_data => lfsr_data
		);

	-- Add your stimulus here ... 
	STIM0: Clk <= not Clk after DELAY;
	
	STIM1: Reset <= '1' after 6ns,
	'0' after 22ns;	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_circuit of circuit_tb is
	for TB_ARCHITECTURE
		for UUT : circuit
			use entity work.circuit(rtl);
		end for;
	end for;
end TESTBENCH_FOR_circuit;

