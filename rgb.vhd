----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:25:24 04/11/2013 
-- Design Name: 
-- Module Name:    rgb - Behavioral 
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

entity rgb is
				Port(clk : in STD_LOGIC;
				leftPaddleY : IN integer range 0 to 480 := 0;
				rightPaddleY : IN integer range 0 to 480 := 0;
				ballX : in integer range 0 to 640 := 320;
				ballY : in integer range 0 to 480 := 240;
				leftPaddleScore : in integer range 0 to 16 := 0;
				rightPaddleScore : in integer range 0 to 16 := 0;
				scrollerX : in integer range 0 to 640  := 0;
				scrollerY : in integer range 0 to 480  := 0;
				gameOver : in Std_logic;
				color : out std_logic_vector (2 downto 0));
end rgb;
	
architecture Behavioral of rgb is
	constant maxScore : integer := 15 ;
	constant lifeBarHeight : integer := 3;
	constant leftLifePosition : integer := 29;
	constant rightLifePosition : integer := 611;
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
begin
	colorSetter : process(scrollerX,scrollerY,clk)
	---111 color code for paddle
	---110 color code for ball
	begin 
		if gameOver='0' then
			---white paddle
			if ((scrollerX >= leftPaddleBackX) and (scrollerX <= leftPaddleFrontX)
				and (scrollerY >= (leftPaddleY - paddleHalfHeight)) and (scrollerY <= (leftPaddleY + paddleHalfHeight)))
				or ((scrollerX <= rightPaddleBackX) and (scrollerX >= rightPaddleFrontX)
				and (scrollerY >= (rightPaddleY - paddleHalfHeight)) and (scrollerY <= (rightPaddleY + paddleHalfHeight))) then
				color<="111";
			---red ball
			elsif ((scrollerX >= (ballX - 2)) and (scrollerX <= (ballX + 2)) and (scrollerY >= (ballY - 2))
							and (scrollerY <= (ballY + 2))) then
				color<="100";
			elsif ((scrollerX >= (ballX - 3)) and (scrollerX <= (ballX + 3)) and (scrollerY >= (ballY - 1)) and (scrollerY <= (ballY + 1))) then
				color<="100";
			elsif ((scrollerX >= (ballX - 1)) and ((scrollerX <= (ballX + 1)) and (scrollerY >= (ballY - 1)) and (scrollerY <= (ballY + 1)))) then
				color<="100";
			--lifebars
			--blue scorebars
			elsif ((((scrollerX >= leftLifePosition) and (scrollerX <= (leftLifePosition + leftPaddleSCore*18))) and (scrollerY >= 30 and scrollerY <= (30 + lifeBarHeight))) or (((scrollerX <= rightLifePosition) and (scrollerX >= rightLifePosition - rightPaddleScore*18)) and(scrollerY >= 30 and scrollerY <= 30 + lifeBarHeight))) then
				color<="001";
			--yellow scorebars
			elsif ((((scrollerX >= leftLifePosition + leftPaddleSCore*18) and (scrollerX <= leftLifePosition + maxScore*18)) and (scrollerY >= 30 and scrollerY <= 30 + lifeBarHeight)) or (((scrollerX <= rightLifePosition - rightPaddleScore*18) and(scrollerX >= rightLifePosition - maxScore*18)) and (scrollerY >= 30 and scrollerY <= 30 + lifeBarHeight))) then
				color<="011";		
			--dashed line
			elsif ((scrollerX = 319) and (scrollerY mod 16 <= 10)) then
				color <= "111";
			else
				color <= "000";
			end if;
		else
			color <= "000";
		end if;
	end process colorSetter;
end Behavioral;

