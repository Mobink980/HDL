-------------------------------------------------------------------------------
--
-- Title       : CIRCUIT
-- Design      : RANDOM_CIRCUIT
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : CIRCUIT.vhd
-- Generated   : Thu May 14 17:17:37 2020
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
--{entity {CIRCUIT} architecture {CIRCUIT}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CIRCUIT is 
	port(
	signal Clk: in std_logic;
	signal  Reset: in std_logic;
	signal lfsr_data: out std_logic_vector (7 downto 0)
	);
end CIRCUIT;

--}} End of automatically maintained section

architecture RTL of CIRCUIT is
signal count: std_logic_vector (7 downto 0);
signal linear_feedback :std_logic;
  
  begin
      linear_feedback <= count(7) XNOR count(5) XNOR count(4) XNOR count(3);
  
  
      process (clk, reset) begin
          if (reset = '1') then
              count <= (others=>'0');
          elsif (rising_edge(clk)) then            
                count <= (count(6) & count(5) & count(4) & count(3) 
                         & count(2) & count(1) & count(0) & 
                         linear_feedback);           
          end if;
      end process;
	  
      lfsr_data <= count;

end architecture RTL;
