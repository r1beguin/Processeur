--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:04:34 06/04/2018
-- Design Name:   
-- Module Name:   /home/joannes/4A/Proj_Syst_Info/microprocesseur/test_proc.vhd
-- Project Name:  microprocesseur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: processeur
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
 
ENTITY test_proc IS
END test_proc;
 
ARCHITECTURE behavior OF test_proc IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT processeur
    PORT(
         clk : IN  std_logic;
         ins_di : IN  std_logic_vector(7 downto 0);
         ins_a : IN  std_logic_vector(7 downto 0);
         data_di : OUT  std_logic_vector(7 downto 0);
         data_we : OUT  std_logic_vector(7 downto 0);
         data_a : OUT  std_logic_vector(7 downto 0);
         data_do : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal clk : std_logic := '0';
   signal ins_di : std_logic_vector(7 downto 0) := (others => '0');
   signal ins_a : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal data_di : std_logic_vector(7 downto 0);
   signal data_we : std_logic_vector(7 downto 0);
   signal data_a : std_logic_vector(7 downto 0);
   signal data_do : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: processeur PORT MAP (
          clk => clk,
          ins_di => ins_di,
          ins_a => ins_a,
          data_di => data_di,
          data_we => data_we,
          data_a => data_a,
          data_do => data_do
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
      wait for 100 ns;	
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
