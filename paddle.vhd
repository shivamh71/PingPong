----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:57:27 04/09/2013 
-- Design Name: 
-- Module Name:    paddle - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity paddle is
    Port ( clk : in  STD_LOGIC;
           upLeft : in  STD_LOGIC;
           downLeft : in  STD_LOGIC;
           upRight : in  STD_LOGIC;
           downRight : in  STD_LOGIC;
           paddleRightPosition : out Integer range 0 to 480  ;
           paddleLeftPosition : out  Integer range 0 to 480;
			  MasterReset : in std_logic);
end paddle;

architecture Behavioral of paddle is

component PaddleMovement is
	 Port ( clk : in  STD_LOGIC;
           up : in  STD_LOGIC;
           down : in  STD_LOGIC;
           paddlePosition : out  Integer range 0 to 480;
			  MasterReset:in std_logic
			  );
end component;

begin

paddleRight: PaddleMovement port map(clk,upRight,downRight,paddleRightPosition,MasterReset);
paddleLeft: PaddleMovement port map(clk,upLeft,downLeft,paddleLeftPosition,MasterReset);
end Behavioral;

