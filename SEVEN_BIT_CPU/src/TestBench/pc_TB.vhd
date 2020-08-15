library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity pc_tb is
	-- Generic declarations of the tested unit
		generic(
		AddrWidth : INTEGER := 7;
		DataWidth : INTEGER := 7 );
end pc_tb;

architecture TB_ARCHITECTURE of pc_tb is 
	constant DELAY: delay_length := 5ns;
	-- Component declaration of the tested unit
	component pc
		generic(
		AddrWidth : INTEGER := 7;
		DataWidth : INTEGER := 7 );
	port(
		clk : in STD_LOGIC;
		LD : in STD_LOGIC;
		INC : in STD_LOGIC;
		CLR : in STD_LOGIC;
		RIN : in STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		ROUT : out STD_LOGIC_VECTOR(DataWidth-1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC := '0';
	signal LD : STD_LOGIC := '0';
	signal INC : STD_LOGIC := '0';
	signal CLR : STD_LOGIC := '0';
	signal RIN : STD_LOGIC_VECTOR(DataWidth-1 downto 0) := (others => '0');
	-- Observed signals - signals mapped to the output ports of tested entity
	signal ROUT : STD_LOGIC_VECTOR(DataWidth-1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : pc
		generic map (
			AddrWidth => AddrWidth,
			DataWidth => DataWidth
		)

		port map (
			clk => clk,
			LD => LD,
			INC => INC,
			CLR => CLR,
			RIN => RIN,
			ROUT => ROUT
		);

	-- STIMULATION FOR CLOCK
	STIM0: clk <= not clk after DELAY; 
	
	-- STIMULATION FOR RIN
	STIM1: RIN <= "0000011" after 20ns,
	"0000110" after 40ns,
	"0001100" after 60ns,
	"0000000" after 80ns,
	"0111000" after 100ns,
	"0000111" after 120ns,
	"0111111" after 140ns;	   
	
	-- STIMULATION FOR LOAD	
	STIM2: LD <= '1' after 4ns,
	'0' after 63ns, 
	'1' after 80ns,
	'0' after 108ns; 
	
	-- STIMULATION FOR CLEAR	
	STIM3: CLR <= '1' after 67ns,
	'0' after 83ns;
	
	-- STIMULATION FOR INCRIMENT	
	STIM4: INC <= '1' after 79ns,
	'0' after 132ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_pc of pc_tb is
	for TB_ARCHITECTURE
		for UUT : pc
			use entity work.pc(rtl);
		end for;
	end for;
end TESTBENCH_FOR_pc;

