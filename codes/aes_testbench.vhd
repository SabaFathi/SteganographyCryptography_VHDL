LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

USE work.AES_DEPENDENCY_PKG.ALL;

ENTITY aes_testbench IS
END aes_testbench;
 
ARCHITECTURE behavior OF aes_testbench IS

	-- Component Declaration for the Unit Under Test (UUT)
	component AES_encrypter is
	port(encryption_key : in std_logic_vector(127 downto 0);
		  plain_data : in std_logic_vector(127 downto 0);
		  enable : in std_logic;
		  clk : in std_logic;
		  cipher_data : out std_logic_vector(127 downto 0));
	end component;
	
	component AES_decrypter is
	port(encryption_key : in std_logic_vector(127 downto 0);
		  cipher_data : in std_logic_vector(127 downto 0);
		  enable : in std_logic;
		  clk : in std_logic;
		  plain_data : out std_logic_vector(127 downto 0));
	end component;
	
	-- signals
	signal encryption_key : std_logic_vector(127 downto 0);
	signal in_plain_data : std_logic_vector(127 downto 0);
	signal clk : std_logic := '0';
	signal enable : std_logic;
	signal cipher_data : std_logic_vector(127 downto 0);
	signal out_plain_data : std_logic_vector(127 downto 0);
	
BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut_encrypter: AES_encrypter port map(encryption_key => encryption_key, plain_data => in_plain_data, enable => enable, clk => clk, cipher_data => cipher_data);
	uut_decrypter: AES_decrypter port map(encryption_key => encryption_key, cipher_data => cipher_data, enable => enable, clk => clk, plain_data => out_plain_data);

	clk <= not clk after 5 ns;
	enable <= '1';
	
	encryption_key <= X"9FC3E502AB534800E76EDD19BF0246AC";
	in_plain_data  <= X"45006006AF5024389DE19FCB87A0546A";

END;
