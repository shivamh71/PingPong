----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:56:16 04/11/2013 
-- Design Name: 
-- Module Name:    Pong - Behavioral 
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

entity Pong is
	Port(clk100Mhz: in std_logic;
		 upLeft: in Std_logic;
		 downLeft: in std_logic;
		 upRight: in std_logic;
		downRight: in std_logic;
		MasterReset : in std_logic;
		Start: in std_logic);
end Pong;
-- we have generate clocks for paddle, ballUpdate 
architecture Behavioral of Pong is
	
	component clk_wiz_v3_6 is 
		Port(-- Clock in ports
			CLK_IN1           : in     std_logic;
			-- Clock out ports
			CLK_OUT1          : out    std_logic;
			-- Status and control signals
			RESET             : in     std_logic;
			LOCKED            : out    std_logic);
		end component;
		
		component Paddle is 
		Port(clk : in  STD_LOGIC;
           upLeft : in  STD_LOGIC;
           downLeft : in  STD_LOGIC;
           upRight : in  STD_LOGIC;
           downRight : in  STD_LOGIC;
           paddleRightPosition : out  integer range 0 to 480;
           paddleLeftPosition : out  integer range 0 to 480;
			  MasterReset : in Std_logic);
		end component;
		
		component ballMovement is
		Port (clk : in STD_LOGIC;
				leftPaddleY : IN integer range 0 to 480 ;
				rightPaddleY : IN integer range 0 to 480;
				ballX : out integer range 0 to 640 ;
				ballY : out integer range 0 to 480 ;
				leftPaddleScore : out integer range 0 to 15;
				rightPaddleScore : out integer range 0 to 15;
				MasterReset: in std_logic);
			end component;
			
		component rgb is 
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
		end component;
	signal clk5mhz:std_logic; -- get from the core gen
	signal Clk1khz:std_logic; -- for paddle movement 
	signal Clk100khz:std_logic;  -- for ball movement
	signal clk25khz: std_logic; -- clk for the display
	signal clk50khz: std_logic;
	
	signal leftPaddleY : integer range 0 to 480;
	signal rightPaddleY: integer range 0 to 480;
	signal ballX :integer range 0 to 640;
	signal ballY: integer range 0 to 480;
	signal leftPaddleScore: integer range 0 to 15;
	signal rightPaddleScore: integer range 0 to 15;
	signal Clk1khzCounter: integer range 0 to 5000 :=0;
	signal Clk25khzCounter: integer range 0 to 200 :=0;
	signal Clk50khzCounter: integer range 0 to 100 :=0;
	signal Clk100khzCounter: integer range 0 to 50:=0;
	signal clk100mhzReset : std_logic:='0';
	signal Locked: std_logic;
	signal StartTheGame: std_logic;
	signal color: stD_logic_vector(2 downto 0):="000";
	signal ScrollerX : integer  range 0 to 640:=0;
	signal ScrollerY: integer  range 0 to 480:=0;
	signal GameOver: std_logic:='0';
	signal masterResetsig: std_logic:='0';
begin

	clk5Module : clk_wiz_v3_6  port map(clk100mhz,clk5mhz,clk100mhzReset,Locked);
	ballMovementModule : ballMovement port map(Clk100khz,leftPaddleY,rightPaddleY,ballX,ballY,leftPaddleScore,rightPaddleScore,MasterResetsig);
	paddleModule : paddle port map(Clk1khz,upLeft,downLeft,upRight,downRight,leftPaddleY,rightPaddleY,MasterResetsig);
	rgbModule: rgb port map(clk50khz,leftPaddleY,rightPaddleY,ballX,ballY,leftPaddleScore,rightPaddleScore,ScrollerX,ScrollerY,Gameover,color);
	clk1khzProcess: Process(clk100Mhz) -- process to start the clock for paddle movement.
	
	begin
		if(rising_edge(clk100Mhz)) then 
			if(clk1khzCounter=2499) then
				clk1khz<='1';
			elsif(clk1khzCounter=4999) then
				clk1khz<='0';
			end if;
			clk1khzCounter<=clk1khzCounter+1;
		end if;
	end process;
	
	startGameProcess: Process(clk100Mhz)
	begin
		if(rising_edge(clk100Mhz) and start='1') then
			startTheGame<='1';
		end if;
	end process;
	
	GameProcess: process(clk100mHz) 
	begin 
		if(leftPaddleScore=15) then
			Gameover <='1';
			masterResetsig<='1';
			startTheGame<='0';
		elsif(rightPaddleScore=15) then
			Gameover <='1';
			masterResetSig<='1';
			startTheGame<='0';
		else
			Gameover <='0';
		end if;
	end process;
	
	resetProcess: Process(masterReset) 
	begin
		masterResetsig<=masterReset;
	end process;
	
	pauseProcess: Process(clk100Mhz) -- this process will stop the game when score of one of the 
	variable leftPaddleScoreBuffer: integer range 0 to 15:=0;
	variable rightPaddleScoreBuffer: integer range 0 to 15:=0;
	begin
		if(not(leftPaddleScoreBuffer = leftPaddleScore)) then
			startTheGame<='0';
			leftPaddleScoreBuffer:=leftPaddleScore;
		elsif(not(rightPaddleScoreBuffer = rightPaddleScore)) then
			startTheGame<='0';
			rightPaddleScoreBuffer:=rightPaddleScore;
		end if;
	end process;	
		
	clk100khzProcess: Process(clk100Mhz) -- process to generate clock for the ball movement
	begin
		if(rising_edge(clk100Mhz)) then 
			if(clk100khzCounter=24) then
				clk100khz<='1' and startTheGame ;
			elsif(clk1khzCounter=49) then
				clk100khz<='0';
			end if;
			clk100khzCounter<=clk100khzCounter+1;
		end if;
	end process;
	
--	masterResetProcess :process(masterReset,clk100mhz)
--		if(rising_edge(clk) and masterReset='1') then
--			
--		end if;
--	
end Behavioral;

