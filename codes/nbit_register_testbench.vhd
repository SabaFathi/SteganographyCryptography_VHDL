LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
 
ENTITY nbit_register_testbench IS
END nbit_register_testbench;
 
ARCHITECTURE behavior OF nbit_register_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT nbit_register
    PORT(
         data_in : IN  std_logic_vector(7 downto 0);
         protect_mode_activelow : IN  std_logic;
         clk : IN  std_logic;
         data_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal protect_mode_activelow : std_logic := '0';
   signal clk : std_logic := '0';
 	--Outputs
   signal data_out : std_logic_vector(7 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: nbit_register PORT MAP (
          data_in => data_in,
          protect_mode_activelow => protect_mode_activelow,
          clk => clk,
          data_out => data_out
        );

    clk <= not clk after 5 ns;
	 
	 protect_mode_activelow <= '1' after 0 ns, '0' after 30 ns, '1' after 40 ns, '0' after 50 ns;
	 data_in <= "11110000" after 0 ns, "00001111" after 10 ns, "11111111" after 20 ns, "00000000" after 30 ns;
	 --expected : data_out = "11110000", "00001111", "11111111", "11111111", "00000000";

END;
