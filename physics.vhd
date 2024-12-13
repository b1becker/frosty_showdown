library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity physics is
	generic(
		acceleration : signed (2 downto 0) := 3d"1"
	);
    port(
		clk : in std_logic;
		p1_controls : in std_logic_vector(7 downto 0);
		x_pos : out signed(10 downto 0);
		y_pos : out signed(10 downto 0)
    );

    -- States of The Game --
   
end physics;


architecture synth of physics is
	signal x_velo : signed(5 downto 0) := 6d"0";
	signal y_velo : signed(4 downto 0) := 5d"0";
	signal reset : std_logic;
	
	signal left_pressed : std_logic;
	signal right_pressed : std_logic;
	
	signal max_speed_x_left : std_logic;
	signal max_speed_x_right : std_logic;
	signal max_spped_y : std_logic;


begin

	process (clk) begin
		if rising_edge(clk) then
		
		end if;
	end process;
	left_pressed <= p1_controls(0);
	right_pressed <= p1_controls(0);

end;