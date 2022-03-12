LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY steganography_decoder_testbench IS
END steganography_decoder_testbench;
 
ARCHITECTURE behavior OF steganography_decoder_testbench IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT steganography_decoder
    PORT(stego_pixel : IN  std_logic_vector(7 downto 0);
         enable : IN  std_logic;
         clk : IN  std_logic;
         encryption_key : IN  std_logic_vector(6 downto 0);
         security_level : IN  std_logic;
         secret_data : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    
	 COMPONENT pgm_file_reader
	 GENERIC(FILE_NAME : string := "test_data.txt");
    PORT(clk : in std_logic;
			reset : in std_logic;
			data_out : out std_logic_vector(7 downto 0);
			end_of_file : out std_logic);
    END COMPONENT;
	 
   signal stego_pixel : std_logic_vector(7 downto 0) := (others => '0');
   signal enable : std_logic := '0';
   signal clk : std_logic := '0';
   signal encryption_key : std_logic_vector(6 downto 0) := (others => '0');
   signal security_level : std_logic := '0';
   signal secret_data : std_logic_vector(7 downto 0);
	signal reset : std_logic := '0';
	signal end_of_file : std_logic;
	signal not_end_of_file : std_logic;

BEGIN

	reset <= not enable;
	not_end_of_file <= not end_of_file;

	uut_file_reader: pgm_file_reader
	generic map(FILE_NAME => "F:\term6_982\FPGA\taklif\finalProject\project\enhanceSecurity\phase1\testData\test_data_2.txt")
	port map(clk => clk, reset => reset, data_out => stego_pixel, end_of_file => end_of_file);
	
	uut_decoder: steganography_decoder
	PORT MAP(stego_pixel => stego_pixel, enable => not_end_of_file, clk => clk, encryption_key => encryption_key,
				security_level => security_level, secret_data => secret_data);


	clk <= not clk after 5 ns;

	enable <= '1';
	encryption_key <= (others => '0');
	security_level <= '0';

END;
