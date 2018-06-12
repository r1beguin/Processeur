----------------------------------------------------------------------------------
-- Company: Nice_corp
-- Engineer: Moi + K.Drift
-- 
-- Create Date:    10:43:25 05/03/2018 
-- Design Name: 
-- Module Name:    UAL - Behavioral 
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

entity UAL is
    Port ( A 		: in  STD_LOGIC_VECTOR(7 downto 0 ); -- 16 bits
           B 		: in  STD_LOGIC_VECTOR(7 downto 0 ); -- 16 bits
           op 		: in  STD_LOGIC_VECTOR(7 downto 0 ); -- 4 bits
           S 		: out  STD_LOGIC_VECTOR(7 downto 0 ); -- 16 bits
           flags  : out  STD_LOGIC_VECTOR(3 downto 0 ) -- 4 bits (zero, neg, overflow, carry)
			 ); 
end UAL;

architecture Behavioral of UAL is

signal Smul : STD_LOGIC_VECTOR(15 downto 0); --Signal sur 32bits utilisé pour faire la multiplication
signal Sadd : STD_LOGIC_VECTOR(8 downto 0); --Signal sur 17 bits utilisé pour faire l'addition
signal Ssou : STD_LOGIC_VECTOR(8 downto 0); --Signal sur 17 bits utilisé pour faire la soustraction

signal Sinf  : STD_LOGIC_VECTOR(7 downto 0); --Signal sur 16 bits utilisé pour faire une comparaison d'infériorité stricte
signal Ssup  : STD_LOGIC_VECTOR(7 downto 0); --Signal sur 16 bits utilisé pour faire une comparaison de supériorité stricte
signal Sinfe : STD_LOGIC_VECTOR(7 downto 0); --Signal sur 16 bits utilisé pour faire une comparaison d'infériorité ou d'egalité
signal Ssupe : STD_LOGIC_VECTOR(7 downto 0); --Signal sur 16 bits utilisé pour faire une comparaison de supériorité ou d'egalité
signal Seq 	 : STD_LOGIC_VECTOR(7 downto 0);

begin
--On code la sortie S de l'UAL selon l'op en entrée (+, -, *, >>, <<, >, <, <=, >=, =, ..)

S <= 	Sadd(7 downto 0) when op = x"00" else  
		Ssou(7 downto 0) when op = x"01" else
		Smul(7 downto 0) when op = x"02" else
		SHR(A,B) when op = x"03" else  -- Décalage à droite   --'0'& A(15 downto 1) 
		SHL(A,B) when op = x"04" else -- Décalage à gauche
		Sinf(7 downto 0) when op = x"05" else -- Strictement Inférieur
		Ssup(7 downto 0) when op = x"06" else -- Strictement Supérieur
		Sinfe(7 downto 0) when op = x"07" else -- Inférieur ou égal 
		Ssupe(7 downto 0) when op = x"08" else	-- Supérieur ou égal 
		Seq(7 downto 0) when op = x"09" ;		-- Faire l'egalité
		
Smul  <= (A * B) ;
Sadd  <= (('0'&A) + ('0'&B) ) ;
Ssou  <= (('0'&A) - ('0'&B) ) ;
Sinf  <= x"01" when (A<B) else x"00";
Ssup  <= x"01" when (A>B) else x"00";
Sinfe <= x"01" when (A<=B) else x"00";
Ssupe <= x"01" when (A>=B) else x"00";
Seq   <= x"01" when (A=B) else x"00";

---------------------------------- Gestion des flags ------------------------------------
							
flags(0) <= Sadd(8); -- Le bit 0 de flags est la retenue(carry)

flags(1) <= ('1') -- Le bit 1 de flags utilisé pour l'overflow
	when (op = x"0" and ((A(7)= B(7)) and ( B(7) /= Sadd(7)) )) else '0' ;

flags(2) <= Sadd(7) when (op = x"00") else Ssou(7) when ( op = x"01") else '0' ;-- Le bit 2 de flags utilisé pour la négation

flags(3) <= ('1') -- Le bit 3 de flags utilisé pour le zéro
	when (((Sadd = x"00") and (op = x"00")) or ((Ssou = x"00") and (op = x"01"))) else '0' ;
	
end Behavioral;

