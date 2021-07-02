library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity compressor8_2_approximate_tb is
end compressor8_2_approximate_tb;

architecture TB_ARCHITECTURE of compressor8_2_approximate_tb is
-- CREATING A CONSTANT NAMED DELAY
constant DELAY: delay_length := 10ns;
	-- Component declaration of the tested unit
	component compressor8_2_approximate
	port(
		a : in STD_LOGIC;
		b : in STD_LOGIC;
		c : in STD_LOGIC;
		d : in STD_LOGIC;
		e : in STD_LOGIC;
		f : in STD_LOGIC;
		g : in STD_LOGIC;
		h : in STD_LOGIC;
		cin0 : in STD_LOGIC;
		cin1 : in STD_LOGIC;
		cin2 : in STD_LOGIC;
		cin3 : in STD_LOGIC;
		cin4 : in STD_LOGIC;
		cout0 : out STD_LOGIC;
		cout1 : out STD_LOGIC;
		cout2 : out STD_LOGIC;
		cout3 : out STD_LOGIC;
		cout4 : out STD_LOGIC;
		sum : out STD_LOGIC;
		carry : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal a : STD_LOGIC := '0';
	signal b : STD_LOGIC := '0';
	signal c : STD_LOGIC := '0';
	signal d : STD_LOGIC := '0';
	signal e : STD_LOGIC := '0';
	signal f : STD_LOGIC := '0';
	signal g : STD_LOGIC := '0';
	signal h : STD_LOGIC := '0';
	signal cin0 : STD_LOGIC := '0';
	signal cin1 : STD_LOGIC := '0';
	signal cin2 : STD_LOGIC := '0';
	signal cin3 : STD_LOGIC := '0';
	signal cin4 : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal cout0 : STD_LOGIC;
	signal cout1 : STD_LOGIC;
	signal cout2 : STD_LOGIC;
	signal cout3 : STD_LOGIC;
	signal cout4 : STD_LOGIC;
	signal sum : STD_LOGIC;
	signal carry : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : compressor8_2_approximate
		port map (
			a => a,
			b => b,
			c => c,
			d => d,
			e => e,
			f => f,
			g => g,
			h => h,
			cin0 => cin0,
			cin1 => cin1,
			cin2 => cin2,
			cin3 => cin3,
			cin4 => cin4,
			cout0 => cout0,
			cout1 => cout1,
			cout2 => cout2,
			cout3 => cout3,
			cout4 => cout4,
			sum => sum,
			carry => carry
		);

	--STIMULATION OF INPUT SIGNALS
	STIM0: a <= not a after DELAY;  
	STIM1: b <= not b after 2*DELAY;
	STIM2: c <= not c after 4*DELAY;
	STIM3: d <= not d after 8*DELAY;
	STIM4: e <= not e after 16*DELAY;	
	STIM5: f <= not f after 32*DELAY;	
	STIM6: g <= not g after 40*DELAY;
	STIM7: h <= not h after 50*DELAY;
	STIM8: cin0 <= not cin0 after 60*DELAY;	
	STIM9: cin1 <= not cin1 after 70*DELAY;	
	STIMA: cin2 <= not cin2 after 80*DELAY;	
	STIMB: cin3 <= not cin3 after 90*DELAY;
	STIMC: cin4 <= not cin4 after 100*DELAY;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_compressor8_2_approximate of compressor8_2_approximate_tb is
	for TB_ARCHITECTURE
		for UUT : compressor8_2_approximate
			use entity work.compressor8_2_approximate(rtl);
		end for;
	end for;
end TESTBENCH_FOR_compressor8_2_approximate;

