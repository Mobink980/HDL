library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity machine_tb is
end machine_tb;

architecture TB_ARCHITECTURE of machine_tb is
--defining constant DELAY
constant DELAY: delay_length := 5ns;
	-- Component declaration of the tested unit
	component machine
	port(
		IR : in STD_LOGIC_VECTOR(1 downto 0);
		Reset : in STD_LOGIC;
		Clk : in STD_LOGIC;
		state : out STD_ULOGIC_VECTOR(3 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal IR : STD_LOGIC_VECTOR(1 downto 0) := "00";
	signal Reset : STD_LOGIC := '0';
	signal Clk : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal state : STD_ULOGIC_VECTOR(3 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : machine
		port map (
			IR => IR,
			Reset => Reset,
			Clk => Clk,
			state => state
		);

	-- STIMULATION FOR CLOCK	 
	STIM0: clk <= not clk after DELAY;
	
	-- STIMULATION FOR RESET	 
	STIM1: reset <= '1',
	'0' after 8ns,
	'1' after 150ns,
	'0' after 155ns;
	
	-- STIMULATION OF THE INPUT OF THE FSM
	process 
	begin 
		IR <= "00"; 		
		wait until rising_edge(clk); 
		IR <= "01";  		 
		wait until rising_edge(clk);  
		IR <= "10"; 
		wait until rising_edge(clk);  
		IR <= "11";	
		wait until rising_edge(clk);  
		
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_machine of machine_tb is
	for TB_ARCHITECTURE
		for UUT : machine
			use entity work.machine(rtl);
		end for;
	end for;
end TESTBENCH_FOR_machine;

