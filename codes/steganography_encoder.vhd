library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity steganography_encoder is
port(cover_pixel : in std_logic_vector(7 downto 0);
     secure_data : in std_logic_vector(7 downto 0);
	  security_level : in std_logic;
	  encryption_key : in std_logic_vector(6 downto 0);
	  
	  clk : in std_logic;
	  clk8 : in std_logic;
	  enable : in std_logic;
	  
	  covered_data : out std_logic_vector(7 downto 0));
end steganography_encoder;

architecture Structural of steganography_encoder is

component embedder_LSB
port(cover_data : in std_logic_vector(7 downto 0);
     hidden_data : in std_logic_vector(7 downto 0);
	  enable : in std_logic;
	  clk : in std_logic;
	  stego_data : out std_logic_vector(7 downto 0) := (others => '0'));
end component;

component encrypter_caesar_cipher
port(plain_data: in std_logic_vector(7 downto 0);
     key : in std_logic_vector(6 downto 0); --max value = 127
	  clk : in std_logic;
	  enable : in std_logic;
	  encrypted_data : out std_logic_vector(7 downto 0) := (others => '0'));
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

signal enable_not : std_logic;
signal secure_data_registered : std_logic_vector(7 downto 0);
signal encrypted_data : std_logic_vector(7 downto 0);
signal hidden_data : std_logic_vector(7 downto 0);

begin

	enable_not <= not enable;
	
	secure_data_buffer : generic_buffer
	generic map(input_size => 8, output_size => 8, buffer_size => 16)
	port map(data_in => secure_data, input_enable => enable, output_enable => enable, reset => enable_not,
				clk_in => clk, clk_out => clk8, data_out => secure_data_registered);--, full, empty);

	encypter : encrypter_caesar_cipher
	port map(plain_data => secure_data_registered, key => encryption_key, clk => clk, enable => security_level,
				encrypted_data => encrypted_data);

	hidden_data <= secure_data_registered when (security_level = '0') else encrypted_data;

	embedder : embedder_LSB
	port map(cover_data => cover_pixel, hidden_data => hidden_data, enable => enable, clk => clk,
				stego_data => covered_data);

end Structural;
