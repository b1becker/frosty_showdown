library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity snowball2_rom is
  port(
	  clk : in std_logic;
	  x_cord: in unsigned(3 downto 0); -- 0 - 15
	  y_cord : in unsigned(3 downto 0); -- 0 - 15
	  rgb : out std_logic_vector(5 downto 0)
      );
end snowball2_rom;

architecture synth of snowball2_rom is
signal totaladr : std_logic_vector(7 downto 0);
begin
   process (clk) begin
	if rising_edge(clk) then
		case totaladr is
            when "00000000" => rgb <= "010010";
            when "00000001" => rgb <= "010010";
            when "00000010" => rgb <= "010010";
            when "00000011" => rgb <= "010010";
            when "00000100" => rgb <= "010010";
            when "00000101" => rgb <= "101010";
            when "00000110" => rgb <= "101010";
            when "00000111" => rgb <= "101010";
            when "00001000" => rgb <= "101010";
            when "00001001" => rgb <= "101010";
            when "00001010" => rgb <= "101010";
            when "00001011" => rgb <= "010010";
            when "00001100" => rgb <= "010010";
            when "00001101" => rgb <= "010010";
            when "00001110" => rgb <= "010010";
            when "00001111" => rgb <= "010010";
            when "00010000" => rgb <= "010010";
            when "00010001" => rgb <= "010010";
            when "00010010" => rgb <= "010010";
            when "00010011" => rgb <= "101010";
            when "00010100" => rgb <= "101010";
            when "00010101" => rgb <= "101010";
            when "00010110" => rgb <= "101010";
            when "00010111" => rgb <= "101010";
            when "00011000" => rgb <= "101010";
            when "00011001" => rgb <= "101010";
            when "00011010" => rgb <= "101010";
            when "00011011" => rgb <= "010101";
            when "00011100" => rgb <= "010101";
            when "00011101" => rgb <= "010010";
            when "00011110" => rgb <= "010010";
            when "00011111" => rgb <= "010010";
            when "00100000" => rgb <= "010010";
            when "00100001" => rgb <= "010010";
            when "00100010" => rgb <= "101010";
            when "00100011" => rgb <= "101010";
            when "00100100" => rgb <= "101010";
            when "00100101" => rgb <= "101010";
            when "00100110" => rgb <= "101010";
            when "00100111" => rgb <= "101010";
            when "00101000" => rgb <= "111111";
            when "00101001" => rgb <= "111111";
            when "00101010" => rgb <= "111111";
            when "00101011" => rgb <= "101010";
            when "00101100" => rgb <= "101010";
            when "00101101" => rgb <= "010101";
            when "00101110" => rgb <= "010010";
            when "00101111" => rgb <= "010010";
            when "00110000" => rgb <= "010010";
            when "00110001" => rgb <= "101010";
            when "00110010" => rgb <= "101010";
            when "00110011" => rgb <= "101010";
            when "00110100" => rgb <= "101010";
            when "00110101" => rgb <= "111111";
            when "00110110" => rgb <= "111111";
            when "00110111" => rgb <= "111111";
            when "00111000" => rgb <= "101010";
            when "00111001" => rgb <= "111111";
            when "00111010" => rgb <= "111111";
            when "00111011" => rgb <= "111111";
            when "00111100" => rgb <= "111111";
            when "00111101" => rgb <= "101010";
            when "00111110" => rgb <= "010101";
            when "00111111" => rgb <= "010010";
            when "01000000" => rgb <= "010010";
            when "01000001" => rgb <= "101010";
            when "01000010" => rgb <= "101010";
            when "01000011" => rgb <= "101010";
            when "01000100" => rgb <= "111111";
            when "01000101" => rgb <= "101010";
            when "01000110" => rgb <= "111111";
            when "01000111" => rgb <= "111111";
            when "01001000" => rgb <= "111111";
            when "01001001" => rgb <= "111111";
            when "01001010" => rgb <= "111111";
            when "01001011" => rgb <= "111111";
            when "01001100" => rgb <= "111111";
            when "01001101" => rgb <= "101010";
            when "01001110" => rgb <= "010101";
            when "01001111" => rgb <= "010010";
            when "01010000" => rgb <= "101010";
            when "01010001" => rgb <= "101010";
            when "01010010" => rgb <= "101010";
            when "01010011" => rgb <= "111111";
            when "01010100" => rgb <= "111111";
            when "01010101" => rgb <= "111111";
            when "01010110" => rgb <= "111111";
            when "01010111" => rgb <= "101010";
            when "01011000" => rgb <= "111111";
            when "01011001" => rgb <= "111111";
            when "01011010" => rgb <= "111111";
            when "01011011" => rgb <= "101010";
            when "01011100" => rgb <= "111111";
            when "01011101" => rgb <= "111111";
            when "01011110" => rgb <= "101010";
            when "01011111" => rgb <= "010101";
            when "01100000" => rgb <= "101010";
            when "01100001" => rgb <= "101010";
            when "01100010" => rgb <= "101010";
            when "01100011" => rgb <= "111111";
            when "01100100" => rgb <= "101010";
            when "01100101" => rgb <= "111111";
            when "01100110" => rgb <= "111111";
            when "01100111" => rgb <= "111111";
            when "01101000" => rgb <= "111111";
            when "01101001" => rgb <= "111111";
            when "01101010" => rgb <= "111111";
            when "01101011" => rgb <= "111111";
            when "01101100" => rgb <= "111111";
            when "01101101" => rgb <= "111111";
            when "01101110" => rgb <= "101010";
            when "01101111" => rgb <= "010101";
            when "01110000" => rgb <= "101010";
            when "01110001" => rgb <= "101010";
            when "01110010" => rgb <= "101010";
            when "01110011" => rgb <= "111111";
            when "01110100" => rgb <= "111111";
            when "01110101" => rgb <= "111111";
            when "01110110" => rgb <= "111111";
            when "01110111" => rgb <= "111111";
            when "01111000" => rgb <= "111111";
            when "01111001" => rgb <= "111111";
            when "01111010" => rgb <= "111111";
            when "01111011" => rgb <= "111111";
            when "01111100" => rgb <= "111111";
            when "01111101" => rgb <= "111111";
            when "01111110" => rgb <= "101010";
            when "01111111" => rgb <= "010101";
            when "10000000" => rgb <= "101010";
            when "10000001" => rgb <= "101010";
            when "10000010" => rgb <= "101010";
            when "10000011" => rgb <= "101010";
            when "10000100" => rgb <= "111111";
            when "10000101" => rgb <= "111111";
            when "10000110" => rgb <= "101010";
            when "10000111" => rgb <= "111111";
            when "10001000" => rgb <= "111111";
            when "10001001" => rgb <= "111111";
            when "10001010" => rgb <= "101010";
            when "10001011" => rgb <= "111111";
            when "10001100" => rgb <= "111111";
            when "10001101" => rgb <= "101010";
            when "10001110" => rgb <= "101010";
            when "10001111" => rgb <= "010101";
            when "10010000" => rgb <= "101010";
            when "10010001" => rgb <= "101010";
            when "10010010" => rgb <= "101010";
            when "10010011" => rgb <= "111111";
            when "10010100" => rgb <= "111111";
            when "10010101" => rgb <= "111111";
            when "10010110" => rgb <= "111111";
            when "10010111" => rgb <= "111111";
            when "10011000" => rgb <= "111111";
            when "10011001" => rgb <= "111111";
            when "10011010" => rgb <= "111111";
            when "10011011" => rgb <= "111111";
            when "10011100" => rgb <= "101010";
            when "10011101" => rgb <= "101010";
            when "10011110" => rgb <= "101010";
            when "10011111" => rgb <= "010101";
            when "10100000" => rgb <= "101010";
            when "10100001" => rgb <= "101010";
            when "10100010" => rgb <= "101010";
            when "10100011" => rgb <= "111111";
            when "10100100" => rgb <= "111111";
            when "10100101" => rgb <= "101010";
            when "10100110" => rgb <= "111111";
            when "10100111" => rgb <= "111111";
            when "10101000" => rgb <= "111111";
            when "10101001" => rgb <= "111111";
            when "10101010" => rgb <= "111111";
            when "10101011" => rgb <= "111111";
            when "10101100" => rgb <= "101010";
            when "10101101" => rgb <= "101010";
            when "10101110" => rgb <= "101010";
            when "10101111" => rgb <= "010101";
            when "10110000" => rgb <= "010010";
            when "10110001" => rgb <= "101010";
            when "10110010" => rgb <= "101010";
            when "10110011" => rgb <= "101010";
            when "10110100" => rgb <= "111111";
            when "10110101" => rgb <= "111111";
            when "10110110" => rgb <= "111111";
            when "10110111" => rgb <= "111111";
            when "10111000" => rgb <= "101010";
            when "10111001" => rgb <= "111111";
            when "10111010" => rgb <= "111111";
            when "10111011" => rgb <= "101010";
            when "10111100" => rgb <= "101010";
            when "10111101" => rgb <= "101010";
            when "10111110" => rgb <= "010101";
            when "10111111" => rgb <= "010010";
            when "11000000" => rgb <= "010010";
            when "11000001" => rgb <= "101010";
            when "11000010" => rgb <= "101010";
            when "11000011" => rgb <= "101010";
            when "11000100" => rgb <= "101010";
            when "11000101" => rgb <= "101010";
            when "11000110" => rgb <= "111111";
            when "11000111" => rgb <= "111111";
            when "11001000" => rgb <= "111111";
            when "11001001" => rgb <= "111111";
            when "11001010" => rgb <= "101010";
            when "11001011" => rgb <= "101010";
            when "11001100" => rgb <= "101010";
            when "11001101" => rgb <= "101010";
            when "11001110" => rgb <= "010101";
            when "11001111" => rgb <= "010010";
            when "11010000" => rgb <= "010010";
            when "11010001" => rgb <= "010010";
            when "11010010" => rgb <= "010101";
            when "11010011" => rgb <= "101010";
            when "11010100" => rgb <= "101010";
            when "11010101" => rgb <= "101010";
            when "11010110" => rgb <= "101010";
            when "11010111" => rgb <= "101010";
            when "11011000" => rgb <= "101010";
            when "11011001" => rgb <= "101010";
            when "11011010" => rgb <= "101010";
            when "11011011" => rgb <= "101010";
            when "11011100" => rgb <= "101010";
            when "11011101" => rgb <= "010101";
            when "11011110" => rgb <= "010010";
            when "11011111" => rgb <= "010010";
            when "11100000" => rgb <= "010010";
            when "11100001" => rgb <= "010010";
            when "11100010" => rgb <= "010010";
            when "11100011" => rgb <= "010101";
            when "11100100" => rgb <= "010101";
            when "11100101" => rgb <= "101010";
            when "11100110" => rgb <= "101010";
            when "11100111" => rgb <= "101010";
            when "11101000" => rgb <= "101010";
            when "11101001" => rgb <= "101010";
            when "11101010" => rgb <= "101010";
            when "11101011" => rgb <= "010101";
            when "11101100" => rgb <= "010101";
            when "11101101" => rgb <= "010010";
            when "11101110" => rgb <= "010010";
            when "11101111" => rgb <= "010010";
            when "11110000" => rgb <= "010010";
            when "11110001" => rgb <= "010010";
            when "11110010" => rgb <= "010010";
            when "11110011" => rgb <= "010010";
            when "11110100" => rgb <= "010010";
            when "11110101" => rgb <= "010101";
            when "11110110" => rgb <= "010101";
            when "11110111" => rgb <= "010101";
            when "11111000" => rgb <= "010101";
            when "11111001" => rgb <= "010101";
            when "11111010" => rgb <= "010101";
            when "11111011" => rgb <= "010010";
            when "11111100" => rgb <= "010010";
            when "11111101" => rgb <= "010010";
            when "11111110" => rgb <= "010010";
            when "11111111" => rgb <= "010010";
            when others => rgb <= "010010";
		end case;
	    end if;
   end process;
   totaladr <= std_logic_vector(y_cord) & std_logic_vector(x_cord);
end;