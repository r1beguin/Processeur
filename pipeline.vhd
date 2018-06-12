----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:11:22 05/28/2018 
-- Design Name: 
-- Module Name:    pipeline - Behavioral 
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

entity pipeline is
    Port ( op_in  : in  STD_LOGIC_VECTOR(7 downto 0);
           op_out : out  STD_LOGIC_VECTOR(7 downto 0);
           a_in   : in  STD_LOGIC_VECTOR(7 downto 0);
           a_out  : out  STD_LOGIC_VECTOR(7 downto 0);
           b_in   : in  STD_LOGIC_VECTOR(7 downto 0);
           b_out  : out  STD_LOGIC_VECTOR(7 downto 0);
           c_in   : in  STD_LOGIC_VECTOR(7 downto 0);
           c_out  : out  STD_LOGIC_VECTOR(7 downto 0);
           clk    : in  STD_LOGIC);
end pipeline;

architecture Behavioral of pipeline is

begin
	process	
	begin
		wait until rising_edge(clk);
		op_out <= op_in;
		a_out  <= a_in;
		b_out  <= b_in;
		c_out  <= c_in;
		
	end process;

end Behavioral;

