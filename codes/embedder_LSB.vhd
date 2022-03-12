library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity embedder_LSB is
port(cover_data : in std_logic_vector(7 downto 0);
     hidden_data : in std_logic_vector(7 downto 0);
	  
	  enable : in std_logic;
	  clk : in std_logic;
	  
	  stego_data : out std_logic_vector(7 downto 0) := (others => '0'));
end embedder_LSB;

architecture Behavioral of embedder_LSB is
signal index : std_logic_vector(2 downto 0) := "000";
begin

    process(clk, enable)
	 begin
	     if(rising_edge(clk))
		  then
		      if(enable = '1')
				then
		          stego_data <= cover_data(7 downto 1) & hidden_data(conv_integer(index));
				    index <= index + 1;
				else
				    index <= "000";
					 stego_data <= (others => '0');
				end if;
		  end if;
	 end process;

end Behavioral;
