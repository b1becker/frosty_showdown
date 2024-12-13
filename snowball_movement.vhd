library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity snowball_movement is
	generic (
		x_velo : signed(5 downto 0) := 6d"5"
	);
	port(
		  clk : in std_logic;
		  controls : in std_logic_vector(7 downto 0);
		  player_x : in signed(10 downto 0);
		  player_y : in signed(10 downto 0);
		  snowball_x : out signed(10 downto 0);
		  snowball_y : out signed(10 downto 0);
		  player : in std_logic;
		  collision : in std_logic;
		  game : in std_logic
	);
end snowball_movement;


architecture synth of snowball_movement is

signal a_btn_pressed : std_logic;
signal move_snowball : std_logic;

signal movement_counter : unsigned(18 downto 0) := (others => '0');
signal snowtime : unsigned(23 downto 0) := (others => '1');
signal x_temp : signed(10 downto 0);
signal y_temp : signed(10 downto 0);

begin

a_btn_pressed <= not controls(7);

process(clk)
begin
    if rising_edge(clk) then
		if collision = '1' then 
			snowball_x <= 11d"0"; -- Clamp at left boundary
				snowball_y <= 11d"700";
		elsif movement_counter = "1110011010110110100" then
            movement_counter <= "0000000000000000000";
            
            if a_btn_pressed = '1' then
                snowtime <= 24d"0";
                if player = '1' then
                    snowball_y <= player_y;
                    snowball_x <= player_x;
                else
                    snowball_y <= player_y;
                    snowball_x <= player_x + 11d"22";
                end if;
                
            elsif snowtime < "110000000100001011000000" then
                snowtime <= snowtime + 1;
                
                if player = '1' then
                    snowball_x <= snowball_x + x_velo;
                else
                    if snowball_x > x_velo then
                        snowball_x <= snowball_x - x_velo;
                    else
                        snowball_x <= 11d"0"; -- Clamp at left boundary
						snowball_y <= 11d"700";
                    end if;
                end if;
            end if;
        else
            movement_counter <= movement_counter + 1;
            
            if player = '1' then
                if snowball_x > 11d"640" then
                    snowball_y <= 11d"700";
                end if;
            else
                if snowball_x < 11d"0" then
                    snowball_y <= 11d"700";
                end if;
            end if;
        end if;
    end if;
end process;

end;