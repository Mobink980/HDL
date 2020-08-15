library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity string_detector_tb is
end string_detector_tb;

architecture TB_ARCHITECTURE of string_detector_tb is
--defining constant DELAY
constant DELAY: delay_length := 5ns;
	-- Component declaration of the tested unit
	component string_detector
	port(
		X : in STD_LOGIC;
		reset : in STD_LOGIC;
		clk : in STD_LOGIC;
		state : out STD_ULOGIC_VECTOR(2 downto 0);
		Y : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal X : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '0';
	signal clk : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal state : STD_ULOGIC_VECTOR(2 downto 0) := "000";
	signal Y : STD_LOGIC := '0';

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : string_detector
		port map (
			X => X,
			reset => reset,
			clk => clk,
			state => state,
			Y => Y
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
		X <= '0'; 
		wait until reset = '0'; 
		
		wait until rising_edge(clk); 
		X <= '0';  		 
		wait until rising_edge(clk);  
		X <= '1'; 
		wait until rising_edge(clk);  
		X <= '1';	
		wait until rising_edge(clk);  
		X <= '0';
		wait until rising_edge(clk);  
		X <= '1';
		wait until rising_edge(clk);  
		X <= '0';
		wait until rising_edge(clk);  
		X <= '1';
		wait until rising_edge(clk);  
		X <= '0';
		wait until rising_edge(clk);  
		X <= '0';
		wait until rising_edge(clk);  
		X <= '1';
		wait until rising_edge(clk);  
		X <= '1';
		wait until rising_edge(clk);  
		X <= '0';
		wait until rising_edge(clk);  
		X <= '0'; 
		
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_string_detector of string_detector_tb is
	for TB_ARCHITECTURE
		for UUT : string_detector
			use entity work.string_detector(rtl);
		end for;
	end for;
end TESTBENCH_FOR_string_detector;

