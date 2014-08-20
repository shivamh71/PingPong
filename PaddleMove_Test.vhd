--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:15:35 04/09/2013
-- Design Name:   
-- Module Name:   /home/nilesh/Academics/cs288/Ping Pong/Paddle/PaddleMove_Test.vhd
-- Project Name:  Paddle
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PaddleMovement
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
 
ENTITY PaddleMove_Test IS
END PaddleMove_Test;
 
ARCHITECTURE behavior OF PaddleMove_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PaddleMovement
    PORT(
         clk : IN  std_logic;
         up : IN  std_logic;
         down : IN  std_logic;
         paddlePosition : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal up : std_logic := '0';
   signal down : std_logic := '0';

 	--Outputs
   signal paddlePosition : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PaddleMovement PORT MAP (
          clk => clk,
          up => up,
          down => down,
          paddlePosition => paddlePosition
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
		up<='1';
		wait for 750ns;
		up<='0';
		
		wait for 750ns;
		up<='1';
		wait for 750ns;
		up<='0';
		
		wait for 750ns;
		down<='1';
		wait for 750ns;
		down<='0';
		
		wait for 750ns;
		down<='1';
		wait for 750ns;
		down<='0';
		
		wait for 750ns;
		up<='1';
		wait for 750ns;
		up<='0';
		
		wait for 750ns;
		up<='1';
		wait for 750ns;
		up<='0';
		
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
