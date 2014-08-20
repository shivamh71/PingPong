----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:01:25 04/08/2013 
-- Design Name: 
-- Module Name:    collision - Behavioral 
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

entity collision is
	 Port (
				clk : in STD_LOGIC;
				leftPaddleY : in integer range 0 to 480  ;
				rightPaddleY : IN integer range 0 to 480;
				ballX : in integer range 0 to 640 ;
				ballY : in integer range 0 to 480 ;
--				ballSpeedX : IN integer range -100 to 100 := 1;
--				ballSpeedY : IN integer range -100 to 100 := 1;
				checkCollision: out STD_LOGIC_VECTOR (2 downto 0)
				-- 000 == for no collision
				-- 001 == collision with left paddle
				-- 010 == collision with left wall
				-- 011 == collision with top wall
				-- 100 == collision with right paddle
				-- 101 == collision with right wall
				-- 110 == collision with bottom wall
			);
	
end collision;

architecture Behavioral of collision is

	constant screenHeight: integer :=480;
	constant screenWidth: integer :=640;
	constant leftPaddleX : integer := 25;
	constant rightPaddleX : integer := 615;
	constant paddleHalfHeight : integer := 30;
	constant paddleHalfWidth : integer := 6;
	constant leftPaddleBackX : integer := leftPaddleX-paddleHalfWidth;
	constant leftPaddleFrontX : integer := leftPaddleX+paddleHalfWidth;
	constant rightPaddleFrontX : integer := rightPaddleX-paddleHalfWidth;
	constant rightPaddleBackX : integer := rightPaddleX+paddleHalfWidth;
	constant paddleBottomLimit : integer := 474;
	constant paddleTopLimit : integer := 4;
	constant ballRadius:integer :=4;
begin
collisionDetector: process(clk)
	begin
	if(rising_edge(clk)) then
		if ((ballX-ballRadius)< leftPaddleFrontX) and (ballX > leftPaddleBackX) 
			and ((ballY+ballRadius) > leftPaddleY-paddleHalfHeight)
			and ((ballY-ballRadius) < leftPaddleY+paddleHalfHeight) then
			
			checkCollision <= "001";
		
		elsif ballX  < ballRadius then
			checkCollision <= "010";
		
		elsif ballY < ballRadius then
			checkCollision <= "011";
		
		elsif (((ballX+ballRadius) > rightPaddleFrontX) and (ballX < rightPaddleBackX) and 
			((ballY+ballRadius) > rightPaddleY-paddleHalfHeight) and
			((ballY-ballRadius) < rightPaddleY+paddleHalfHeight)) then
			checkCollision <= "100";
	
		elsif ballX > (screenWidth- ballRadius -1) then
			checkCollision <= "101";
		
		elsif ballY > (screenHeight- ballRadius -1) then
			checkCollision <= "110";
		
		else
			checkCollision <= "000";
		
		end if ;
	end if;
	end process;
end Behavioral;

