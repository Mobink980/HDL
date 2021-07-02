library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity cla_tb is
end cla_tb;

architecture TB_ARCHITECTURE of cla_tb is 
-- CREATING A CONSTANT NAMED DELAY
constant DELAY: delay_length := 10ns;
	-- Component declaration of the tested unit
	component cla
	port(
		A : in STD_LOGIC_VECTOR(3 downto 0);
		B : in STD_LOGIC_VECTOR(3 downto 0);
		cin : in STD_LOGIC;
		sum : out STD_LOGIC_VECTOR(3 downto 0);
		cout : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal A : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal B : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal cin : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal sum : STD_LOGIC_VECTOR(3 downto 0);
	signal cout : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : cla
		port map (
			A => A,
			B => B,
			cin => cin,
			sum => sum,
			cout => cout
		);

	-- Stimulus generation
	STIM1: a <= "0001" after DELAY, "1111" after 2*DELAY, "0101" after 3*DELAY;
	STIM2: b <= "1010" after DELAY, "0001" after 2*DELAY, "1110" after 3*DELAY;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_cla of cla_tb is
	for TB_ARCHITECTURE
		for UUT : cla
			use entity work.cla(rtl);
		end for;
	end for;
end TESTBENCH_FOR_cla;

