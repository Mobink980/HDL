-------------------------------------------------------------------------------
--
-- Title       : NINE_BIT_DECREMENTER
-- Design      : RNS_FORWARD
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : NINE_BIT_DECREMENTER.vhd
-- Generated   : Tue Jun 29 13:57:32 2021
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
--{entity {NINE_BIT_DECREMENTER} architecture {NINE_BIT_DECREMENTER}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity NINE_BIT_DECREMENTER is
	port ( --port declaration 
		signal x:     in  std_logic_vector(8 downto 0);	-- 9-bit input 
		signal carry: in std_logic;
		signal y:     out std_logic_vector(8 downto 0)	-- 9-bit output
		);
end NINE_BIT_DECREMENTER;

--}} End of automatically maintained section

architecture RTL of NINE_BIT_DECREMENTER is	
--middle signals
signal t0, t1, t2, t3, t4, t5, t6, t7, t8: std_logic;
signal c_bar: std_logic;
begin 	
	c_bar <= not carry;
	-- instantiating the normal CSA
	FA0: entity work.FA(RTL)
		port map (opa => x(0), opb => '1', cin => c_bar, sum => y(0), cout => t0);	
		
	-- instantiating the normal CSA
	FA1: entity work.FA(RTL)
		port map (opa => x(1), opb => '1', cin => t0, sum => y(1), cout => t1);
		
	-- instantiating the normal CSA
	FA2: entity work.FA(RTL)
		port map (opa => x(2), opb => '1', cin => t1, sum => y(2), cout => t2);
		
	-- instantiating the normal CSA
	FA3: entity work.FA(RTL)
		port map (opa => x(3), opb => '1', cin => t2, sum => y(3), cout => t3);
		
	-- instantiating the normal CSA
	FA4: entity work.FA(RTL)
		port map (opa => x(4), opb => '1', cin => t3, sum => y(4), cout => t4);
		
	-- instantiating the normal CSA
	FA5: entity work.FA(RTL)
		port map (opa => x(5), opb => '1', cin => t4, sum => y(5), cout => t5);
		
	-- instantiating the normal CSA
	FA6: entity work.FA(RTL)
		port map (opa => x(6), opb => '1', cin => t5, sum => y(6), cout => t6);
		
	-- instantiating the normal CSA
	FA7: entity work.FA(RTL)
		port map (opa => x(7), opb => '1', cin => t6, sum => y(7), cout => t7);
		
	-- instantiating the normal CSA
	FA8: entity work.FA(RTL)
		port map (opa => x(8), opb => '1', cin => t7, sum => y(8), cout => t8);
		

	

end architecture RTL;
