library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity two_to_one_mux_tb is
	-- Generic declarations of the tested unit
		generic(
		AddrWidth : INTEGER := 6;
		DataWidth : INTEGER := 6 );
end two_to_one_mux_tb;

architecture TB_ARCHITECTURE of two_to_one_mux_tb is
	-- Component declaration of the tested unit
	component two_to_one_mux
		generic(
		AddrWidth : INTEGER := 6;
		DataWidth : INTEGER := 6 );
	port(
		I0 : in STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		I1 : in STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		S : in STD_LOGIC;
		Y : out STD_LOGIC_VECTOR(DataWidth-1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal I0 : STD_LOGIC_VECTOR(DataWidth-1 downto 0) := (others => '0');
	signal I1 : STD_LOGIC_VECTOR(DataWidth-1 downto 0) := (others => '1');
	signal S : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Y : STD_LOGIC_VECTOR(DataWidth-1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : two_to_one_mux
		generic map (
			AddrWidth => AddrWidth,
			DataWidth => DataWidth
		)

		port map (
			I0 => I0,
			I1 => I1,
			S => S,
			Y => Y
		);

	-- STIMULATION FOR S
	STIM0: S <= '1' after 20ns,
	'0' after 40ns,
	'1' after 60ns,
	'0' after 80ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_two_to_one_mux of two_to_one_mux_tb is
	for TB_ARCHITECTURE
		for UUT : two_to_one_mux
			use entity work.two_to_one_mux(rtl);
		end for;
	end for;
end TESTBENCH_FOR_two_to_one_mux;

