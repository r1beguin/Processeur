----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:25:43 05/28/2018 
-- Design Name: 
-- Module Name:    decodeur - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decodeur is
    Port ( instruction  : in  STD_LOGIC_VECTOR(31 downto 0);
           a 				: out  STD_LOGIC_VECTOR(7 downto 0);
           b 				: out  STD_LOGIC_VECTOR(7 downto 0);
           c 				: out  STD_LOGIC_VECTOR(7 downto 0);
           op 				: out  STD_LOGIC_VECTOR(7 downto 0);
			  clk 			: in STD_LOGIC);
end decodeur;

architecture Behavioral of decodeur is

begin
	process
		begin
			wait until rising_edge(clk);
			
			a <= instruction(7 downto 0);
			op <= instruction (15 downto 8);
			b  <= instruction (23 downto 16);
			c  <= instruction (31 downto 24);
			
	end process;


end Behavioral;

