library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity memory_tb is
	-- Generic declarations of the tested unit
		generic(
		AddrWidth : INTEGER := 7;
		DataWidth : INTEGER := 7 );
end memory_tb;

architecture TB_ARCHITECTURE of memory_tb is 
--defining constant DELAY
constant DELAY: delay_length := 5ns;
	-- Component declaration of the tested unit
	component memory
		generic(
		AddrWidth : INTEGER := 7;
		DataWidth : INTEGER := 7 );
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
	STIM0: Address <= "0000000",
	"0000001" after 16ns,
	"0000010" after 21ns,
	"0000011" after 41ns,
	"0000100" after 65ns,
	"0100101" after 105ns,
	"0000101" after 125ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_memory of memory_tb is
	for TB_ARCHITECTURE
		for UUT : memory
			use entity work.memory(rtl);
		end for;
	end for;
end TESTBENCH_FOR_memory;

