library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity player_movement is
	generic(
		acceleration : signed(2 downto 0) := 3b"1";
		x_velo : signed(4 downto 0) := 5d"00001";
		y_velo : signed(5 downto 0) := 6d"5"
	);
	port (
			player : in std_logic;
			clk : in std_logic;
			p1_controls : in std_logic_vector(7 downto 0);
			player1_x : out signed(10 downto 0);
			player1_y : out signed(10 downto 0);
			inputclk : std_logic;
			reset : in std_logic;
			isplayer1 : in std_logic
		);
end player_movement;


architecture synth of player_movement is
	
	signal reset_input : std_logic := '1';
	
	signal x_temp : signed(10 downto 0);
	signal y_temp : signed(10 downto 0);
	
	-- y jumping vectors
	signal y_initial : signed(10 downto 0);
	signal is_jumping : std_logic;
	signal going_down : std_logic;
	
	
	signal p1_left_pressed : std_logic;
	signal p1_right_pressed : std_logic;
	
	signal p1_up_pressed : std_logic;
	signal p1_down_pressed : std_logic;
	

	signal max_speed_x_left : std_logic;
	signal max_speed_x_right : std_logic;
	signal max_spped_y : std_logic;
	
	signal movecounter : unsigned(18 downto 0) := (others => '0');
	signal setpos : std_logic := '0';

begin
	
	
	--Player 1 assigning signals to the respective buttons
	p1_left_pressed <= not p1_controls(0) ;
	p1_right_pressed <= not p1_controls(1) ;
	p1_down_pressed <= not p1_controls(2);
	p1_up_pressed <= not p1_controls(3);
	
	reset_input <= reset;

	process(clk)
begin
    if rising_edge(clk) then
		if (reset) then
			if(isplayer1) then
				x_temp <= 11d"120";
				y_temp <= 11d"385";
			else
				x_temp <= 11d"520";
				y_temp <= 11d"385";
			end if;	
		elsif(is_jumping) then
			movecounter <= movecounter + 1;
			if (movecounter = "1110011010110110100") then
				y_temp <= (player1_y - y_velo) mod 480;
				if(y_temp < y_initial - 11d"125") then
					is_jumping <= '0';
					going_down <= '1';
				elsif (p1_right_pressed) then
                    x_temp <= (player1_x - x_velo) mod 640;
                    if x_temp < 11d"1" then
                        x_temp <= 11d"1";
                    end if;
                elsif (p1_left_pressed) then
                    x_temp <= (player1_x + x_velo) mod 640;
					if x_temp > 11d"599" then
                        x_temp <= 11d"599";
                    end if;
				end if;
			end if;
		elsif(going_down) then
			movecounter <= movecounter + 1;
			if (movecounter = "1110011010110110100") then
				y_temp <= (player1_y + y_velo) mod 480;
				if(y_temp > y_initial - 11d"7") then
					is_jumping <= '0';
					going_down <= '0';
				elsif (p1_right_pressed) then
                    x_temp <= (player1_x - x_velo) mod 640;
                    if x_temp < 11d"1" then
                        x_temp <= 11d"1";
                    end if;
                elsif (p1_left_pressed) then
                    x_temp <= (player1_x + x_velo) mod 640;
					if x_temp > 11d"599" then
                        x_temp <= 11d"599";
                    end if;
				end if;
			end if;
		elsif (p1_left_pressed or p1_right_pressed or p1_up_pressed or p1_down_pressed) then
            movecounter <= movecounter + 1;
            if (movecounter = "1110011010110110100") then
                -- x constraints
                if (p1_right_pressed) then
                    x_temp <= (player1_x - x_velo) mod 640;
                    if x_temp < 11d"1" then
                        x_temp <= 11d"1";
                    end if;
                elsif (p1_left_pressed) then
                    x_temp <= (player1_x + x_velo) mod 640;
					if x_temp > 11d"599" then
                        x_temp <= 11d"599";
                    end if;
                end if;
                -- y constraints
                if (p1_up_pressed) then
					is_jumping <= '1';
					going_down <= '0';
					y_initial <= y_temp;
                    if y_temp < 11d"5" then
                        y_temp <= 11d"5";
                    end if;
                end if;
			if y_temp > 11d"385" then 
				y_temp <= 11d"385";
			end if;
                movecounter <= "0000000000000000000";
            end if;
        end if;
		end if;
end process;

player1_x <= x_temp; --when setpos = '1' else 11d"50";
player1_y <= y_temp; --when setpos = '1' else 11d"385";

end;
