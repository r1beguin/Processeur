----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:35:54 05/28/2018 
-- Design Name: 
-- Module Name:    processeur - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity processeur is
  Port ( clk : in STD_LOGIC ;
				ins_di 	: in  STD_LOGIC_VECTOR (7 downto 0);
           ins_a 		: in  STD_LOGIC_VECTOR (7 downto 0);
           data_di 	: out  STD_LOGIC_VECTOR (7 downto 0);
           data_we 	: out  STD_LOGIC_VECTOR (7	downto 0);
			  data_a 	: out STD_LOGIC_VECTOR (7 downto 0);
			  data_do 	: out STD_LOGIC_VECTOR (7 downto 0));
end processeur;

architecture Behavioral of processeur is
-- Begin Component --

 COMPONENT UAL
    PORT(
         A 		: IN  std_logic_vector(7 downto 0);
         B 		: IN  std_logic_vector(7 downto 0);
         op 	: IN  std_logic_vector(7 downto 0);
         S 		: OUT  std_logic_vector(7 downto 0);
         flags : OUT  std_logic_vector(3 downto 0)
        );
 END COMPONENT;
	 
 COMPONENT banc_registres
    PORT(aA 		: IN  std_logic_vector (7 downto 0);
           aB 		: IN  std_logic_vector (7 downto 0);
           aW 		: IN  std_logic_vector (7 downto 0);
           DATA 	: IN  std_logic_vector (7 downto 0);
           W 		: IN  std_logic;
			  CLK 	: IN  std_logic;
			  QA 		: OUT std_logic_vector (7 downto 0);
			  QB 		: OUT std_logic_vector (7 downto 0)
			  );
 END COMPONENT;
 
 COMPONENT pipeline 
    Port ( op_in 	: in  STD_LOGIC_VECTOR(7 downto 0);
           op_out : out  STD_LOGIC_VECTOR(7 downto 0);
           a_in 	: in  STD_LOGIC_VECTOR(7 downto 0);
           a_out 	: out  STD_LOGIC_VECTOR(7 downto 0);
           b_in 	: in  STD_LOGIC_VECTOR(7 downto 0);
           b_out 	: out  STD_LOGIC_VECTOR(7 downto 0);
           c_in 	: in  STD_LOGIC_VECTOR(7 downto 0);
           c_out 	: out  STD_LOGIC_VECTOR(7 downto 0);
           clk 	: in  STD_LOGIC);
 END COMPONENT;
 
 COMPONENT decodeur 
    Port ( instruction 	: in  STD_LOGIC_VECTOR(31 downto 0);
           a 				: out  STD_LOGIC_VECTOR(7 downto 0);
           b 				: out  STD_LOGIC_VECTOR(7 downto 0);
           c 				: out  STD_LOGIC_VECTOR(7 downto 0);
           op 				: out  STD_LOGIC_VECTOR(7 downto 0);
			  clk 			: in STD_LOGIC);
 END COMPONENT;
 
 COMPONENT mux
    Port ( B : in  STD_LOGIC_VECTOR(7 downto 0);
           QA : in  STD_LOGIC_VECTOR(7 downto 0);
           OP : in  STD_LOGIC_VECTOR(7 downto 0);
			  CLK : in STD_LOGIC;
           mux_out : out  STD_LOGIC_VECTOR(7 downto 0));
	END COMPONENT ;
--END COMPONENT --

--BEGIN SIGNALS--
	
	-- Clock globale
constant CLK_period : time := 10 ns;
	
	--UAL
-- in
signal A_ual  : std_logic_vector(7 downto 0) := (others => '0');
signal B_ual  : std_logic_vector(7 downto 0) := (others => '0');
signal op_ual : std_logic_vector(7 downto 0)  := (others => '0');
-- out
signal S 	 : std_logic_vector(7 downto 0);
signal flags : std_logic_vector(3 downto 0);

	--PIPELINE
type stage is record
op_in, op_out, a_in, a_out, c_in, c_out, b_in, b_out : std_logic_vector(7 downto 0);
end record;

signal p1 : stage ;
signal p2 : stage ;
signal p3 : stage ;
signal p4 : stage ;

	--BANC_REGISTRE
-- in
signal aA 	: std_logic_vector (7 downto 0) := (others => '0');
signal aB 	: std_logic_vector (7 downto 0) := (others => '0');
signal aW 	: std_logic_vector (7 downto 0) := (others => '0');
signal DATA : std_logic_vector (7 downto 0):= (others => '0');
signal W 	: std_logic;
-- out
signal QA : std_logic_vector (7 downto 0);
signal QB : std_logic_vector (7 downto 0);

	--DECODEUR
-- in
signal instruction 	: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
-- out
signal a_decod  : STD_LOGIC_VECTOR(7 downto 0);
signal b_decod  : STD_LOGIC_VECTOR(7 downto 0);
signal c_decod  : STD_LOGIC_VECTOR(7 downto 0);
signal op_decod : STD_LOGIC_VECTOR(7 downto 0);
signal addr  : STD_LOGIC_VECTOR(3 downto 0) := x"0";

	--MUX
type multi is record
B, QA, mux_out, op : STD_LOGIC_VECTOR(7 downto 0);
end record;

signal m1 : multi;
signal m2 : multi;

type array_inst is array(integer range <>) of STD_LOGIC_VECTOR(31 downto 0) ;
signal mem_ins : array_inst(0 to 15);

begin

 mem_ins <= (x"00050A00", x"00000B01", x"00000A05", x"00000A05", x"01000202", x"00010A03", x"01030001", x"000A0A04", x"00000A05", x"04010102", others => x"00000A05");
 instruction <= mem_ins(conv_integer(addr));

 decod : decodeur PORT MAP (
	instruction => instruction,
	clk 			=> CLK,
	a 				=> a_decod,
	b 				=> b_decod,
	c 				=> c_decod,
	op 			=> op_decod
 );
 
  reg : banc_registres PORT MAP (
	aA 	=> aA,
   aB 	=> aB,
   aW 	=> aW,
   DATA  => DATA,
   W 		=> W,
	CLK 	=> CLK,
	QA 	=> QA,
	QB 	=> QB
 );
 
 mu_bdr : mux PORT MAP (
	B 			=> m1.B,
	QA 		=> m1.QA,
	OP 		=> m1.op,
	CLK 		=> CLK,
	mux_out  => m1.mux_out
 );

 mu_ual : mux PORT MAP (
	B 			=> m2.B,
	QA 		=> m2.QA,
	OP 		=> m2.op,
	CLK 		=> CLK,
	mux_out  => m2.mux_out
 );
 
 LIDI : pipeline PORT MAP (
	op_in  => p1.op_in,
	op_out => p1.op_out,
	a_in 	 => p1.a_in,
	a_out  => p1.a_out,
	b_in 	 => p1.b_in,
	b_out  => p1.b_out,
	c_in 	 => p1.c_in,
	c_out  => p1.c_out,
	clk 	 => CLK
 );
 
 DIEX : pipeline PORT MAP (
	op_in  => p2.op_in,
	op_out => p2.op_out,
	a_in 	 => p2.a_in,
   a_out  => p2.a_out,
   b_in 	 => p2.b_in,
   b_out  => p2.b_out,
   c_in 	 => p2.c_in,
   c_out  => p2.c_out,
   clk 	 => CLK
 );
 
  alu : UAL PORT MAP (
	A 		=> A_ual,
   B 		=> B_ual,
   op 	=> op_ual,
   S 		=> S,
   flags => flags
 );
 
 EXMem : pipeline PORT MAP (
	op_in  => p3.op_in,
   op_out => p3.op_out,
   a_in 	 => p3.a_in,
   a_out  => p3.a_out,
   b_in 	 => p3.b_in,
   b_out  => p3.b_out,
   c_in 	 => p3.c_in,
   c_out  => p3.c_out,
   clk 	 => CLK
 );

 MemRE : pipeline PORT MAP (
	op_in  => p4.op_in,
   op_out => p4.op_out,
   a_in 	 => p4.a_in,
   a_out  => p4.a_out,
   b_in 	 => p4.b_in,
   b_out  => p4.b_out,
   c_in 	 => p4.c_in,
   c_out  => p4.c_out,
   clk 	 => CLK
 );
 
 p1.op_in 	<= op_decod;
 p1.a_in 	<= a_decod;
 p1.b_in 	<= b_decod;
 p1.c_in 	<= c_decod;
 p2.op_in 	<= p1.op_out;
 m1.op 		<= p1.op_out;
 p2.a_in 	<= p1.a_out;
 aA 			<= p1.b_out ;
 m1.B 		<= p1.b_out ;
 m1.QA 		<= QA ;
 aB 			<= p1.c_out ;
 p2.b_in 	<= m1.mux_out;
 p2.c_in 	<= QB ;
 B_ual 		<= p2.c_out ;
 A_ual 		<= p2.b_out;
 op_ual 		<= p2.op_out ;
 m2.B 		<= p2.b_out;
 m2.QA 		<= S;
 m2.op 		<= x"0A" when p2.op_out >= x"0A" else p2.op_out ; -- Dans le cas AFC (0A) ou COP (0B) on ne prend pas le résultat de l'ALU
 p3.op_in 	<= p2.op_out;
 p3.a_in 	<= p2.a_out;
 p3.b_in 	<= m2.mux_out;
 p3.c_in 	<= p2.c_out;
 p4.op_in 	<= p3.op_out;
 p4.a_in 	<= p3.a_out;
 p4.b_in 	<= p3.b_out;
 p4.c_in 	<= p3.c_out;
 DATA 		<= p4.b_out ;
 aW 			<= p4.a_out ;
 W 			<= '1' when (p4.op_out >= x"00") else '0';
 
 process
 begin
	wait until rising_edge(clk);
	addr <= addr + 1;
 end process;

end Behavioral;