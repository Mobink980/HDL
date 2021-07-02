-------------------------------------------------------------------------------
--
-- Title       : O_OPERATOR
-- Design      : ADDERS
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : O_OPERATOR.vhd
-- Generated   : Fri May 21 13:53:08 2021
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
--{entity {O_OPERATOR} architecture {O_OPERATOR}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity O_OPERATOR is 
	port ( --port declaration 
		signal P, G, P_hat, G_hat: in std_logic; -- Four inputs of the operation
		signal P_out, G_out: out std_logic       -- Two outpus of the operation
		
		); 
end O_OPERATOR;

--}} End of automatically maintained section

architecture RTL of O_OPERATOR is
begin	
	
	P_out <= P and P_hat;
	G_out <= (P and G_hat) or G;

end architecture RTL;
