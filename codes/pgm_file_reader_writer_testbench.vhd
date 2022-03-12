LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY pgm_file_reader_writer_testbench IS
END pgm_file_reader_writer_testbench;
 
ARCHITECTURE behavior OF pgm_file_reader_writer_testbench IS

    -- Component Declaration for the Unit Under Test (UUT)
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
    
	 -- signals
	 signal clk : std_logic := '0';
	 signal reset : std_logic := '0';
	 signal end_of_file : std_logic := '0';
	 signal en : std_logic := '0';
	 signal data_transfer : std_logic_vector(7 downto 0);
BEGIN

	en <= not end_of_file;
	
	-- Instantiate the Unit Under Test (UUT)
   uut1: pgm_file_reader
	generic map(FILE_NAME => "F:\term6_982\FPGA\taklif\finalProject\project\enhanceSecurity\phase1\testData\test_data.txt")
	port map(clk => clk, reset => reset, data_out => data_transfer, end_of_file => end_of_file);
	
	uut2: pgm_file_writer
	generic map(FILE_NAME => "F:\term6_982\FPGA\taklif\finalProject\project\enhanceSecurity\phase1\testData\test_out.txt")
	port map(clk => clk, en => en, data_in => data_transfer);


	clk <= not clk after 5 ns;
	reset <= '1' after 0 ns, '0' after 10 ns;
	en <= '0' after 0 ns, '1' after 10 ns;

END;
