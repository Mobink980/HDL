library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity memory_tb is
	-- Generic declarations of the tested unit
		generic(
		AddrWidth : INTEGER := 6;
		DataWidth : INTEGER := 8 );
end memory_tb;

architecture TB_ARCHITECTURE of memory_tb is
	-- Component declaration of the tested unit
	component memory
		generic(
		AddrWidth : INTEGER := 6;
		DataWidth : INTEGER := 8 );
	port(
		Address : in STD_LOGIC_VECTOR(AddrWidth-1 downto 0);
		Data : out STD_LOGIC_VECTOR(DataWidth-1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal Address : STD_LOGIC_VECTOR(AddrWidth-1 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Data : STD_LOGIC_VECTOR(DataWidth-1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : memory
		generic map (
			AddrWidth => AddrWidth,
			DataWidth => DataWidth
		)

		port map (
			Address => Address,
			Data => Data
		);

	-- STIMULATION FOR Address
	STIM0: Address <= "000000",
	"000001" after 16ns,
	"000010" after 21ns,
	"000011" after 41ns,
	"000100" after 65ns,
	"000101" after 105ns,
	"000110" after 125ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_memory of memory_tb is
	for TB_ARCHITECTURE
		for UUT : memory
			use entity work.memory(rtl);
		end for;
	end for;
end TESTBENCH_FOR_memory;

