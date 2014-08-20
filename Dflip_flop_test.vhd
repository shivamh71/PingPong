--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:28:53 04/08/2013
-- Design Name:   
-- Module Name:   /home/nilesh/Academics/cs288/Ping Pong/Paddle/Dflip_flop_test.vhd
-- Project Name:  Paddle
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Dflip_flop
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
 
ENTITY Dflip_flop_test IS
END Dflip_flop_test;
 
ARCHITECTURE behavior OF Dflip_flop_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Dflip_flop
    PORT(
         D : IN  std_logic;
         clk : IN  std_logic;
         Q : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal D : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal Q : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Dflip_flop PORT MAP (
          D => D,
          clk => clk,
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
      wait for 10 ns;	
		D<='1';
		wait for 32ns;
		D<='0';
		wait for 39ns;	
     
      -- insert stimulus here 

      wait;
   end process;

END;
