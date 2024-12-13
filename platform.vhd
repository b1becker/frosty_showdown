library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PlatformChecker is
    port (
        player_x : in signed(10 downto 0);
        player_y : in signed(10 downto 0);
        platform_x : in signed(10 downto 0);
        platform_y : in signed(10 downto 0);
        platform_width : in signed(10 downto 0);
        platform_height : in signed(10 downto 0);
        is_on_platform : out std_logic
    );
end PlatformChecker;

architecture Behavioral of PlatformChecker is
begin
    process(player_x, player_y, platform_x, platform_y, platform_width, platform_height)
    begin
        if (player_x >= platform_x and player_x <= (platform_x + platform_width)) and
           (player_y = platform_y) then
            is_on_platform <= '1';
        else
            is_on_platform <= '0';
        end if;
    end process;
end Behavioral;