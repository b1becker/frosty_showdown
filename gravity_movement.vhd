library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity gravity_movement is
 generic(
	acceleration : signed(2 downto 0) := 3d"2";
	max_y_velo : signed(2 downto 0) := 3d"4"
 );
 port (
   clk : in std_logic;
   controller : in std_logic_vector(7 downto 0);
   player_y : out signed(10 downto 0)
 );
end gravity_movement;


architecture synth of gravity_movement is

	signal y_velo : signed(2 downto 0);
	signal y_temp : signed(10 downto 0);
	
	signal up_pressed : std_logic;
	
	signal movecounter : unsigned(18 downto 0) := (others => '0');
	
	
	
	
	

begin
	
up_pressed <= not controller(3);
	
	process(clk) begin
		if rising_edge(clk) then
			movecounter <= movecounter + 1;
				if (movecounter = "1110011010110110100") then
					--if(not y_velo >= max_y_velo) then
						--y_velo <= y_velo + acceleration;
					--else
						--y_velo <= y_velo;
					--end if;
					y_temp <= (player_y - 3d"1") mod 400;
				end if;
				movecounter <= "0000000000000000000";
		end if;
	
	end process;
	
	player_y <= y_temp;
end;

