library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity priority_encoder_tb is
end priority_encoder_tb;

architecture TB_ARCHITECTURE of priority_encoder_tb is
	-- Component declaration of the tested unit
	component priority_encoder
	port(
		D : in STD_LOGIC_VECTOR(15 downto 0);
		Q : out STD_LOGIC_VECTOR(3 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal D : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000001"; --initialize the input vector 
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Q : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');	--initialize the output vector 

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : priority_encoder
		port map (
			D => D,
			Q => Q
		);	
		
		--stimulus generation on the input vector to see their effects on the output vector
		STIM: D <= "0000000000000010" after 10ns,
		"0000000000000100" after 20ns,
		"0000000000001000" after 30ns,
		"0000000000010000" after 40ns,
		"0000000000100000" after 50ns,
		"0000000001000000" after 60ns,
		"0000000010000000" after 70ns,
		"0000000100000000" after 80ns,
		"0000001000000000" after 90ns,
		"0000010000000000" after 100ns,
		"0000100000000000" after 110ns,
		"0001000000000000" after 120ns,
		"0010000000000000" after 130ns,
		"0100000000000000" after 140ns,
		"1000000000000000" after 150ns;
		


	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_priority_encoder of priority_encoder_tb is
	for TB_ARCHITECTURE
		for UUT : priority_encoder
			use entity work.priority_encoder(example);
		end for;
	end for;
end TESTBENCH_FOR_priority_encoder;

