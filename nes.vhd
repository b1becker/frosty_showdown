library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity nes is
 port (
   data_in : in std_logic;
   latch : out std_logic;
   controller_clk : out std_logic;
   data_out : out std_logic_vector(7 downto 0);
   clk : in std_logic
 );
end nes;


architecture arch of nes is


signal counter : unsigned(20 downto 0) := (others => '0'); --makes all 0 at beginning
signal NESclk : std_logic;
signal NEScounter : unsigned(7 downto 0);
signal data_shift : std_logic_vector(7 downto 0);
signal data_hold :  std_logic_vector(7 downto 0);
signal clk_count : unsigned(2 downto 0);
begin
  


process (clk) is
   begin
       if (rising_edge(clk)) then
           if(counter = 1_199_999) then
               counter <= (others => '0'); --reset counter
           else
               counter <= counter + 1;
           end if;
       end if;
end process;

NESclk <= counter(7); --NESclk is the 10th bit

NEScounter <= counter(15 downto 8); -- use this as it will give us the desired frequency
latch <= '1' when (NEScounter = 8d"255") else '0';

controller_clk <= NESclk when NEScounter < 8d"8" else '0';

process (NESclk) is
begin
    if rising_edge(NESclk) then
        if (NEScounter < "00001000") then
            data_shift <= data_shift(6 downto 0) & data_in;
            if (clk_count < "111") then
                clk_count <= clk_count + 1;
            end if;
        end if;
    end if;
end process;
       data_hold <= data_shift when clk_count = "111";
       data_out <= data_hold;


end;

