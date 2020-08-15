library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity ir_tb is
	-- Generic declarations of the tested unit
		generic(
		AddrWidth : INTEGER := 6;
		DataWidth : INTEGER := 6 );
end ir_tb;

architecture TB_ARCHITECTURE of ir_tb is
	constant DELAY: delay_length := 5ns;
	-- Component declaration of the tested unit
	component ir
		generic(
		AddrWidth : INTEGER := 6;
		DataWidth : INTEGER := 6 );
	port(
		clk : in STD_LOGIC;
		LD : in STD_LOGIC;
		RIN : in STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		ROUT : out STD_LOGIC_VECTOR(DataWidth-1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC := '0';
	signal LD : STD_LOGIC := '0';
	signal RIN : STD_LOGIC_VECTOR(DataWidth-1 downto 0) := (others => '0');
	-- Observed signals - signals mapped to the output ports of tested entity
	signal ROUT : STD_LOGIC_VECTOR(DataWidth-1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : ir
		generic map (
			AddrWidth => AddrWidth,
			DataWidth => DataWidth
		)

		port map (
			clk => clk,
			LD => LD,
			RIN => RIN,
			ROUT => ROUT
		);

	-- STIMULATION FOR CLOCK
	STIM0: clk <= not clk after DELAY;
	
	-- STIMULATION FOR RIN
	STIM1: RIN <= "000011" after 20ns,
	"000110" after 40ns,
	"001100" after 60ns,
	"000000" after 80ns,
	"111000" after 100ns,
	"000111" after 120ns,
	"111111" after 140ns;	   
	
	-- STIMULATION FOR LOAD	
	STIM2: LD <= '1' after 4ns,
	'0' after 63ns, 
	'1' after 80ns,
	'0' after 108ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_ir of ir_tb is
	for TB_ARCHITECTURE
		for UUT : ir
			use entity work.ir(rtl);
		end for;
	end for;
end TESTBENCH_FOR_ir;

