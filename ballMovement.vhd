----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:50:19 04/08/2013 
-- Design Name: 
-- Module Name:    ballMovement - Behavioral 
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


				-- 000 == for no collision
				-- 001 == collision with left paddle
				-- 010 == collision with left wall
				-- 011 == collision with top wall
				-- 100 == collision with right paddle
				-- 101 == collision with right wall
				-- 110 == collision with bottom wall
entity ballMovement is
	 Port (
				clk : in STD_LOGIC;
				leftPaddleY : IN integer range 0 to 480 ;
				rightPaddleY : IN integer range 0 to 480;
				ballX : out integer range 0 to 640 ;
				ballY : out integer range 0 to 480 ;
				leftPaddleScore : out integer range 0 to 15;
				rightPaddleScore : out integer range 0 to 15;
				MasterReset : in std_logic
			);

end ballMovement;

architecture Behavioral of ballMovement is
			constant ballInitialSpeedX :integer:= 1;
			constant ballInitialSpeedY :integer:=1;
			signal leftPaddleScoreDummy : integer := 3;
			signal rightPaddleScoreDummy : integer := 2;
			signal ballSpeedX : integer := ballInitialSpeedX;
			signal ballSpeedY : integer := ballInitialSpeedY;
			signal leftpaddle : integer range 0 to 480;
			signal rightpaddle : integer range 0 to 640;
			signal checkCollision : STD_LOGIC_VECTOR  (2 downto 0) := "000" ;
			signal reset : std_logic := '0';
			signal ballXNext :integer :=320;
			signal ballYNext : integer:= 240;
			constant tolerence: integer := 0;
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
	setBallVelocity: process(clk,masterReset)
	begin
		if(rising_edge(clk)) then
			if(masterReset='1') then
				ballXNext<=320;
				ballYNext<=240;
				rightPaddleScoreDummy<=0;
				leftPaddleScoreDummy<=0;
				ballSpeedX <= ballInitialSpeedX;
				ballSpeedY <= ballInitialSpeedY;
			elsif ((ballXNext+ballSpeedX-ballRadius)< leftPaddleFrontX) and (ballXNext+ballSpeedX > leftPaddleBackX) and ((ballYNext+ballSpeedY+ballRadius) > leftPaddleY-paddleHalfHeight) and ((ballYNext+ballSpeedY-ballRadius) < leftPaddleY+paddleHalfHeight) then
				ballSpeedX <= -ballSpeedX;
				ballXNext <= ballXNext + ballSpeedX;
				ballYNext <= ballYNext + ballSpeedY;
					
			elsif ballXNext + ballSpeedX < ballRadius then
				rightPaddleScoreDummy <= rightPaddleScoreDummy + 1;
				ballXNext <= 320;
				ballYNext <= 240;
				ballSpeedX <= ballInitialSpeedX;
				ballSpeedY <= ballInitialSpeedY;
				
			elsif ballYNext+ballSpeedY< ballRadius + tolerence then
				ballSpeedY <= -ballspeedY;
				ballXNext <= ballXNext + ballSpeedX;
				ballYNext <= ballYNext + ballSpeedY;
			
			elsif (((ballXNext+ballSpeedX+ballRadius) > rightPaddleFrontX) and (ballXNext+ballSpeedX < rightPaddleBackX) and ((ballYNext+ballSpeedY+ballRadius) > rightPaddleY-paddleHalfHeight) and ((ballYNext+ballSpeedY-ballRadius) < rightPaddleY+paddleHalfHeight)) then
				ballSpeedX <= -ballSpeedX;
				ballXNext <= ballXNext + ballSpeedX;
				ballYNext <= ballYNext + ballSpeedY;
			
			elsif ballXNext+ballSpeedX > (screenWidth- ballRadius -1) then
			   leftPaddleScoreDummy <= leftPaddleScoreDummy + 1;
				ballXNext <= 320;
				ballYNext <= 240;
				ballSpeedX <= ballInitialSpeedX;
				ballSpeedY <= ballInitialSpeedY;
			
			elsif ballYNext+ballSpeedY > (screenHeight- ballRadius -1-tolerence) then
				ballSpeedY <= -ballSpeedY;
				ballXNext <= ballXNext + ballSpeedX;
				ballYNext <= ballYNext + ballSpeedY;
			
			else
				ballXNext <= ballXNext + ballSpeedX;
				ballYNext <= ballYNext + ballSpeedY;
			end if;
			rightPaddleScore <= rightPaddleScoreDummy;
			leftPaddleScore <= leftPaddleScoreDummy; 
			ballX <= ballXNext;
			ballY <= ballYNext;
		end if;
	end process;	
end Behavioral;


