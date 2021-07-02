-------------------------------------------------------------------------------
--
-- Title       : KS_ADDER
-- Design      : ADDERS
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : KS_ADDER.vhd
-- Generated   : Fri May 21 13:07:51 2021
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
--{entity {KS_ADDER} architecture {KS_ADDER}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity KS_ADDER is
	port ( --port declaration 
		signal x: in std_logic_vector(7 downto 0);	-- 8-bit input
		signal y: in std_logic_vector(7 downto 0);	-- 8-bit input	
		signal s: out std_logic_vector(7 downto 0);	-- 8-bit sum 
		signal cout: out std_logic_vector(7 downto 0) -- group carries
		
		); 
end KS_ADDER;

--}} End of automatically maintained section

architecture RTL of KS_ADDER is	
signal c: std_logic_vector(8 downto 0);	-- 8-bit carry plus cout=c8   	 
-- middle signals for storing the results of O_operations
signal t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10: std_logic; 
signal t11, t12, t13, t14, t15, t16, t17, t18, t19, t20, t21: std_logic; 
signal t22, t23, t24, t25, t26, t27, t28, t29, t30: std_logic;	
signal G0, G1, G2, G3, G4, G5, G6, G7: std_logic; -- Gi = Ai and Bi
signal P0, P1, P2, P3, P4, P5, P6, P7: std_logic; -- Pi = Ai or Pi
begin	  
	--carry-in to the adder is '0'
	c(0) <= '0';
	
	-- Generated Carries
	G0 <= x(0) and y(0);  
	G1 <= x(1) and y(1);
	G2 <= x(2) and y(2);
	G3 <= x(3) and y(3); 
	G4 <= x(4) and y(4);
	G5 <= x(5) and y(5);
	G6 <= x(6) and y(6);
	G7 <= x(7) and y(7);
	
	-- Propagated Carries
	P0 <= x(0) or y(0);	 
	P1 <= x(1) or y(1);
	P2 <= x(2) or y(2);
	P3 <= x(3) or y(3);	
	P4 <= x(4) or y(4);
	P5 <= x(5) or y(5);
	P6 <= x(6) or y(6);
	P7 <= x(7) or y(7);
	
	-- Calculating Carries (c(1)= G0 & we have 17 O_operations)
	c(1) <= G0;
	
	-- instantiating the O_operator unit
	O_op0: entity work.O_OPERATOR(RTL)
		port map (P => P1, G => G1, P_hat => P0, G_hat => G0, P_out => t0, G_out => c(2));	
		
	-- instantiating the O_operator unit
	O_op1: entity work.O_OPERATOR(RTL)
		port map (P => P2, G => G2, P_hat => P1, G_hat => G1, P_out => t1, G_out => t2);
		
	-- instantiating the O_operator unit
	O_op2: entity work.O_OPERATOR(RTL)
		port map (P => P3, G => G3, P_hat => P2, G_hat => G2, P_out => t3, G_out => t4);
		
	-- instantiating the O_operator unit
	O_op3: entity work.O_OPERATOR(RTL)
		port map (P => P4, G => G4, P_hat => P3, G_hat => G3, P_out => t5, G_out => t6);
		
	-- instantiating the O_operator unit
	O_op4: entity work.O_OPERATOR(RTL)
		port map (P => P5, G => G5, P_hat => P4, G_hat => G4, P_out => t7, G_out => t8);
		
	-- instantiating the O_operator unit
	O_op5: entity work.O_OPERATOR(RTL)
		port map (P => P6, G => G6, P_hat => P5, G_hat => G5, P_out => t9, G_out => t10);
		
	-- instantiating the O_operator unit
	O_op6: entity work.O_OPERATOR(RTL)
		port map (P => P7, G => G7, P_hat => P6, G_hat => G6, P_out => t11, G_out => t12);
		
	-- instantiating the O_operator unit
	O_op7: entity work.O_OPERATOR(RTL)
		port map (P => t1, G => t2, P_hat => P0, G_hat => G0, P_out => t13, G_out => c(3));
		
	-- instantiating the O_operator unit
	O_op8: entity work.O_OPERATOR(RTL)
		port map (P => t3, G => t4, P_hat => t0, G_hat => c(2), P_out => t14, G_out => c(4));
		
	-- instantiating the O_operator unit
	O_op9: entity work.O_OPERATOR(RTL)
		port map (P => t5, G => t6, P_hat => t1, G_hat => t2, P_out => t15, G_out => t16);
		
	-- instantiating the O_operator unit
	O_op10: entity work.O_OPERATOR(RTL)
		port map (P => t7, G => t8, P_hat => t3, G_hat => t4, P_out => t17, G_out => t18);
		
	-- instantiating the O_operator unit
	O_op11: entity work.O_OPERATOR(RTL)
		port map (P => t9, G => t10, P_hat => t5, G_hat => t6, P_out => t19, G_out => t20);
		
	-- instantiating the O_operator unit
	O_op12: entity work.O_OPERATOR(RTL)
		port map (P => t11, G => t12, P_hat => t7, G_hat => t8, P_out => t21, G_out => t22);
		
	-- instantiating the O_operator unit
	O_op13: entity work.O_OPERATOR(RTL)
		port map (P => t15, G => t16, P_hat => P0, G_hat => G0, P_out => t23, G_out => c(5));
		
	-- instantiating the O_operator unit
	O_op14: entity work.O_OPERATOR(RTL)
		port map (P => t17, G => t18, P_hat => t0, G_hat => c(2), P_out => t24, G_out => c(6));
		
	-- instantiating the O_operator unit
	O_op15: entity work.O_OPERATOR(RTL)
		port map (P => t19, G => t20, P_hat => t13, G_hat => c(3), P_out => t25, G_out => c(7));
		
	-- instantiating the O_operator unit
	O_op16: entity work.O_OPERATOR(RTL)
		port map (P => t21, G => t22, P_hat => t14, G_hat => c(4), P_out => t26, G_out => c(8));
	
	-- Calculating the Final SUM
	process (x, y, c)
	begin	  
		-- Initializing the sum vector with zeros
		s <= (others => '0'); 
		for I in 0 to s'length-1 loop	
			s(I) <= x(I) xor y(I) xor c(I);	
		end loop;
	end process;	
	
	
	-- Showing output carries in the simulation
	cout(7 downto 0) <= c(8 downto 1);

	 

end architecture RTL;
