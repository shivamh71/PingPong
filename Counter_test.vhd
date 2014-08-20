--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:38:45 04/08/2013
-- Design Name:   
-- Module Name:   /home/nilesh/Academics/cs288/Ping Pong/Paddle/Counter_test.vhd
-- Project Name:  Paddle
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Counter
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
 
ENTITY Counter_test IS
END Counter_test;
 
ARCHITECTURE behavior OF Counter_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Counter
    PORT(
         clk : IN  std_logic;
         enable : IN  std_logic;
         Sclr : IN  std_logic;
         Cout : OUT  std_logic;
         Q : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal enable : std_logic := '0';
   signal Sclr : std_logic := '0';

 	--Outputs
   signal Cout : std_logic;
   signal Q : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Counter PORT MAP (
          clk => clk,
          enable => enable,
          Sclr => Sclr,
          Cout => Cout,
          Q => Q
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
		enable<=(not Cout);
		wait for 200 ns;
		Sclr<='1';
		wait for 5ns;
		Sclr<='0';
		wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
