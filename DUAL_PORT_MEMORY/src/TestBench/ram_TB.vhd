library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity ram_tb is
	-- Generic declarations of the tested unit
		generic(
		AddrWidth : INTEGER := 8;
		DataWidth : INTEGER := 8 );
end ram_tb;

architecture TB_ARCHITECTURE of ram_tb is
--defining constant DELAY
constant DELAY: delay_length := 2.5ns;
	-- Component declaration of the tested unit
	component ram
		generic(
		AddrWidth : INTEGER := 8;
		DataWidth : INTEGER := 8 );
	port(
		clk : in STD_LOGIC;
		CS1 : in STD_LOGIC;
		CS2 : in STD_LOGIC;
		WE1 : in STD_LOGIC;
		WE2 : in STD_LOGIC;
		Addr1 : in STD_LOGIC_VECTOR(AddrWidth-1 downto 0);
		Addr2 : in STD_LOGIC_VECTOR(AddrWidth-1 downto 0);
		Data1 : inout STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		Data2 : inout STD_LOGIC_VECTOR(DataWidth-1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC := '0';
	signal CS1 : STD_LOGIC := '1';
	signal CS2 : STD_LOGIC := '1';
	signal WE1 : STD_LOGIC := '0';
	signal WE2 : STD_LOGIC := '0';
	signal Addr1 : STD_LOGIC_VECTOR(AddrWidth-1 downto 0) := (others => '0');
	signal Addr2 : STD_LOGIC_VECTOR(AddrWidth-1 downto 0) := (others => '0');
	signal Data1 : STD_LOGIC_VECTOR(DataWidth-1 downto 0) := (others => '0');
	signal Data2 : STD_LOGIC_VECTOR(DataWidth-1 downto 0) := (others => '0');
	-- Observed signals - signals mapped to the output ports of tested entity

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : ram
		generic map (
			AddrWidth => AddrWidth,
			DataWidth => DataWidth
		)

		port map (
			clk => clk,
			CS1 => CS1,
			CS2 => CS2,
			WE1 => WE1,
			WE2 => WE2,
			Addr1 => Addr1,
			Addr2 => Addr2,
			Data1 => Data1,
			Data2 => Data2
		);

	-- STIMULATION FOR CLOCK	 
	STIM0: clk <= not clk after DELAY;
	
	-- STIMULATION FOR CS1
	STIM1: CS1 <= not CS1 after 69ns;			
	-- STIMULATION FOR CS2
	STIM2: CS2 <= not CS2 after 71ns;	
	-- STIMULATION FOR WE1
	STIM3: WE1 <= not WE1 after 23ns;	
	-- STIMULATION FOR WE2
	STIM4: WE2 <= not WE2 after 32ns;
	
	-- STIMULATION FOR Addr1
	STIM5: Addr1 <= "00100010" after 13ns,
	"01001010" after 21ns,
	"00100111" after 41ns,
	"11011010" after 65ns,
	"01001101" after 105ns;
	-- STIMULATION FOR Addr2
	STIM6: Addr2 <= "00100010" after 13ns,
	"01001010" after 22ns,
	"00110111" after 43ns,
	"11000010" after 69ns,
	"01000101" after 95ns;
	
	-- STIMULATON FOR Data1 and Data2
	Data_process :process(WE1, WE2)
	begin
		if(WE1 = '1') then
			Data1 <= "11111111";
		else
			Data1 <= "ZZZZZZZZ";
		end if;
		
		if (WE2 = '1') then
			Data2 <= "01110111"; 
		else
			Data2 <= "ZZZZZZZZ";
		end if;
	end process;

	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_ram of ram_tb is
	for TB_ARCHITECTURE
		for UUT : ram
			use entity work.ram(rtl);
		end for;
	end for;
end TESTBENCH_FOR_ram;

