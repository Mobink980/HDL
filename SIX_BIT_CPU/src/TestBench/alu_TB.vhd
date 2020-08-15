library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity alu_tb is
	-- Generic declarations of the tested unit
		generic(
		AddrWidth : INTEGER := 6;
		DataWidth : INTEGER := 6 );
end alu_tb;

architecture TB_ARCHITECTURE of alu_tb is
	-- Component declaration of the tested unit
	component alu
		generic(
		AddrWidth : INTEGER := 6;
		DataWidth : INTEGER := 6 );
	port(
		IN1 : in STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		IN2 : in STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		CMD : in STD_LOGIC;
		ALURes : out STD_LOGIC_VECTOR(DataWidth-1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal IN1 : STD_LOGIC_VECTOR(DataWidth-1 downto 0) := (others => '0');
	signal IN2 : STD_LOGIC_VECTOR(DataWidth-1 downto 0) := (others => '0');
	signal CMD : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal ALURes : STD_LOGIC_VECTOR(DataWidth-1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : alu
		generic map (
			AddrWidth => AddrWidth,
			DataWidth => DataWidth
		)

		port map (
			IN1 => IN1,
			IN2 => IN2,
			CMD => CMD,
			ALURes => ALURes
		);

	-- STIMULATION FOR IN1
	STIM0: IN1 <= "000001" after 20ns,
	"000010" after 40ns,
	"000011" after 60ns,
	"001000" after 80ns,
	"001111" after 100ns;
		
		
	-- STIMULATION FOR IN2
	STIM1: IN2 <= "000010" after 20ns,
	"000110" after 40ns,
	"001110" after 60ns,
	"000011" after 80ns,
	"000111" after 100ns;
		
		
	-- STIMULATION FOR CMD
	STIM2: CMD <= '1' after 80ns,
	'0' after 100ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_alu of alu_tb is
	for TB_ARCHITECTURE
		for UUT : alu
			use entity work.alu(rtl);
		end for;
	end for;
end TESTBENCH_FOR_alu;

