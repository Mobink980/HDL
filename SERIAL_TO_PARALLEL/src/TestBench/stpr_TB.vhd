library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity stpr_tb is
end stpr_tb;

architecture TB_ARCHITECTURE of stpr_tb is
--defining constant DELAY1
constant DELAY1: delay_length := 5ns;
--defining constant DELAY2
constant DELAY2: delay_length := 2.5ns;
	-- Component declaration of the tested unit
	component stpr
	port(
		X : in STD_LOGIC;
		start : in STD_LOGIC;
		clk : in STD_LOGIC;
		sr_clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		state : out STD_ULOGIC_VECTOR(1 downto 0);
		counter : out INTEGER;
		Y : out STD_LOGIC_VECTOR(63 downto 0);
		finish : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal X : STD_LOGIC := '0';
	signal start : STD_LOGIC := '0';
	signal clk : STD_LOGIC := '0';
	signal sr_clk : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal state : STD_ULOGIC_VECTOR(1 downto 0);
	signal counter : INTEGER;
	signal Y : STD_LOGIC_VECTOR(63 downto 0);
	signal finish : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : stpr
		port map (
			X => X,
			start => start,
			clk => clk,
			sr_clk => sr_clk,
			reset => reset,
			state => state,
			counter => counter,
			Y => Y,
			finish => finish
		);

	-- STIMULATION FOR CLOCK of the circuit	 
	STIM0: clk <= not clk after DELAY1; 
	
	-- STIMULATION FOR CLOCK of the shift register	 
	STIM1: sr_clk <= not sr_clk after DELAY2;
	
	-- STIMULATION FOR START	 
	STIM2: start <= '1' after 11ns,
	'0' after 17ns,
	'1' after 1300ns,
	'0' after 1320ns;
	
	-- STIMULATION FOR RESET	 
	STIM3: reset <= '1' after 1ns,
	'0' after 5ns;
	
	-- STIMULATION OF THE INPUT OF THE FSM
	process 
	begin 
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

configuration TESTBENCH_FOR_stpr of stpr_tb is
	for TB_ARCHITECTURE
		for UUT : stpr
			use entity work.stpr(rtl);
		end for;
	end for;
end TESTBENCH_FOR_stpr;

