library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity display_logic is
	port(
		clk : in std_logic;
		--Player 1 Data:
            p1_data_in : in std_logic;
			p1_latch : out std_logic;
			p1_clk : out std_logic;
--				p1 : out std_logic_vector(7 downto 0);
			--Player 2 Data:
			p2_data_in : in std_logic;
			p2_clk : out std_logic;
			p2_latch : out std_logic;
--				p2 : out std_logic_vector(7 downto 0)
		-- TO DO: add in player positions
			start_display : out std_logic;
			game_display : out std_logic
	
	);
end display_logic;	

--architecture Behavioral of display_logic is

--end Behavioral;
