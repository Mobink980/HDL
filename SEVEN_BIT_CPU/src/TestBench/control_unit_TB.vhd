library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity control_unit_tb is
	-- Generic declarations of the tested unit
		generic(
		AddrWidth : INTEGER := 7;
		DataWidth : INTEGER := 7 );
end control_unit_tb;

architecture TB_ARCHITECTURE of control_unit_tb is
constant DELAY: delay_length := 5ns;
	-- Component declaration of the tested unit
	component control_unit
		generic(
		AddrWidth : INTEGER := 7;
		DataWidth : INTEGER := 7 );
	port(
		clk : in STD_LOGIC;
		ZR0 : in STD_LOGIC;
		ZR1 : in STD_LOGIC;
		ZR2 : in STD_LOGIC;
		ZR3 : in STD_LOGIC;
		ROUTIR : in STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		LD0 : out STD_LOGIC;
		LD1 : out STD_LOGIC;
		LD2 : out STD_LOGIC;
		LD3 : out STD_LOGIC;
		LDPC : out STD_LOGIC;
		LDIR : out STD_LOGIC;
		S00 : out STD_LOGIC;
		S01 : out STD_LOGIC;
		S10 : out STD_LOGIC;
		S11 : out STD_LOGIC;
		Bus_Sel : out STD_LOGIC;
		CMD : out STD_LOGIC_VECTOR(1 downto 0);
		INC : out STD_LOGIC;
		RST : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC := '0';
	signal ZR0 : STD_LOGIC := '0';
	signal ZR1 : STD_LOGIC := '0';
	signal ZR2 : STD_LOGIC := '0';
	signal ZR3 : STD_LOGIC := '0';
	signal ROUTIR : STD_LOGIC_VECTOR(DataWidth-1 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal LD0 : STD_LOGIC;
	signal LD1 : STD_LOGIC;
	signal LD2 : STD_LOGIC;
	signal LD3 : STD_LOGIC;
	signal LDPC : STD_LOGIC;
	signal LDIR : STD_LOGIC;
	signal S00 : STD_LOGIC;
	signal S01 : STD_LOGIC;
	signal S10 : STD_LOGIC;
	signal S11 : STD_LOGIC;
	signal Bus_Sel : STD_LOGIC;
	signal CMD : STD_LOGIC_VECTOR(1 downto 0);
	signal INC : STD_LOGIC;
	signal RST : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : control_unit
		generic map (
			AddrWidth => AddrWidth,
			DataWidth => DataWidth
		)

		port map (
			clk => clk,
			ZR0 => ZR0,
			ZR1 => ZR1,
			ZR2 => ZR2,
			ZR3 => ZR3,
			ROUTIR => ROUTIR,
			LD0 => LD0,
			LD1 => LD1,
			LD2 => LD2,
			LD3 => LD3,
			LDPC => LDPC,
			LDIR => LDIR,
			S00 => S00,
			S01 => S01,
			S10 => S10,
			S11 => S11,
			Bus_Sel => Bus_Sel,
			CMD => CMD,
			INC => INC,
			RST => RST
		);

	 -- STIMULATION FOR CLOCK	 
	STIM0: clk <= not clk after DELAY; 
	
	-- STIMULATION FOR ROUTIR  
	-- (Instruction should be changed on the rising edge of the clock where we go to the fetch phase)
	STIM1: ROUTIR <= "0000011" after 15ns,
	"0000111" after 45ns,
	"0001011" after 75ns,
	"0001111" after 105ns,
	"0110001" after 135ns,
	"1000001" after 165ns, 
	"0101011" after 195ns,
	"1111011" after 225ns,
	"0011100" after 255ns,
	"0000000" after 285ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_control_unit of control_unit_tb is
	for TB_ARCHITECTURE
		for UUT : control_unit
			use entity work.control_unit(rtl);
		end for;
	end for;
end TESTBENCH_FOR_control_unit;

