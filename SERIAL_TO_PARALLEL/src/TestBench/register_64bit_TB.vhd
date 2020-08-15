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
		D : in STD_LOGIC;
		Q : out STD_LOGIC_VECTOR(63 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal Clk : STD_LOGIC := '0';
	signal Reset : STD_LOGIC := '0';
	signal Load : STD_LOGIC := '0';
	signal ShL : STD_LOGIC := '0';
	signal ShR : STD_LOGIC := '0';
	signal D : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Q : STD_LOGIC_VECTOR(63 downto 0);

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
			D => D,
			Q => Q
		);

	-- The following is the stimulus
	STIM0: Clk <= not Clk after DELAY;
	
	-- STIMULATING INPUT D
	process 
	begin 
		D <= '0'; 	
		wait until rising_edge(clk); 
		D <= '1';  		 
		wait until rising_edge(clk);  
		D <= '0'; 
		wait until rising_edge(clk);  
		D <= '1';	
		wait until rising_edge(clk);  
		D <= '1';
		wait until rising_edge(clk);  
		
	end process;   
	
	-- STIMULATING INPUT LOAD
	STIM1: Load <= '1' after 7ns,
	'0' after 68ns;
	
	-- STIMULATING INPUT RESET
	STIM2: Reset <= '1' after 5ns,
	'0' after 17ns;
	
	-- STIMULATING CONTROL INPUT FOR RIGHT SHIFT
	STIM5: ShR <= '1' after 70ns,
	'0' after 100ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_register_64bit of register_64bit_tb is
	for TB_ARCHITECTURE
		for UUT : register_64bit
			use entity work.register_64bit(rtl);
		end for;
	end for;
end TESTBENCH_FOR_register_64bit;

