--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:16:46 04/11/2013
-- Design Name:   
-- Module Name:   /home/shubham/Desktop/xilinx/pingpong/rgbTest.vhd
-- Project Name:  pingpong
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: rgb
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
 
ENTITY rgbTest IS
END rgbTest;
 
ARCHITECTURE behavior OF rgbTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT rgb
    PORT(
         clk : IN  std_logic;
         leftPaddleY : IN  integer range 0 to 480;
         rightPaddleY : IN  integer range 0 to 480;
         ballX : IN  integer range 0 to 640;
         ballY : IN  integer range 0 to 480;
         leftPaddleScore : IN  integer range 0 to 16;
         rightPaddleScore : IN  integer range 0 to 16;
         scrollerX : IN  integer range 0 to 640;
         scrollerY : IN integer range 0 to 480;
         gameOver : IN  std_logic;
         color : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal leftPaddleY : integer range 0 to 480;
   signal rightPaddleY :    integer range 0 to 480;
   signal ballX :  integer range 0 to 640;
   signal ballY :   integer range 0 to 480;
   signal leftPaddleScore :  integer range 0 to 16;
   signal rightPaddleScore :  integer range 0 to 16;
   signal scrollerX :   integer range 0 to 640;
   signal scrollerY :  integer range 0 to 480;
   signal gameOver : std_logic := '0';

 	--Outputs
   signal color : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: rgb PORT MAP (
          clk => clk,
          leftPaddleY => leftPaddleY,
          rightPaddleY => rightPaddleY,
          ballX => ballX,
          ballY => ballY,
          leftPaddleScore => leftPaddleScore,
          rightPaddleScore => rightPaddleScore,
          scrollerX => scrollerX,
          scrollerY => scrollerY,
          gameOver => gameOver,
          color => color
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
		leftPaddleY <= 200;
		rightPaddleY <= 200;
		ballX<= 200;
		ballY<= 320;
		leftPaddleScore<=10;
		rightPaddleScore<=6;
		scrollerX<=200;
		scrollerY<=320;
		gameOver<='0';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
