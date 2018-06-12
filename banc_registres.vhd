----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:15:16 05/18/2018 
-- Design Name: 
-- Module Name:    banc_registres - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity banc_registres is
    Port ( aA : in  STD_LOGIC_VECTOR (7 downto 0 );
           aB : in  STD_LOGIC_VECTOR (7 downto 0 );
           aW : in  STD_LOGIC_VECTOR (7 downto 0 );
           DATA : in  STD_LOGIC_VECTOR (7 downto 0 );
           W : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  QA : out STD_LOGIC_VECTOR (7 downto 0 );
			  QB : out STD_LOGIC_VECTOR (7 downto 0 ));
end banc_registres;

architecture Behavioral of banc_registres is

type arrayRegister is array(integer range <>) of STD_LOGIC_VECTOR(7 downto 0) ;
signal registres : arrayRegister(0 to 15);

begin

	QA <= registres(to_integer(unsigned(aA))) when ((W = '0') or (aA /= aW)) else DATA ;
	QB <= registres(to_integer(unsigned(aB))) when ((W = '0') or (aB /= aW)) else DATA ;
	process
	begin
		wait until rising_edge(CLK);
		if W = '1' then
			registres(to_integer(unsigned(aW))) <= DATA;
		end if;
	end process;

end Behavioral;