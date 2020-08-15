library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity instruction_tb is
end instruction_tb;

architecture TB_ARCHITECTURE of instruction_tb is
	-- Component declaration of the tested unit
	component instruction
	port(
		qin : in STD_LOGIC;
		Y1 : out STD_LOGIC;
		Y2 : out STD_LOGIC;
		Y3 : out STD_LOGIC;
		Y4 : out STD_LOGIC;
		Y5 : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal qin : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Y1 : STD_LOGIC := '0';
	signal Y2 : STD_LOGIC := '0';
	signal Y3 : STD_LOGIC := '0';
	signal Y4 : STD_LOGIC := '0';
	signal Y5 : STD_LOGIC := '0';

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : instruction
		port map (
			qin => qin,
			Y1 => Y1,
			Y2 => Y2,
			Y3 => Y3,
			Y4 => Y4,
			Y5 => Y5
		);

	-- Add your stimulus here ... 
	qin <= '0', 
	'1' after 10 ns,
	'0' after 13 ns,
	'1' after 15 ns,
	'0' after 15.8 ns,
	'1' after 18 ns,
	'0' after 18.4 ns, 
	'1' after 21 ns,
	'0' after 23 ns, 
	'1' after 23.6ns; 

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_instruction of instruction_tb is
	for TB_ARCHITECTURE
		for UUT : instruction
			use entity work.instruction(rtl);
		end for;
	end for;
end TESTBENCH_FOR_instruction;

