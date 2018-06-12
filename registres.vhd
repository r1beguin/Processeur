--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:40:43 05/28/2018
-- Design Name:   
-- Module Name:   /home/joannes/4A/Proj_Syst_Info/microprocesseur/registres.vhd
-- Project Name:  microprocesseur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: banc_registres
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY registres IS
END registres;
 
ARCHITECTURE behavior OF registres IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT banc_registres
    PORT(aA : IN  std_logic_vector (3 downto 0 );
           aB : IN  std_logic_vector (3 downto 0 );
           aW : IN  std_logic_vector (3 downto 0 );
           DATA : IN  std_logic_vector (15 downto 0 );
           W : IN  std_logic;
			  CLK : IN  std_logic;
			  QA : OUT std_logic_vector (15 downto 0 );
			  QB : OUT std_logic_vector (15 downto 0 )
			  );
    END COMPONENT;
    

   --Inputs
   signal aA : std_logic_vector(3 downto 0) := (others => '0');
   signal aB : std_logic_vector(3 downto 0) := (others => '0');
   signal aW : std_logic_vector(3 downto 0) := (others => '0');
   signal DATA : std_logic_vector(15 downto 0) := (others => '0');
   signal W : std_logic := '0';
	signal CLK : std_logic := '0';

 	--Outputs
   signal QA : std_logic_vector(15 downto 0);
   signal QB : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
	--signal clk: std_logic:='0' ;
 
BEGIN
 
	-- Instantiate the 
   uut: banc_registres PORT MAP (
          aA => aA,
          aB => aB,
          aW => aW,
          DATA => DATA,
          W => W,
          QA => QA,
          QB => QB,
			 CLK => CLK
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      --wait for 100 ns;	

      --wait for <clock>_period*10;

      -- insert stimulus here 
		W <= '1';
		aW <= x"1";
		aA <= x"2";
		aB <= x"3";
		DATA <= x"00FF";
		
		wait for clk_period ;
		
		W <= '0';
		aA<= x"1";
		aW<= x"F";
		aB<=x"A";
		DATA <= x"BABA";
		
		wait for clk_period ;
		
		
		wait;
		
   end process;

END;
