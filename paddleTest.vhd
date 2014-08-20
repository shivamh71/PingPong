--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:03:20 04/09/2013
-- Design Name:   
-- Module Name:   /home/nilesh/Academics/cs288/Ping Pong/Paddle/paddleTest.vhd
-- Project Name:  Paddle
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: paddle
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
 
ENTITY paddleTest IS
END paddleTest;
 
ARCHITECTURE behavior OF paddleTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT paddle
    PORT(
         clk : IN  std_logic;
         upLeft : IN  std_logic;
         downLeft : IN  std_logic;
         upRight : IN  std_logic;
         downRight : IN  std_logic;
         paddleRightPosition : OUT  std_logic_vector(5 downto 0);
         paddleLeftPosition : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal upLeft : std_logic := '0';
   signal downLeft : std_logic := '0';
   signal upRight : std_logic := '0';
   signal downRight : std_logic := '0';

 	--Outputs
   signal paddleRightPosition : std_logic_vector(5 downto 0);
   signal paddleLeftPosition : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: paddle PORT MAP (
          clk => clk,
          upLeft => upLeft,
          downLeft => downLeft,
          upRight => upRight,
          downRight => downRight,
          paddleRightPosition => paddleRightPosition,
          paddleLeftPosition => paddleLeftPosition
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

		downRight<='1';
		wait for 750ns;
		downRight<='0';
		wait for 750ns;
		
		downRight<='1';
		wait for 750ns;
		downRight<='0';
		wait for 750ns;
		
		downRight<='1';
		wait for 750ns;
		downRight<='0';
		wait for 750ns;
		
		downLeft<='1';
		wait for 750ns;
		downLeft<='0';
		wait for 750ns;

	
		downLeft<='1';
		wait for 750ns;
		downLeft<='0';
		wait for 750ns;
		
		downLeft<='1';
		wait for 750ns;
		downLeft<='0';
		wait for 750ns;
		
		downLeft<='1';
		wait for 750ns;
		downLeft<='0';
		wait for 750ns;
		
		downLeft<='1';
		wait for 750ns;
		downLeft<='0';
		wait for 750ns;
      -- insert stimulus here 

      wait;
   end process;

END;
