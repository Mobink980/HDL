library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity seven_bit_cpu_tb is
	-- Generic declarations of the tested unit
		generic(
		AddrWidth : INTEGER := 7;
		DataWidth : INTEGER := 7 );
end seven_bit_cpu_tb;

architecture TB_ARCHITECTURE of seven_bit_cpu_tb is	
	constant DELAY: delay_length := 5ns;
	-- Component declaration of the tested unit
	component seven_bit_cpu
		generic(
		AddrWidth : INTEGER := 7;
		DataWidth : INTEGER := 7 );
	port(
		clk : in STD_LOGIC;
		R0 : out STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		R1 : out STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		R2 : out STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		R3 : out STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		PC : out STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		IR : out STD_LOGIC_VECTOR(DataWidth-1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal R0 : STD_LOGIC_VECTOR(DataWidth-1 downto 0);
	signal R1 : STD_LOGIC_VECTOR(DataWidth-1 downto 0);
	signal R2 : STD_LOGIC_VECTOR(DataWidth-1 downto 0);
	signal R3 : STD_LOGIC_VECTOR(DataWidth-1 downto 0);
	signal PC : STD_LOGIC_VECTOR(DataWidth-1 downto 0);
	signal IR : STD_LOGIC_VECTOR(DataWidth-1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : seven_bit_cpu
		generic map (
			AddrWidth => AddrWidth,
			DataWidth => DataWidth
		)

		port map (
			clk => clk,
			R0 => R0,
			R1 => R1,
			R2 => R2,
			R3 => R3,
			PC => PC,
			IR => IR
		);

	-- STIMULATION FOR CLOCK	 
	STIM0: clk <= not clk after DELAY;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_seven_bit_cpu of seven_bit_cpu_tb is
	for TB_ARCHITECTURE
		for UUT : seven_bit_cpu
			use entity work.seven_bit_cpu(rtl);
		end for;
	end for;
end TESTBENCH_FOR_seven_bit_cpu;

