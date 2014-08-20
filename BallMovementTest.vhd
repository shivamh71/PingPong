-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
          COMPONENT ballMovement
          PORT(
               clk : in STD_LOGIC;
					leftPaddleY : IN integer range 0 to 480 ;
					rightPaddleY : IN integer range 0 to 480 ;
					ballX : out integer range 0 to 640 ;
					ballY : out integer range 0 to 480 ;
					leftPaddleScore : out integer range 0 to 15;
					rightPaddleScore : out integer range 0 to 15;
					MasterReset : in std_logic 
                  );
          END COMPONENT;

          SIGNAL clk :  std_logic;
          signal leftPaddleY  :  integer range 0 to 480 := 240 ;
          signal rightPaddleY : integer range 0 to 480 := 240;
			 signal ballX : integer range 0 to 640 ;
			 signal ballY : integer range 0 to 640;
			 signal leftPaddleScore : integer range 0 to 15 ;
			 signal rightPaddleScore : integer range 0 to 15 ;
			signal MasterReset:std_logic:='0';
			 constant clk_period : time :=1 ns;
				
  BEGIN

  -- Component Instantiation
          uut: ballMovement PORT MAP(
                  clk => clk,
                  leftPaddleY => leftPaddleY,
						rightPaddleY => rightPaddleY,
						ballX => ballX,
						ballY => ballY,
						leftPaddleScore =>leftPaddleScore,
						rightPaddleScore => rightPaddleScore,
						MasterReset =>MasterReset
			 );

		clkProcess : Process
		begin
			clk<='1';
			wait for clk_period/2;
			clk<='0';
			wait for clk_period/2;
		end process;
		
  --  Test Bench Statements
    tb : PROCESS
     BEGIN
			--leftPaddleScore<=3;
			--rightPaddleScore<=3;
		  
			--ballx<=320;
			--bally<=400;
			
		  wait for 100 ns; -- wait until global set/reset completes
			
			
        -- Add user defined stimulus here

        wait; -- will wait forever
     END PROCESS tb;
--  --  End Test Bench 

  END;
