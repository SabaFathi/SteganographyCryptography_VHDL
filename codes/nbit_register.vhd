library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity nbit_register is
generic(n : integer := 8);
port(data_in : in std_logic_vector(n-1 downto 0);
     protect_mode_activelow : in std_logic;
	  
     clk : in std_logic;
	  
	  data_out : out std_logic_vector(n-1 downto 0) );
end nbit_register;

architecture Behavioral of nbit_register is
signal data : std_logic_vector(n-1 downto 0) := (others => '0');
begin

    data_out <= data;

    process(clk)
	 begin
        if(rising_edge(clk))
		  then
	         if(protect_mode_activelow = '1')
				then
				    data <= data_in;
				else
				    -- no change :)
				end if;
		  end if;
	 end process;

end Behavioral;
