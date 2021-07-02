-------------------------------------------------------------------------------
--
-- Title       : FA
-- Design      : RNS_FORWARD
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : FA.vhd
-- Generated   : Tue Jun 29 12:58:25 2021
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
--{entity {FA} architecture {FA}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FA is   
	port ( --port declaration
		signal opa, opb, cin: in std_logic;	--input signal ports
		signal sum, cout: out std_logic ); --output signal ports	
end FA;

--}} End of automatically maintained section   

--First architecture of fadd1 (1 bit Full Adder)
architecture RTL of FA is
begin
	P1: sum <= opa xor opb xor cin;
	P2: cout <= (opa and opb) or (opa and cin) or (opb and cin);
end architecture RTL;
