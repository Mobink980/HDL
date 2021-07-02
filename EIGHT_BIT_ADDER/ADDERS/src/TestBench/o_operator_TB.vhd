library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity o_operator_tb is
end o_operator_tb;

architecture TB_ARCHITECTURE of o_operator_tb is
-- CREATING A CONSTANT NAMED DELAY
constant DELAY: delay_length := 10ns;
	-- Component declaration of the tested unit
	component o_operator
	port(
		P : in STD_LOGIC;
		G : in STD_LOGIC;
		P_hat : in STD_LOGIC;
		G_hat : in STD_LOGIC;
		P_out : out STD_LOGIC;
		G_out : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal P : STD_LOGIC := '0';
	signal G : STD_LOGIC := '0';
	signal P_hat : STD_LOGIC := '0';
	signal G_hat : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal P_out : STD_LOGIC;
	signal G_out : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : o_operator
		port map (
			P => P,
			G => G,
			P_hat => P_hat,
			G_hat => G_hat,
			P_out => P_out,
			G_out => G_out
		);

	-- Stimulus generation
	STIM1: P <= not P after DELAY;
	STIM2: P_hat <= not P_hat after 2*DELAY;
	STIM3: G <= not G after 4*DELAY; 
	STIM4: G_hat <= not G_hat after 8*DELAY;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_o_operator of o_operator_tb is
	for TB_ARCHITECTURE
		for UUT : o_operator
			use entity work.o_operator(rtl);
		end for;
	end for;
end TESTBENCH_FOR_o_operator;

