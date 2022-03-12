LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY steganography_encoder_testbench IS
END steganography_encoder_testbench;
 
ARCHITECTURE behavior OF steganography_encoder_testbench IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT steganography_encoder
	PORT(cover_pixel : IN  std_logic_vector(7 downto 0);
		  secure_data : IN  std_logic_vector(7 downto 0);
		  security_level : IN  std_logic;
		  encryption_key : IN  std_logic_vector(6 downto 0);
		  clk : IN  std_logic;
		  clk8 : IN  std_logic;
		  enable : IN  std_logic;
		  covered_data : OUT  std_logic_vector(7 downto 0));
	END COMPONENT;
	
	COMPONENT pgm_file_reader
	 GENERIC(FILE_NAME : string := "test_data.txt");
    PORT(clk : in std_logic;
			reset : in std_logic;
			data_out : out std_logic_vector(7 downto 0);
			end_of_file : out std_logic);
    END COMPONENT;
	 
	 COMPONENT pgm_file_writer
	 GENERIC(FILE_NAME : string := "test_wr.txt");
	 PORT(clk : in std_logic;
			en : in std_logic;
			data_in : in std_logic_vector(7 downto 0));
	 END COMPONENT;


	signal cover_pixel : std_logic_vector(7 downto 0) := (others => '0');
	signal secure_data : std_logic_vector(7 downto 0) := (others => '0');
	signal security_level : std_logic := '0';
	signal encryption_key : std_logic_vector(6 downto 0) := (others => '0');
	signal clk : std_logic := '0';
	signal clk8 : std_logic := '0';
	signal enable : std_logic := '0';
	signal covered_data : std_logic_vector(7 downto 0);
	signal reset : std_logic := '0';
	signal end_of_file : std_logic;
	

BEGIN

	reset <= not enable;

	uut_file_reader: pgm_file_reader
	generic map(FILE_NAME => "F:\term6_982\FPGA\taklif\finalProject\project\enhanceSecurity\phase1\testData\test_data.txt")
	port map(clk => clk, reset => reset, data_out => cover_pixel, end_of_file => end_of_file);
	
	uut_encoder: steganography_encoder
	PORT MAP(cover_pixel => cover_pixel, secure_data => secure_data, security_level => security_level,
				encryption_key => encryption_key, clk => clk, clk8 => clk8, enable => enable,
				covered_data => covered_data);
	
	uut_file_writer: pgm_file_writer
	generic map(FILE_NAME => "F:\term6_982\FPGA\taklif\finalProject\project\enhanceSecurity\phase1\testData\test_out.txt")
	port map(clk => clk, en => enable, data_in => covered_data);


	clk <= not clk after 5 ns;
	clk8 <= not clk8 after 40 ns;

	secure_data <= "10101010";
	security_level <= '0';
	encryption_key <= (others => '0');
	
	enable <= '1' after 0 ns, '0' after 738000 ns;

END;
