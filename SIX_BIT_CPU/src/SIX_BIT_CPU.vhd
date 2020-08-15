-------------------------------------------------------------------------------
--
-- Title       : SIX_BIT_CPU
-- Design      : CPU
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : SIX_BIT_CPU.vhd
-- Generated   : Fri Jul 10 17:17:33 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {SIX_BIT_CPU} architecture {SIX_BIT_CPU}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity SIX_BIT_CPU is  
	
generic (
	AddrWidth: integer := 6; --width of address
	DataWidth: integer := 6	 -- width of a memory cell
	); 	
	
port (
	clk: in std_logic; 
	
	R0: out std_logic_vector (DataWidth-1 downto 0); --register output 
	R1: out std_logic_vector (DataWidth-1 downto 0); --register output
	R2: out std_logic_vector (DataWidth-1 downto 0); --register output
	R3: out std_logic_vector (DataWidth-1 downto 0); --register output
	PC: out std_logic_vector (DataWidth-1 downto 0); --register output
	IR: out std_logic_vector (DataWidth-1 downto 0)  --register output
	); 
end SIX_BIT_CPU;

--}} End of automatically maintained section

architecture RTL of SIX_BIT_CPU is
-- Defining middle signals
signal ROUTPC: std_logic_vector(DataWidth-1 downto 0); 
signal MData:  std_logic_vector(DataWidth-1 downto 0); 
signal CPU_BUS:  std_logic_vector(DataWidth-1 downto 0);
signal ROUT0:  std_logic_vector(DataWidth-1 downto 0);
signal ROUT1:  std_logic_vector(DataWidth-1 downto 0);
signal ROUT2:  std_logic_vector(DataWidth-1 downto 0);
signal ROUT3:  std_logic_vector(DataWidth-1 downto 0);
signal ROUTIR:  std_logic_vector(DataWidth-1 downto 0);
signal ALURes:  std_logic_vector(DataWidth-1 downto 0);
signal ALUIN1:  std_logic_vector(DataWidth-1 downto 0);
signal ALUIN2:  std_logic_vector(DataWidth-1 downto 0);

signal LD0: std_logic;
signal ZR0: std_logic;
signal LD1: std_logic;
signal ZR1: std_logic;
signal LD2: std_logic;
signal ZR2: std_logic;
signal LD3: std_logic;
signal ZR3: std_logic;	
signal LDPC: std_logic;
signal INC: std_logic;	
signal RST: std_logic;
signal LDIR: std_logic;
signal S00: std_logic;
signal S01: std_logic;
signal S10: std_logic;
signal S11: std_logic; 
signal CMD: std_logic;
signal BUS_Sel: std_logic;

begin
	
	-- instantiating the memory
	Memory0: entity work.MEMORY(RTL)
		port map (Address => ROUTPC, Data => MData);
		
	-- instantiating data register
	REGISTER0: entity work.REG(RTL)
		port map (clk => clk, LD => LD0, RIN => CPU_BUS, ZR => ZR0, ROUT => ROUT0);
		
	-- instantiating data register
	REGISTER1: entity work.REG(RTL)
		port map (clk => clk, LD => LD1, RIN => CPU_BUS, ZR => ZR1, ROUT => ROUT1);
		
		-- instantiating data register
	REGISTER2: entity work.REG(RTL)
		port map (clk => clk, LD => LD2, RIN => CPU_BUS, ZR => ZR2, ROUT => ROUT2);
		
		-- instantiating data register
	REGISTER3: entity work.REG(RTL)
		port map (clk => clk, LD => LD3, RIN => CPU_BUS, ZR => ZR3, ROUT => ROUT3);
		
	-- instantiating program counter	
	PCREGISTER: entity work.PC(RTL)
		port map (clk => clk, LD => LDPC, INC => INC, CLR => RST, RIN => CPU_BUS, ROUT => ROUTPC);
		
		
	-- instantiating instruction register
	IRREGISTER: entity work.IR(RTL)
		port map (clk => clk, LD => LDIR, RIN => CPU_BUS, ROUT => ROUTIR);
		
	-- instantiating 2x1 MUX
	MUX2TO1: entity work.TWO_TO_ONE_MUX(RTL)
		port map (I0 => MData, I1 => ALURes, S => BUS_Sel, Y => CPU_BUS);  
		
		
	-- instantiating 4x1 MUX (For the first input to the ALU)
	MUX4TO1ALUFIRST: entity work.FOUR_TO_ONE_MUX(RTL)
		port map (I0 => ROUT0, I1 => ROUT1, I2 => ROUT2, I3 => ROUT3, S0 => S00, S1 => S01, Y => ALUIN1);	
		
		
	-- instantiating 4x1 MUX (For the second input to the ALU)
	MUX4TO1ALUSECOND: entity work.FOUR_TO_ONE_MUX(RTL)
		port map (I0 => ROUT0, I1 => ROUT1, I2 => ROUT2, I3 => ROUT3, S0 => S10, S1 => S11, Y => ALUIN2);
		
		
	-- instantiating ALU (Arithmetic Logic Unit)
	ALU: entity work.ALU(RTL)
		port map (IN1 => ALUIN1, IN2 => ALUIN2, CMD => CMD, ALURes => ALURes);
		
	
		
	-- instantiating Control Unit
	CONTROLUNIT: entity work.CONTROL_UNIT(RTL)
		port map (clk => clk, ZR0 => ZR0, ZR1 => ZR1, ZR2 => ZR2, ZR3 => ZR3, ROUTIR => ROUTIR, 
		LD0 => LD0, LD1 => LD1, LD2 => LD2, LD3 => LD3, LDPC => LDPC, LDIR => LDIR, S00 => S00, 
		S01 => S01, S10 => S10, S11 => S11, Bus_Sel => BUS_Sel, CMD => CMD, INC => INC, RST => RST);
		
		
	-- Putting the values of the registers in port for simulation	
	R0 <= ROUT0; 
	R1 <= ROUT1;
	R2 <= ROUT2;
	R3 <= ROUT3;
	PC <= ROUTPC;
	IR <= ROUTIR;
		
end architecture RTL;
