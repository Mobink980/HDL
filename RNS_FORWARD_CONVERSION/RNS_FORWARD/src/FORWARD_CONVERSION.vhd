-------------------------------------------------------------------------------
--
-- Title       : FORWARD_CONVERSION
-- Design      : RNS_FORWARD
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : FORWARD_CONVERSION.vhd
-- Generated   : Tue Jun 29 12:57:34 2021
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
--{entity {FORWARD_CONVERSION} architecture {FORWARD_CONVERSION}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FORWARD_CONVERSION is
	generic (
	N: integer := 8
	); 	   
	
	port ( --port declaration 
		signal x: 			 		in  std_logic_vector((3*N)-1 downto 0);	-- 3N-bit input
		signal power_two_minus_one: out std_logic_vector(N+1 downto 0);	-- 10-bit output
		signal power_two: 			out std_logic_vector(N+1 downto 0);	-- 10-bit output
		signal power_two_plus_one:  out std_logic_vector(N+1 downto 0)	-- 10-bit output 	
		);
end FORWARD_CONVERSION;

--}} End of automatically maintained section

architecture RTL of FORWARD_CONVERSION is
--Middle signals for saving the results of the CSAs
signal s: std_logic_vector(7 downto 0);	
signal c: std_logic_vector(7 downto 0);	 
signal s1: std_logic_vector(7 downto 0);
signal s1_bar: std_logic_vector(7 downto 0);
signal c1: std_logic_vector(7 downto 0);
signal sum1: std_logic_vector(7 downto 0);
signal sum2: std_logic_vector(8 downto 0);
signal t0, t1, t2, t3, t4, t5, t6, t7, t8, t9: std_logic;
signal t10, t11, t12, t13, t14, t15, t16, t17, t18, t19: std_logic;
begin

	--===============================================================================
	--              FORWARD CONVERSION FOR 2^(n) - 1
	--===============================================================================
	-- instantiating the normal CSA
	CSA0: entity work.FA(RTL)
		port map (opa => x(0), opb => x(8), cin => x(16), sum => s(0), cout => c(0));
		
	-- instantiating the normal CSA
	CSA1: entity work.FA(RTL)
		port map (opa => x(1), opb => x(9), cin => x(17), sum => s(1), cout => c(1));
		
	-- instantiating the normal CSA
	CSA2: entity work.FA(RTL)
		port map (opa => x(2), opb => x(10), cin => x(18), sum => s(2), cout => c(2));
		
	-- instantiating the normal CSA
	CSA3: entity work.FA(RTL)
		port map (opa => x(3), opb => x(11), cin => x(19), sum => s(3), cout => c(3));
		
	-- instantiating the normal CSA
	CSA4: entity work.FA(RTL)
		port map (opa => x(4), opb => x(12), cin => x(20), sum => s(4), cout => c(4));
		
	-- instantiating the normal CSA
	CSA5: entity work.FA(RTL)
		port map (opa => x(5), opb => x(13), cin => x(21), sum => s(5), cout => c(5));
		
	-- instantiating the normal CSA
	CSA6: entity work.FA(RTL)
		port map (opa => x(6), opb => x(14), cin => x(22), sum => s(6), cout => c(6));
		
	-- instantiating the normal CSA
	CSA7: entity work.FA(RTL)
		port map (opa => x(7), opb => x(15), cin => x(23), sum => s(7), cout => c(7));
		
	--####################### CARRY PROPAGATE ADDER (CPA) #########################	 
	-- instantiating the normal CSA
	FA0: entity work.FA(RTL)
		port map (opa => s(0), opb => c(7), cin => '0', sum => sum1(0), cout => t0);
		
	-- instantiating the normal CSA
	FA1: entity work.FA(RTL)
		port map (opa => s(1), opb => c(0), cin => t0, sum => sum1(1), cout => t1);
		
	-- instantiating the normal CSA
	FA2: entity work.FA(RTL)
		port map (opa => s(2), opb => c(1), cin => t1, sum => sum1(2), cout => t2);
		
	-- instantiating the normal CSA
	FA3: entity work.FA(RTL)
		port map (opa => s(3), opb => c(2), cin => t2, sum => sum1(3), cout => t3);
		
	-- instantiating the normal CSA
	FA4: entity work.FA(RTL)
		port map (opa => s(4), opb => c(3), cin => t3, sum => sum1(4), cout => t4);
		
	-- instantiating the normal CSA
	FA5: entity work.FA(RTL)
		port map (opa => s(5), opb => c(4), cin => t4, sum => sum1(5), cout => t5);
		
	-- instantiating the normal CSA
	FA6: entity work.FA(RTL)
		port map (opa => s(6), opb => c(5), cin => t5, sum => sum1(6), cout => t6);
		
	-- instantiating the normal CSA
	FA7: entity work.FA(RTL)
		port map (opa => s(7), opb => c(6), cin => t6, sum => sum1(7), cout => t7); 
		
		
	-- instantiating the incrementer circuit
	inc0: entity work.EIGHT_BIT_INCREMENTER(RTL)
		port map (x => sum1, cin => t7, y => power_two_minus_one(7 downto 0)); 
		
	power_two_minus_one(9 downto 8) <= "00";
		
	
	
		

	
	
	
	--===============================================================================
	--              FORWARD CONVERSION FOR 2^(n)
	--===============================================================================
	power_two(7 downto 0) <= x(7 downto 0); 
	power_two(9 downto 8) <= "00";
	
	
	
	--===============================================================================
	--              FORWARD CONVERSION FOR 2^(n) + 1
	--===============================================================================  
	-- instantiating the special-purpose CSA
	SP_CSA0: entity work.SP_CSA(RTL)
		port map (opa => x(0), opb => x(8), cin => x(16), sum => s1(0), cout => c1(0));	
		
	-- instantiating the special-purpose CSA
	SP_CSA1: entity work.FA(RTL)
		port map (opa => x(1), opb => x(9), cin => x(17), sum => s1(1), cout => c1(1));
		
	-- instantiating the special-purpose CSA
	SP_CSA2: entity work.FA(RTL)
		port map (opa => x(2), opb => x(10), cin => x(18), sum => s1(2), cout => c1(2));
		
	-- instantiating the special-purpose CSA
	SP_CSA3: entity work.FA(RTL)
		port map (opa => x(3), opb => x(11), cin => x(19), sum => s1(3), cout => c1(3));
		
	-- instantiating the special-purpose CSA
	SP_CSA4: entity work.FA(RTL)
		port map (opa => x(4), opb => x(12), cin => x(20), sum => s1(4), cout => c1(4));
		
	-- instantiating the special-purpose CSA
	SP_CSA5: entity work.FA(RTL)
		port map (opa => x(5), opb => x(13), cin => x(21), sum => s1(5), cout => c1(5));
		
	-- instantiating the special-purpose CSA
	SP_CSA6: entity work.FA(RTL)
		port map (opa => x(6), opb => x(14), cin => x(22), sum => s1(6), cout => c1(6));
		
	-- instantiating the special-purpose CSA
	SP_CSA7: entity work.FA(RTL)
		port map (opa => x(7), opb => x(15), cin => x(23), sum => s1(7), cout => c1(7)); 
	
	-- inverting the array s1
	s1_bar <= not s1;	
	
	--####################### CARRY PROPAGATE ADDER (CPA) #########################	 
	-- instantiating the normal CSA
	FA8: entity work.FA(RTL)
		port map (opa => s1_bar(0), opb => '0', cin => '1', sum => sum2(0), cout => t8);
		
	-- instantiating the normal CSA
	FA9: entity work.FA(RTL)
		port map (opa => s1_bar(1), opb => c1(0), cin => t8, sum => sum2(1), cout => t9);
		
	-- instantiating the normal CSA
	FA10: entity work.FA(RTL)
		port map (opa => s1_bar(2), opb => c1(1), cin => t9, sum => sum2(2), cout => t10);
		
	-- instantiating the normal CSA
	FA11: entity work.FA(RTL)
		port map (opa => s1_bar(3), opb => c1(2), cin => t10, sum => sum2(3), cout => t11);
		
	-- instantiating the normal CSA
	FA12: entity work.FA(RTL)
		port map (opa => s1_bar(4), opb => c1(3), cin => t11, sum => sum2(4), cout => t12);
		
	-- instantiating the normal CSA
	FA13: entity work.FA(RTL)
		port map (opa => s1_bar(5), opb => c1(4), cin => t12, sum => sum2(5), cout => t13);
		
	-- instantiating the normal CSA
	FA14: entity work.FA(RTL)
		port map (opa => s1_bar(6), opb => c1(5), cin => t13, sum => sum2(6), cout => t14);
		
	-- instantiating the normal CSA
	FA15: entity work.FA(RTL)
		port map (opa => s1_bar(7), opb => c1(6), cin => t14, sum => sum2(7), cout => t15);		
		
	-- instantiating the normal CSA
	FA16: entity work.FA(RTL)
		port map (opa => s1_bar(7), opb => c1(7), cin => t15, sum => sum2(8), cout => t16);
	
	
	-- instantiating the incrementer circuit
	dec0: entity work.NINE_BIT_DECREMENTER(RTL)
		port map (x => sum2, carry => c1(7), y => power_two_plus_one(8 downto 0)); 
		
	power_two_plus_one(9) <= '0';
	
	
	

end architecture RTL;
