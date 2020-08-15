library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity register_64bit_tb is
end register_64bit_tb;

architecture TB_ARCHITECTURE of register_64bit_tb is 
	constant DELAY: delay_length := 5ns;
	-- Component declaration of the tested unit
	component register_64bit
	port(
		Clk : in STD_LOGIC;
		Reset : in STD_LOGIC;
		Load : in STD_LOGIC;
		ShL : in STD_LOGIC;
		ShR : in STD_LOGIC;
		DataIn : in STD_LOGIC_VECTOR(63 downto 0);
		Q : out STD_LOGIC_VECTOR(63 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal Clk : STD_LOGIC := '0';
	signal Reset : STD_LOGIC:= '0';
	signal Load : STD_LOGIC:= '0';
	signal ShL : STD_LOGIC:= '0';
	signal ShR : STD_LOGIC:= '0';
	signal DataIn : STD_LOGIC_VECTOR(63 downto 0) := x"0000000000000003";
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Q : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : register_64bit
		port map (
			Clk => Clk,
			Reset => Reset,
			Load => Load,
			ShL => ShL,
			ShR => ShR,
			DataIn => DataIn,
			Q => Q
		);

	-- The following is the stimulus
	STIM0: Clk <= not Clk after DELAY;
	STIM1: DataIn <=  x"00000000000000ef" after 10ns,
	x"000000000000000f" after 20ns,
	x"000000000000001f" after 40ns,
	x"fffffffffdbacfff" after 50ns,
	x"fffddbafffffffff" after 60ns,
	x"ff479ffffcbdafff" after 70ns,
	x"ff56fffaabcfffff" after 80ns,
	x"fffdbacfffffffff" after 90ns;	   
	
	STIM2: Reset <= '1' after 18ns,
	'0' after 23ns;
	
	STIM3: Load <= '1' after 3ns,
	'0' after 32ns, 
	'1' after 80ns,
	'0' after 95ns;
	
	
	STIM4: ShL <= '1' after 44ns,
	'0' after 70ns;
	
	STIM5: ShR <= '1' after 57ns,
	'0' after 78ns;
	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_register_64bit of register_64bit_tb is
	for TB_ARCHITECTURE
		for UUT : register_64bit
			use entity work.register_64bit(rtl);
		end for;
	end for;
end TESTBENCH_FOR_register_64bit;

