library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
	 port(
			--VGA Stuff:
				ref_clk_i: in std_logic;
				rst_n_i: in std_logic;
				pll_out_pin : out std_logic;
				HSYNC : out std_logic;
				VSYNC : out std_logic;
				rgb : out std_logic_vector(5 downto 0);

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
			--State Machine Testing:
				Welcome_state : out std_logic;
				Main_Game : out std_logic;
				Exit_Screen : out std_logic;
				P1 : out std_logic;
				P2: out std_logic;
			--Testing:
				controls : out std_logic_vector( 7 downto 0);
				test : out std_logic
        );
end top;

architecture behavior of top is

	--------------------- COMPONENT DECLARATION ---------------------


	component nes is
	  port(
		data_in : in std_logic;
		latch : out std_logic;
		controller_clk : out std_logic;
		data_out : out std_logic_vector(7 downto 0);
		clk : in std_logic
	  );
	end component;
	component mypll is
		port(
		ref_clk_i: in std_logic; -- Input clock
		rst_n_i: in std_logic; -- Reset (active low)
		outcore_o: out std_logic; -- Output to pins
		outglobal_o: out std_logic -- Output for clock network
	);
	end component;
	component vga is
		port(
        clk : in std_logic;
        HSYNC : out std_logic;
        VSYNC : out std_logic;
        row : out unsigned(10 downto 0);
        col : out unsigned(10 downto 0);
        valid : out std_logic
      );
	end component;
	
	component patterngen is
		port (
		mainTrigger : in std_logic;
		exitTrigger : in std_logic;
		p1winTrigger : in std_logic;
		p2winTrigger : in std_logic;
		
		row : in unsigned(10 downto 0);
		col : in unsigned(10 downto 0);
		valid: in std_logic;         -- High during active video display
		rgb: out std_logic_vector(5 downto 0) ;
		clk : in std_logic;
		
		player1_x : in signed(10 downto 0);
		player1_y : in signed(10 downto 0);
		player2_x : in signed(10 downto 0);
    	player2_y : in signed(10 downto 0);
		
		snowballone_x : in signed(10 downto 0);
		snowballone_y : in signed(10 downto 0);
		snowballtwo_x : in signed(10 downto 0);
		snowballtwo_y: in signed(10 downto 0)
		);
	end component;
	
	component player_movement is
		port (
			player : in std_logic;
			clk : in std_logic;
			p1_controls : in std_logic_vector(7 downto 0);
			player1_x : out signed(10 downto 0);
			player1_y : out signed(10 downto 0);
			reset : in std_logic;
			isplayer1 : in std_logic
		);
	end component;
	
	component snowball_movement is
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
	end component;
	
	

	--------------------- SIGNAL DECLARATION -----------------------
	
	signal p1_controls : std_logic_vector(7 downto 0);
	signal p2_controls : std_logic_vector(7 downto 0);
	--VGA signals:
	signal clk : std_logic;
	signal valid : std_logic;
	signal col : unsigned(10 downto 0) := (others => '0');
	signal row : unsigned(10 downto 0) := (others => '0');
	--Game State Machine Signals:
	type State is (WELCOME,MAINGAME,EXITSCREEN,P1WIN,P2WIN,RESET);
	signal current_state : State := (WELCOME);
	signal gameWon : std_logic := ('0');
	signal Welc : std_logic;
	signal Main : std_logic;
	signal ExitG : std_logic;
	signal PL1 : std_logic;
	signal PL2 : std_logic;

	signal p1_start : std_logic;
	signal p2_start : std_logic;
	signal start : std_logic;
	signal statebuffer : std_logic := '0';
	signal statecounter : unsigned(24 downto 0) := (others => '0');
	signal p1_blockcounter : unsigned(24 downto 0) := (others => '0');
	signal p1_block : std_logic;
	signal p2_blockcounter : unsigned(24 downto 0) := (others => '0');
	signal p2_block : std_logic;
	--Player Signals:
	signal p1_hit : std_logic := ('0');
	signal p2_hit : std_logic := ('0');

	-- cordinates
	
	signal p1_xpos : signed(10 downto 0) := 11d"400";
	signal p1_ypos : signed(10 downto 0) := 11d"400";
	
	signal ballone_x : signed(10 downto 0) := 11d"0";
	signal ballone_y : signed(10 downto 0) := 11d"0";

	signal p2_xpos : signed(10 downto 0) := 11d"0";
	signal p2_ypos : signed(10 downto 0) := 11d"0";

	signal balltwo_x : signed(10 downto 0) := 11d"0";
	signal balltwo_y : signed(10 downto 0) := 11d"0";

	signal state_enter : std_logic;
	
	signal reset_input : std_logic;
	signal collision : std_logic;
	signal coll2 : std_logic;
	--------------------------- BEGIN ------------------------------
	begin
		-- Instantiate the PLL
		
	player1 : nes
			port map (
				data_in => p1_data_in,
				latch => p1_latch,
				controller_clk => p1_clk,
				data_out => p1_controls,
				clk => clk
			);
	player2 : nes
			port map (
				data_in => p2_data_in,
				latch => p2_latch,
				controller_clk => p2_clk,
				data_out => p2_controls,
				clk => clk
			);

	--VGA Stuff:
	mypll_instance : mypll
		port map (
			ref_clk_i => ref_clk_i,
			rst_n_i => '1',
			outcore_o => pll_out_pin,
			outglobal_o => clk
		);
	-- Instantiate the VGA
	vga_instance : vga
	port map (
		clk => clk,
		HSYNC => HSYNC,
		VSYNC => VSYNC,
		valid => valid,
		col => col,
		row => row
	);

	-- Instantiate the Pattern Gen
	patterngen_instance : patterngen
	port map (
		mainTrigger => main,
		exitTrigger => exitg,
		p1winTrigger => PL1,
		p2winTrigger => PL2,
		col => col,
		row => row,
		valid => valid,
		rgb => rgb,
		clk => clk,
		player1_x => p1_xpos,
		player1_y => p1_ypos,
		player2_x => p2_xpos,
		player2_y => p2_ypos,
		snowballone_x => ballone_x,
		snowballone_y => ballone_y,
		snowballtwo_x => balltwo_x,
		snowballtwo_y => balltwo_y
	);
	
	player1_inst : player_movement
	port map (
		player => '1',
		clk => clk,
		p1_controls => p1_controls,
		player1_x => p1_xpos,
		player1_y => p1_ypos,
		reset => reset_input,
		isplayer1 => '1'
	);

	player2_inst : player_movement
	port map (		
		player => '0',
		clk => clk,
		p1_controls => p2_controls,
		player1_x => p2_xpos,
		player1_y => p2_ypos,
		reset => reset_input,
		isplayer1 => '0'
	);
	
	snowball_p1_inst : snowball_movement
	port map (
		clk => clk,
		controls => p1_controls,
		player_x => p1_xpos,
		player_y => p1_ypos,
		snowball_x => ballone_x,
		snowball_y => ballone_y,
		player => '1',
		collision => collision,
		game => main
	);
	
	snowball_p2_inst : snowball_movement
	port map (
		clk => clk,
		controls => p2_controls,
	    player_x => p2_xpos,
	    player_y => p2_ypos,
	    snowball_x => balltwo_x,
	    snowball_y => balltwo_y,
		player => '0',
		collision => collision,
		game => main
	);


	--Game State Machine:
	
	p1_start <= not p1_controls(4);
	p2_start <= not p2_controls(4);
	start <= '1' when (p1_start = '1' or p2_start = '1' ) and statebuffer = '1' else '0';
	coll2 <= collision;
	process (clk)
	begin
		if rising_edge(clk) then
			p1_blockcounter <= p1_blockcounter +1;
			p2_blockcounter <= p2_blockcounter +1;

			if(p1_blockcounter = "1100000001000010110000000") then
				p1_block <= not p1_controls(6);
				p1_blockcounter <=  "0000000000000000000000000";
			end if;
			if(p2_blockcounter = "1100000001000010110000000") then
				p2_block <= not p2_controls(6);
				p2_blockcounter <=  "0000000000000000000000000";
			end if;
			
			
			if(p1_start or p2_start) then
				statecounter <= statecounter + 1;
			end if;
			
			if (statecounter = "1100000001000010110000000") then
				statebuffer <= '1';
				statecounter <= "0000000000000000000000000";
			else
				statebuffer <= '0';
			end if;

			--Snowball Collisions:
			if(p1_xpos - 11d"5" < balltwo_x and p1_xpos + 11d"45" > balltwo_x +11d"16") then
				if(p1_ypos - 11d"5" < balltwo_y and p1_ypos + 11d"80" > balltwo_y +11d"16") then
					if (not p1_block) then 
						P1_hit <= '1';
					end if;
				end if;
			end if;
			if(p2_xpos - 11d"5" < ballone_x and p2_xpos + 11d"45" > ballone_x +11d"16") then
				if(p2_ypos - 11d"5" < ballone_y and p2_ypos + 11d"80" > ballone_y +11d"16") then
					if (not p2_block) then 
						P2_hit <= '1';
					end if;
				end if;
			end if;
		
			case current_state is
			when WELCOME =>
                   welc <= '1';
                   main <= '0';
                   exitg <= '0';
                   PL1 <= '0';
                   Pl2 <= '0';
				   P1_hit <= '0';
				   P2_hit <= '0';
				   reset_input <= '1';
					if(start = '1') then
						current_state <= MAINGAME;
					end if;
				when MAINGAME =>
					reset_input <= '0';
					welc <= '0';
					main <= '1';
					exitg <= '0';
					PL1 <= '0';
					Pl2 <= '0';
					if p1_hit = '1' then
						current_state <= P1WIN;
					elsif p2_hit = '1' then
						current_state <= P2WIN;
					end if;
				when EXITSCREEN =>
					welc <= '0';
					main <= '0';
					exitg <= '1';
					PL1 <= '0';
					Pl2 <= '0';
					if(start = '1') then
						current_state <= RESET;
						reset_input <= '1';
					end if;
				when P1WIN =>
					welc <= '0';
					main <= '0';
					exitg <= '0';
					PL1 <= '1';
					Pl2 <= '0';
					if(start = '1') then
                    	current_state <= EXITSCREEN;
                	end if;
				when P2WIN =>
					welc <= '0';
					main <= '0';
					exitg <= '0';
					PL1 <= '0';
					Pl2 <= '1';
					if(start = '1') then
                    	current_state <= EXITSCREEN;
                	end if;
				when RESET =>
					P1_hit <= '0';
					P2_hit <= '0';
					reset_input <= '1';
					current_state <= WELCOME;
				when others => current_state <= WELCOME;
			end case;
	end if;
	end process;
	Welcome_state <= welc;
	Main_Game <= main;
	Exit_Screen <= exitg;
	test <= p1_start;
	controls <= p1_controls;
end;

