----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:03:27 04/08/2013 
-- Design Name: 
-- Module Name:    PaddleMovement - Behavioral 
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PaddleMovement is
    Port ( clk : in  STD_LOGIC;
           up : in  STD_LOGIC;
           down : in  STD_LOGIC;
           paddlePosition : out  integer range 0 to 480;
			  MasterReset : in std_logic);
end PaddleMovement;




architecture Behavioral of PaddleMovement is

component debounce is
    Port ( button : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  outputLocked: out STD_LOGIC;
           result : out  STD_LOGIC);
end component;

signal upButton:std_logic:='0';
signal downButton:std_logic:='0';

signal upLocked:stD_logic:='0';
signal downLocked:stD_logic:='0';

signal upResult:stD_logic:='0';
signal downResult:std_logic:='0';
type state is (S0,S1,S2,S3);
signal upState,downState : state:=S0;
signal upResultBuf:std_logic:='0';
signal downResultBuf:std_logic:='0';
signal position:integer range 0 to 480 :=240;
-- every increment is equal to 10 pixels on the gui
begin
	upDebounce: debounce port map(up,clk,upLocked,upResult);
	downDebounce: debounce port map(down,clk,downLocked,downResult);

	upStateProcess: process (clk,upResult,downResult,MasterReset)
	begin
	if(rising_edge(clk)) then -- we have to ensure that the clock is fast enough to capture most of the changes.
		if(MasterReset='1') then
			position<=240;
		elsif((upResult='1') and (upResultBuf='0')) then
			--this is a rising edge of the clock.
			upResultBuf<=upResult;
			--now we have to update the paddle position
			position<= position + 1;
		elsif((downResult='1') and (downResultBuf='0')) then
			--this is a rising edge of the clock.
			downResultBuf<=downResult;
			--now we have to update the paddle position
			position<= position - 1;
		else -- this is either the falling edge or the signal has not changed.
			upResultBuf<=upResult;
			downResultBuf<=downResult;
		end if;
		paddlePosition<=position;
	end if;
	end process;			
end Behavioral;

