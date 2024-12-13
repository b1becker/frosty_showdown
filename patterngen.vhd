library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;




entity patterngen is
    port(
    mainTrigger : in std_logic;
    exitTrigger : in std_logic;
    p1winTrigger : in std_logic;
	p2winTrigger : in std_logic;
	
    row : in unsigned(10 downto 0);
    col : in unsigned(10 downto 0);
    valid: in std_logic;         
    rgb: out std_logic_vector(5 downto 0);
    clk : in std_logic;

    player1_x : in signed(10 downto 0);
    player1_y : in signed(10 downto 0);
    player2_x : in signed(10 downto 0);
    player2_y : in signed(10 downto 0);
   
    -- Snowball Coords --
    snowballone_x : in signed(10 downto 0);
    snowballone_y : in signed(10 downto 0);
    snowballtwo_x : in signed(10 downto 0);
    snowballtwo_y: in signed(10 downto 0)
    );
 
end patterngen;


architecture Behavioral of patterngen is

-- Intermediate Signal of the Display Coordinates --
signal row_vector : std_logic_vector(10 downto 0);
signal col_vector : std_logic_vector(10 downto 0);

-- State Signals --
signal background : std_logic_vector(5 downto 0);
signal welcome : std_logic_vector(5 downto 0);
signal exitscreen : std_logic_vector(5 downto 0);
signal p1win : std_logic_vector(5 downto 0);
signal p2win : std_logic_vector(5 downto 0);

-- Snowball Logic --
signal snowball1_pink : std_logic;
signal snowball2_pink : std_logic;

signal snowball_1 : std_logic_vector(5 downto 0);
signal p1_snowballx : unsigned (10 downto 0);
signal p1_snowbally : unsigned (10 downto 0);

signal snowball_2 : std_logic_vector(5 downto 0);
signal p2_snowballx : unsigned (10 downto 0);
signal p2_snowbally : unsigned (10 downto 0);

signal drawing_p1_snowballx : std_logic;
signal drawing_p1_snowbally : std_logic;

signal drawing_p2_snowballx : std_logic;
signal drawing_p2_snowbally : std_logic;

-- Player 1 Signal Logic --
signal player1 : std_logic_vector(5 downto 0);
signal player1_pink : std_logic;
signal p1_snowmanX : unsigned (10 downto 0);
signal p1_snowmanY : unsigned (10 downto 0);
signal drawing_player1_x : std_logic;
signal drawing_player1_y : std_logic;

-- Player 2 Signal Logic --
signal player2 : std_logic_vector(5 downto 0);
signal player2_pink : std_logic;
signal p2_snowmanX : unsigned (10 downto 0);
signal p2_snowmanY : unsigned (10 downto 0);
signal drawing_player2_x : std_logic;
signal drawing_player2_y : std_logic;

--signal p_width : std_logic_vector(5 downto 0);
--signal p_height : std_logic_vector(6 downto 0);

---------------------------- COMPONENT DECLARATION -----------------------------
component welcome_rom is
    port(
        clk : in std_logic;
        x_cord: in unsigned(6 downto 0);
        y_cord : in unsigned(5 downto 0); -- 0-1023
        rgb : out std_logic_vector(5 downto 0)
    );
end component;

component background_rom is
    port(
        clk : in std_logic;
        x_cord: in unsigned(6 downto 0);
        y_cord : in unsigned(5 downto 0);
        rgb : out std_logic_vector(5 downto 0)
    );
end component;

component exit_rom is
    port(
        clk : in std_logic;
        x_cord: in unsigned(5 downto 0);
        y_cord : in unsigned(4 downto 0);
        rgb : out std_logic_vector(5 downto 0)
    );
end component;

component p1win_rom is
    port(
        clk : in std_logic;
        x_cord: in unsigned(5 downto 0);
        y_cord : in unsigned(4 downto 0);
        rgb : out std_logic_vector(5 downto 0)
    );
end component;

component p2win_rom is
    port(
        clk : in std_logic;
        x_cord: in unsigned(5 downto 0);
        y_cord : in unsigned(4 downto 0);
        rgb : out std_logic_vector(5 downto 0)
    );
end component;

component player1_rom is
    port(
        clk : in std_logic;
        x_cord : in unsigned(5 downto 0);
        y_cord : in unsigned(6 downto 0);
        rgb : out std_logic_vector(5 downto 0)
    );
end component;

component player2_rom is
    port(
        clk : in std_logic;
        x_cord: in unsigned(5 downto 0);
        y_cord : in unsigned(6 downto 0); -- 0-1023
        rgb : out std_logic_vector(5 downto 0)
    );
end component;

component snowball_rom is
    port(
        clk : in std_logic;
        x_cord : in unsigned(3 downto 0);
        y_cord : in unsigned(3 downto 0);
        rgb : out std_logic_vector(5 downto 0)
    );
end component;


component snowball2_rom is
    port(
        clk : in std_logic;
        x_cord : in unsigned(3 downto 0);
        y_cord : in unsigned(3 downto 0);
        rgb : out std_logic_vector(5 downto 0)
    );
end component;


---------------------------- PORT MAP DECLARATION ------------------------------

begin

-- Detect the background the snowman/snowball is not using
player1_pink <= '1' when (player1 = "100001") else '0';
player2_pink <= '1' when (player2 = "100001") else '0';
snowball1_pink <= '1' when (snowball_1 = "010010") else '0';
snowball2_pink <= '1' when (snowball_2 = "010010") else '0';

-- Pass Coordinates of row and col to intermediate signals
row_vector <= std_logic_vector(row);
col_vector <= std_logic_vector(col);

welcome_rom_map : welcome_rom port map (
    clk => clk,
    x_cord => unsigned(col_vector(9 downto 3)),
    y_cord => unsigned(row_vector(8 downto 3)),
    rgb => welcome
);

background_rom_map : background_rom port map (
    clk => clk,
    x_cord => unsigned(col_vector(9 downto 3)),
    y_cord => unsigned(row_vector(8 downto 3)),
    rgb => background
);

exit_rom_map : exit_rom port map (
    clk => clk,
    x_cord => unsigned(col_vector(9 downto 4)),
    y_cord => unsigned(row_vector(8 downto 4)),
    rgb => exitscreen
);
p1win_rom_map : p2win_rom port map (
    clk => clk,
    x_cord => unsigned(col_vector(9 downto 4)),
    y_cord => unsigned(row_vector(8 downto 4)),
    rgb => p1win
);
p2win_rom_map : p1win_rom port map (
    clk => clk,
    x_cord => unsigned(col_vector(9 downto 4)),
    y_cord => unsigned(row_vector(8 downto 4)),
    rgb => p2win
);

player1_rom_map : player1_rom port map (
    clk => clk,
    x_cord => p1_snowmanX(5 downto 0),
    y_cord => p1_snowmanY(6 downto 0),
    rgb => player1
);

player2_rom_map : player2_rom port map (
    clk => clk,
    x_cord => p2_snowmanX(5 downto 0),
    y_cord => p2_snowmanY(6 downto 0),
    rgb => player2
);

snowball_rom_map : snowball_rom port map (
    clk => clk,
    x_cord => p1_snowballx(4 downto 1),
    y_cord => p1_snowbally(4 downto 1),
	rgb => snowball_1
);

snowball2_rom_map : snowball2_rom port map (
    clk => clk,
    x_cord => p2_snowballx(4 downto 1),
    y_cord => p2_snowbally(4 downto 1),
	rgb => snowball_2
);
	
    drawing_player1_x <= '1' when ((signed(col) >= player1_x) and signed(col) <= (player1_x + 11d"40")) else '0';
    drawing_player1_y <= '1' when ((signed(row) >= player1_y) and signed(row) <= (player1_y + 11d"70")) else '0';
   
    drawing_player2_x <= '1' when ((signed(col) >= player2_x) and signed(col) <= (player2_x + 11d"40")) else '0';
    drawing_player2_y <= '1' when ((signed(row) >= player2_y) and signed(row) <= (player2_y + 11d"70")) else '0';
   
    drawing_p1_snowballx <= '1' when ((signed(col) >= snowballone_x) and signed(col) <= (snowballone_x + 11d"30")) else '0';
    drawing_p1_snowbally <= '1' when ((signed(row) >= snowballone_y) and signed(row) <= (snowballone_y + 11d"30")) else '0';
   
    drawing_p2_snowballx <= '1' when ((signed(col) >= snowballtwo_x) and signed(col) <= (snowballtwo_x + 11d"30")) else '0';
    drawing_p2_snowbally <= '1' when ((signed(row) >= snowballtwo_y) and signed(row) <= (snowballtwo_y + 11d"30")) else '0';
   
    --p_width <= 6d"25"; --40 is real
    --p_height <= 7d"63"; --75 is the actual height
 
    -- this sets the cordinates for player1snowmanx and player2snowmanx for the rgb to map them

    p1_snowmanX <= col - unsigned(player1_x);
    p1_snowmanY <= row - unsigned(player1_y);
   
    p2_snowmanX <= col - unsigned(player2_x);
    p2_snowmanY <= row - unsigned(player2_y);

    p1_snowballx <= col - unsigned(snowballone_x);
    p1_snowbally <= row - unsigned(snowballone_y);
	
    p2_snowballx <= col - unsigned(snowballtwo_x);
    p2_snowbally <= row - unsigned(snowballtwo_y);
	


    rgb <=
    player1 when (valid = '1' and drawing_player1_x = '1' and drawing_player1_y = '1' and mainTrigger = '1' and player1_pink = '0')
    else player2 when (valid = '1' and drawing_player2_x = '1' and drawing_player2_y = '1' and mainTrigger = '1' and player2_pink = '0')
    else snowball_1 when (valid = '1' and drawing_p1_snowballx = '1' and drawing_p1_snowbally = '1' and snowball1_pink = '0' and mainTrigger = '1')
    else snowball_2 when (valid = '1' and drawing_p2_snowballx = '1' and drawing_p2_snowbally = '1' and snowball2_pink = '0' and mainTrigger = '1')
    else background when (valid = '1' and mainTrigger = '1')
	else p1win when (valid = '1' and p1winTrigger = '1')
	else p2win when (valid = '1' and p2winTrigger = '1')
    else exitscreen when (valid = '1' and exitTrigger = '1' and mainTrigger = '0')
    else welcome when (valid = '1')
    else "000000";

end Behavioral;

