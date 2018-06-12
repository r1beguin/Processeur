----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:37:29 06/06/2018 
-- Design Name: 
-- Module Name:    mux - Behavioral 
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

entity mux is
    Port ( B 		 : in  STD_LOGIC_VECTOR(7 downto 0);
           QA 		 : in  STD_LOGIC_VECTOR(7 downto 0);
           OP 		 : in  STD_LOGIC_VECTOR(7 downto 0);
			  CLK 	 : in STD_LOGIC;
           mux_out : out  STD_LOGIC_VECTOR(7 downto 0));
end mux;

architecture Behavioral of mux is

begin

	mux_out <= B when (OP = x"0A") else
				  QA ;
	process
	begin
	wait until rising_edge(clk);
	end process;

end Behavioral;

