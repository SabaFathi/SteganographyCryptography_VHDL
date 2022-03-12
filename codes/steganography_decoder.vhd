library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity steganography_decoder is
port(stego_pixel : in std_logic_vector(7 downto 0);
     enable : in std_logic;
	  clk : in std_logic;
	  encryption_key : in std_logic_vector(6 downto 0);
	  security_level : in std_logic;
	  
	  secret_data : out std_logic_vector(7 downto 0));
end steganography_decoder;

architecture Structural of steganography_decoder is
component extractor_LSB
port(stego_data : in std_logic_vector(7 downto 0);
     clk : in std_logic;
	  enable : in std_logic;
	  hidden_data : out std_logic_vector(7 downto 0) := (others => '0'));
end component;

component decrypter_caesar_cipher
port(encrypted_data: in std_logic_vector(7 downto 0);
     key : in std_logic_vector(6 downto 0); --max value = 127
	  clk : in std_logic;
	  enable : in std_logic;
	  plain_data : out std_logic_vector(7 downto 0) := (others => '0'));
end component;

component generic_buffer
generic(input_size : integer := 8; output_size : integer := 8; buffer_size : integer := 256);
port(data_in : in std_logic_vector(0 to input_size-1);
     input_enable : in std_logic;
	  output_enable : in std_logic;
	  reset : in std_logic;
	  clk_in : in std_logic;
	  clk_out: in std_logic;
	  data_out : out std_logic_vector(0 to output_size-1) := (others => '0');
	  full : out std_logic := '0';
	  empty : out std_logic := '0');
end component;

component nbit_register
generic(n : integer := 8);
port(data_in : in std_logic_vector(n-1 downto 0);
     protect_mode_activelow : in std_logic;
     clk : in std_logic;
	  data_out : out std_logic_vector(n-1 downto 0));
end component;

signal hidden_data : std_logic_vector(7 downto 0);
signal plain_data : std_logic_vector(7 downto 0);

begin

	steg_extractor : extractor_LSB
	port map(stego_data => stego_pixel, clk => clk, enable => enable, hidden_data => hidden_data);

	decrypter : decrypter_caesar_cipher
	port map(encrypted_data => hidden_data, key => encryption_key, clk => clk, enable => security_level, plain_data => plain_data);

	secret_data <= hidden_data when (security_level = '0') else plain_data;

end Structural;
