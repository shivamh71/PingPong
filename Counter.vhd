----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:36:59 04/08/2013 
-- Design Name: 
-- Module Name:    Counter - Behavioral 
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

entity Counter is
	generic (N:integer :=5);
	Port ( clk : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           Sclr : in  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (N downto 0));
end Counter;

architecture Behavioral of Counter is

signal count :std_logic_vector(N downto 0):=(others=>'0');
signal bound: std_logic_vector(N downto 0):=(others=>'1');
signal carry: std_logic:='0';
begin
	process(clk) 
		begin
			if(Sclr='1') then 
				count<=(others=>'0');
				Q<=count;
				Cout<='0';
				carry<='0';
			elsif(rising_edge(clk) and (enable='1')) then
				count<=count+1;
				Q<=count;
				if(count = bound) then
					carry<='1';
				else
					carry<='0';
				end if;
			end if;
			Cout<=carry;
		end process;
end Behavioral;


