library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga is
    port(
        clk : in std_logic;
        HSYNC : out std_logic;
        VSYNC : out std_logic;
        row : out unsigned(10 downto 0);
        col : out unsigned(10 downto 0);
        valid : out std_logic
    );
end vga;

architecture synth of vga is

    signal col_reg : unsigned(10 downto 0);
    signal row_reg : unsigned(10 downto 0);

begin
    process (clk)
    begin
        if rising_edge(clk) then
            if col_reg = 11d"799" then
                col_reg <=  11d"0";
                if row_reg = 11d"524" then
                    row_reg <=  11d"0";
                else
                    row_reg <= row_reg + 1;
                end if;
            else
                col_reg <= col_reg + 1;
            end if;
        end if;
    end process;

    col <= col_reg;
    row <= row_reg;

    HSYNC <= '0' when (col_reg >= 656 and col_reg <= 751) else '1';
    VSYNC <= '0' when (row_reg >= 490 and row_reg <= 491) else '1';
    valid <= '1' when (col_reg <= 639 and row_reg <= 479) else '0';
end synth;
