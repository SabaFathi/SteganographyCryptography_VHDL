LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY generic_buffer_testbench IS
END generic_buffer_testbench;
 
ARCHITECTURE behavior OF generic_buffer_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT generic_buffer
    generic(input_size : integer := 8;
	         output_size : integer := 8;
				buffer_size : integer := 256);
	 port(data_in : in std_logic_vector(0 to input_size-1);
         input_enable : in std_logic;
			output_enable : in std_logic;
			reset : in std_logic;
			clk_in : in std_logic;
			clk_out: in std_logic;
			data_out : out std_logic_vector(0 to output_size-1);
			full : out std_logic;
			empty : out std_logic );
    END COMPONENT;

    --Inputs
    signal data_in_1bit : std_logic_vector(0 to 0) := "0";
	 signal data_in_2bit : std_logic_vector(0 to 1) := "00";
	 signal data_in_3bit : std_logic_vector(0 to 2) := "000";
    signal input_enable : std_logic := '0';
    signal output_enable : std_logic := '0';
    signal reset : std_logic := '0';
    signal clk_in : std_logic := '0';
    signal clk_out : std_logic := '0';
 	 --Outputs
    signal data_out_uut1 : std_logic_vector(0 to 2);
    signal full_uut1 : std_logic;
    signal empty_uut1 : std_logic;
	 signal data_out_uut2 : std_logic_vector(0 to 1);
    signal full_uut2 : std_logic;
    signal empty_uut2 : std_logic;
	 signal data_out_uut3 : std_logic_vector(0 to 1);
    signal full_uut3 : std_logic;
    signal empty_uut3 : std_logic;
	 signal data_out_uut4 : std_logic_vector(0 to 2);
    signal full_uut4 : std_logic;
    signal empty_uut4 : std_logic;
    signal data_out_uut5 : std_logic_vector(0 to 0);
    signal full_uut5 : std_logic;
    signal empty_uut5 : std_logic;
	 
	 constant data_test_allzero : std_logic_vector(0 to 3) := "0000";
	 constant data_test_allone : std_logic_vector(0 to 3) := "1111";
	 constant data_test_nopattern : std_logic_vector(0 to 53) := "100001110111001010001110110100101111000001100110110101";

BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
    uut1: generic_buffer
    GENERIC MAP(
        input_size => 3,
        output_size => 3,
        buffer_size => 11
    )
    PORT MAP(
        data_in => data_in_3bit,
        input_enable => input_enable,
        output_enable => output_enable,
        reset => reset,
        clk_in => clk_in,
        clk_out => clk_out,
        data_out => data_out_uut1,
        full => full_uut1,
        empty => empty_uut1
    );
	 
	 uut2: generic_buffer
    GENERIC MAP(
        input_size => 2,
        output_size => 2,
        buffer_size => 8
    )
    PORT MAP(
        data_in => data_in_2bit,
        input_enable => input_enable,
        output_enable => output_enable,
        reset => reset,
        clk_in => clk_in,
        clk_out => clk_out,
        data_out => data_out_uut2,
        full => full_uut2,
        empty => empty_uut2
    );
	 
	 uut3: generic_buffer
    GENERIC MAP(
        input_size => 3,
        output_size => 2,
        buffer_size => 9
    )
    PORT MAP(
        data_in => data_in_3bit,
        input_enable => input_enable,
        output_enable => output_enable,
        reset => reset,
        clk_in => clk_in,
        clk_out => clk_out,
        data_out => data_out_uut3,
        full => full_uut3,
        empty => empty_uut3
    );
	 
	 uut4: generic_buffer
    GENERIC MAP(
        input_size => 2,
        output_size => 3,
        buffer_size => 9
    )
    PORT MAP(
        data_in => data_in_2bit,
        input_enable => input_enable,
        output_enable => output_enable,
        reset => reset,
        clk_in => clk_in,
        clk_out => clk_out,
        data_out => data_out_uut4,
        full => full_uut4,
        empty => empty_uut4
    );
	 
	 uut5: generic_buffer
    GENERIC MAP(
        input_size => 1,
        output_size => 1,
        buffer_size => 8
    )
    PORT MAP(
        data_in => data_in_1bit,
        input_enable => input_enable,
        output_enable => output_enable,
        reset => reset,
        clk_in => clk_in,
        clk_out => clk_out,
        data_out => data_out_uut5,
        full => full_uut5,
        empty => empty_uut5
    );
	 
	 
	 clk_in <= not clk_in after 5 ns;
	 clk_out <= not clk_out after 5 ns;
	 
	 reset <= '0' after 0 ns, '1' after 260 ns;
	 
	 input_enable <= '1' after 0 ns , '0' after 90 ns, '1' after 180 ns;
	 output_enable <= '0' after 0 ns, '1' after 90 ns;
	 
	 --data_in_1bit <= data_test_allone(0 to 0);
	 --data_in_2bit <= data_test_allone(0 to 1);
	 --data_in_3bit <= data_test_allone(0 to 2);
	 
	 data_in_1bit <= data_test_nopattern(0 to 0) after 0 ns,
	                 data_test_nopattern(1 to 1) after 10 ns,
						  data_test_nopattern(2 to 2) after 20 ns,
						  data_test_nopattern(3 to 3) after 30 ns,
						  data_test_nopattern(4 to 4) after 40 ns,
						  data_test_nopattern(5 to 5) after 50 ns,
						  data_test_nopattern(6 to 6) after 60 ns,
						  data_test_nopattern(7 to 7) after 70 ns,
						  data_test_nopattern(8 to 8) after 80 ns,
						  data_test_nopattern(9 to 9) after 90 ns,
						  data_test_nopattern(10 to 10) after 180 ns,
						  data_test_nopattern(11 to 11) after 190 ns,
						  data_test_nopattern(12 to 12) after 200 ns,
						  data_test_nopattern(13 to 13) after 210 ns,
						  data_test_nopattern(14 to 14) after 220 ns,
						  data_test_nopattern(15 to 15) after 230 ns,
						  data_test_nopattern(16 to 16) after 240 ns,
						  data_test_nopattern(17 to 17) after 250 ns;
	 data_in_2bit <= data_test_nopattern(0 to 1) after 0 ns,
	                 data_test_nopattern(2 to 3) after 10 ns,
						  data_test_nopattern(4 to 5) after 20 ns,
						  data_test_nopattern(6 to 7) after 30 ns,
						  data_test_nopattern(8 to 9) after 40 ns,
						  data_test_nopattern(10 to 11) after 50 ns,
						  data_test_nopattern(12 to 13) after 60 ns,
						  data_test_nopattern(14 to 15) after 70 ns,
						  data_test_nopattern(16 to 17) after 80 ns,
						  data_test_nopattern(18 to 19) after 90 ns,
						  data_test_nopattern(20 to 21) after 180 ns,
						  data_test_nopattern(22 to 23) after 190 ns,
						  data_test_nopattern(24 to 25) after 200 ns,
						  data_test_nopattern(26 to 27) after 210 ns,
						  data_test_nopattern(28 to 29) after 220 ns,
						  data_test_nopattern(30 to 31) after 230 ns,
						  data_test_nopattern(32 to 33) after 240 ns,
						  data_test_nopattern(34 to 35) after 250 ns;
	 data_in_3bit <= data_test_nopattern(0 to 2) after 0 ns,
	                 data_test_nopattern(3 to 5) after 10 ns,
						  data_test_nopattern(6 to 8) after 20 ns,
						  data_test_nopattern(9 to 11) after 30 ns,
						  data_test_nopattern(12 to 14) after 40 ns,
						  data_test_nopattern(15 to 17) after 50 ns,
						  data_test_nopattern(18 to 20) after 60 ns,
						  data_test_nopattern(21 to 23) after 70 ns,
						  data_test_nopattern(24 to 26) after 80 ns,
						  data_test_nopattern(27 to 29) after 90 ns,
						  data_test_nopattern(30 to 32) after 180 ns,
						  data_test_nopattern(33 to 35) after 190 ns,
						  data_test_nopattern(36 to 38) after 200 ns,
						  data_test_nopattern(39 to 41) after 210 ns,
						  data_test_nopattern(42 to 44) after 220 ns,
						  data_test_nopattern(45 to 47) after 230 ns,
						  data_test_nopattern(48 to 50) after 240 ns,
						  data_test_nopattern(51 to 53) after 250 ns;

    --expected : uut1
	 ----data_out :
	 ----full :
	 ----empty :

END;
