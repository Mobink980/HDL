library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity four_to_one_mux_tb is
	-- Generic declarations of the tested unit
		generic(
		AddrWidth : INTEGER := 7;
		DataWidth : INTEGER := 7 );
end four_to_one_mux_tb;

architecture TB_ARCHITECTURE of four_to_one_mux_tb is
	-- Component declaration of the tested unit
	component four_to_one_mux
		generic(
		AddrWidth : INTEGER := 7;
		DataWidth : INTEGER := 7 );
	port(
		I0 : in STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		I1 : in STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		I2 : in STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		I3 : in STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		S0 : in STD_LOGIC;
		S1 : in STD_LOGIC;
		Y : out STD_LOGIC_VECTOR(DataWidth-1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal I0 : STD_LOGIC_VECTOR(DataWidth-1 downto 0) := "0000000";
	signal I1 : STD_LOGIC_VECTOR(DataWidth-1 downto 0) := "0000001";
	signal I2 : STD_LOGIC_VECTOR(DataWidth-1 downto 0) := "0000010";
	signal I3 : STD_LOGIC_VECTOR(DataWidth-1 downto 0) := "0000011";
	signal S0 : STD_LOGIC := '0';
	signal S1 : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Y : STD_LOGIC_VECTOR(DataWidth-1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : four_to_one_mux
		generic map (
			AddrWidth => AddrWidth,
			DataWidth => DataWidth
		)

		port map (
			I0 => I0,
			I1 => I1,
			I2 => I2,
			I3 => I3,
			S0 => S0,
			S1 => S1,
			Y => Y
		);

	-- STIMULATION FOR S1
	STIM0: S1 <= '1' after 40ns,
	'0' after 80ns;	
	
	-- STIMULATION FOR S0
	STIM1: S0 <= '1' after 20ns,
	'0' after 40ns,
	'1' after 60ns,
	'0' after 80ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_four_to_one_mux of four_to_one_mux_tb is
	for TB_ARCHITECTURE
		for UUT : four_to_one_mux
			use entity work.four_to_one_mux(rtl);
		end for;
	end for;
end TESTBENCH_FOR_four_to_one_mux;

