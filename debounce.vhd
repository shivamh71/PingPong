----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:02:20 04/08/2013 
-- Design Name: 
-- Module Name:    debounce - Behavioral 
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

entity debounce is
    Port ( button : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  outputLocked: out STD_LOGIC;
           result : out  STD_LOGIC);
end debounce;


architecture Behavioral of debounce is
	component Dflip_flop is
			Port ( D : in  STD_LOGIC;
				clk : in  STD_LOGIC;
				Q : out  STD_LOGIC);
	end component;

	component  Counter is 
		Port ( clk : in  STD_LOGIC;
				enable : in  STD_LOGIC;
				Sclr : in  STD_LOGIC;
				Cout : out  STD_LOGIC;
				Q : out  STD_LOGIC_VECTOR (5 downto 0));
	end component;

signal Q1:std_logic:='0';	
signal Q2:std_logic:='0';	
signal Sclr:std_logic:='1';
signal cout:std_logic:='0';
signal enable:std_logic:='0';
signal Q :std_logic_vector(5 downto 0):=(others=>'0');
signal ff3Clk:std_logic:='0';
signal res:std_logic:='0';
signal outLcked:std_logic:='0';
begin
	result<=res;
	outputLocked<=outLcked;
	ff1: Dflip_flop port map(button,clk,Q1); -- signal comes here
	ff2: Dflip_flop port map(Q1,clk,Q2);
	Sclr<=Q1 xor Q2;
	enable<= (not cout);
	NbitCounter:Counter port map(clk,enable,Sclr,cout,Q); -- it waits for the counter to overflow..
--	till this time the signal cannot change.
	ff3Clk<= (clk and cout);
	ff4: Dflip_flop port map(cout,clk,outLcked); -- this flip flop is to get signal for the result.
	ff3: Dflip_flop port map(Q2,ff3Clk,res); 	
	
	--now a state diagram to capture the states..
	
end Behavioral;

