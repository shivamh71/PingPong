--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:45:22 04/11/2013
-- Design Name:   
-- Module Name:   /home/nilesh/Academics/cs288/Ping Pong/PingPong/PongTest.vhd
-- Project Name:  PingPong
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Pong
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
 
ENTITY PongTest IS
END PongTest;
 
ARCHITECTURE behavior OF PongTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Pong
    PORT(
         clk100Mhz : IN  std_logic;
         upLeft : IN  std_logic;
         downLeft : IN  std_logic;
         upRight : IN  std_logic;
         downRight : IN  std_logic;
         MasterReset : IN  std_logic;
         Start : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk100Mhz : std_logic := '0';
   signal upLeft : std_logic := '0';
   signal downLeft : std_logic := '0';
   signal upRight : std_logic := '0';
   signal downRight : std_logic := '0';
   signal MasterReset : std_logic := '0';
   signal Start : std_logic := '0';

   -- Clock period definitions
   constant clk100Mhz_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Pong PORT MAP (
          clk100Mhz => clk100Mhz,
          upLeft => upLeft,
          downLeft => downLeft,
          upRight => upRight,
          downRight => downRight,
          MasterReset => MasterReset,
          Start => Start
        );

   -- Clock process definitions
   clk100Mhz_process :process
   begin
		clk100Mhz <= '0';
		wait for clk100Mhz_period/2;
		clk100Mhz <= '1';
		wait for clk100Mhz_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		start<='1';
		wait for 3 ns;
		start<='0';
		
		
      wait for clk100Mhz_period*10;

      -- insert stimulus here 
		
      wait;
   end process;

END;
