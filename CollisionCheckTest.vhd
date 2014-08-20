--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:22:46 04/11/2013
-- Design Name:   
-- Module Name:   /home/nilesh/Academics/cs288/Ping Pong/BallMovement/CollisionCheckTest.vhd
-- Project Name:  BallMovement
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: collision
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
USE ieee.numeric_std.ALL;
 
ENTITY CollisionCheckTest IS
END CollisionCheckTest;
 
ARCHITECTURE behavior OF CollisionCheckTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT collision
    PORT(
         clk : IN  std_logic;
         leftPaddleY : in  integer range 0 to 480;
         rightPaddleY : IN  integer range 0 to 480;
         ballX : in integer range 0 to 640;
         ballY : in integer range 0 to 480;
         checkCollision : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal leftPaddleY : integer range 0 to 480   ;
   signal rightPaddleY :  integer range 0 to 480 ;
   signal ballX :  integer range 0 to 640;
   signal ballY :  integer range 0 to 480 ;

 	--Outputs
   signal checkCollision : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: collision PORT MAP (
          clk => clk,
          leftPaddleY => leftPaddleY,
          rightPaddleY => rightPaddleY,
          ballX => ballX,
          ballY => ballY,
          checkCollision => checkCollision
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
		ballX<=467;
		ballY<=320;
		rightPaddleY<=240;
		leftPaddleY<=240;
--		ballX<=467;
--		ballY<=637;
--		rightPaddleY<=240;
--		leftPaddleY<=240;
		wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
