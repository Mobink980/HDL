library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity compressor_5_to_2_tb is
end compressor_5_to_2_tb;

architecture TB_ARCHITECTURE of compressor_5_to_2_tb is	
-- CREATING A CONSTANT NAMED DELAY
constant DELAY: delay_length := 10ns;
	-- Component declaration of the tested unit
	component compressor_5_to_2
	port(
		x : in STD_LOGIC_VECTOR(4 downto 0);
		cin1 : in STD_LOGIC;
		cin2 : in STD_LOGIC;
		cout1 : out STD_LOGIC;
		cout2 : out STD_LOGIC;
		s : out STD_LOGIC;
		c : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal x : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
	signal cin1 : STD_LOGIC := '0';
	signal cin2 : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal cout1 : STD_LOGIC;
	signal cout2 : STD_LOGIC;
	signal s : STD_LOGIC;
	signal c : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : compressor_5_to_2
		port map (
			x => x,
			cin1 => cin1,
			cin2 => cin2,
			cout1 => cout1,
			cout2 => cout2,
			s => s,
			c => c
		);

	--STIMULATION OF INPUT SIGNALS
	STIM0: x(0) <= not x(0) after DELAY;  
	STIM1: x(1) <= not x(1) after 2*DELAY;
	STIM2: x(2) <= not x(2) after 4*DELAY;
	STIM3: x(3) <= not x(3) after 8*DELAY;
	STIM4: x(4) <= not x(4) after 16*DELAY;
	STIM5: cin1 <= not cin1 after 32*DELAY;	
	STIM6: cin2 <= not cin2 after 64*DELAY;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_compressor_5_to_2 of compressor_5_to_2_tb is
	for TB_ARCHITECTURE
		for UUT : compressor_5_to_2
			use entity work.compressor_5_to_2(rtl);
		end for;
	end for;
end TESTBENCH_FOR_compressor_5_to_2;

