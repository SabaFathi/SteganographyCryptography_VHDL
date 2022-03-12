LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY embedder_LSB_testbench IS
END embedder_LSB_testbench;
 
ARCHITECTURE behavior OF embedder_LSB_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT embedder_LSB
    PORT(
         cover_data : IN  std_logic_vector(7 downto 0);
         hidden_data : IN  std_logic_vector(7 downto 0);
			enable : IN std_logic;
         clk : IN  std_logic;
         stego_data : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal cover_data : std_logic_vector(7 downto 0) := (others => '0');
   signal hidden_data : std_logic_vector(7 downto 0) := (others => '0');
	signal enable : std_logic;
   signal clk : std_logic := '0';
 	--Outputs
   signal stego_data : std_logic_vector(7 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: embedder_LSB PORT MAP (
          cover_data => cover_data,
          hidden_data => hidden_data,
			 enable => enable,
          clk => clk,
          stego_data => stego_data
        );

    clk <= not clk after 5 ns;
	 
	 enable <= '1' after 0 ns, '0' after 90 ns;
	 cover_data <= "11111111";
	 hidden_data <= "10101100";
	 --expected : stego_data = (1)"11111110", (2)"11111110", (3)"11111111", (4)"11111111",
	 --                        (5)"11111110", (6)"11111111", (7)"11111110", (8)"11111111";

END;
