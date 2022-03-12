library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity generic_buffer is
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
end generic_buffer;

architecture Behavioral of generic_buffer is
signal data : std_logic_vector(0 to buffer_size-1) := (others => '0');
signal free_to_write_index : integer range 0 to (buffer_size-1) := 0;
signal ready_to_read_index : integer range 0 to (buffer_size-1) := 0;
signal first_writing_happen : std_logic := '0';
signal reader_reach_writer : std_logic := '0';
begin

    process(clk_in)
	 variable distance : integer range 0 to buffer_size;
	 begin
	     if(rising_edge(clk_in))
		  then
		      if(reset = '1')
				then
				    full <= '0';
					 free_to_write_index <= 0;
					 first_writing_happen <= '0';
				elsif(input_enable = '1')
				then
				    if(first_writing_happen = '0')
					 then
					     distance := buffer_size;
						  first_writing_happen <= '1';
					 elsif(ready_to_read_index = free_to_write_index)
					 then
					     if(reader_reach_writer = '1')
						  then
						      distance := buffer_size;
						  else
						      distance := 0;
						  end if;
					 elsif(ready_to_read_index < free_to_write_index)
					 then
					     distance := buffer_size - free_to_write_index + ready_to_read_index;
					 else
					     distance := ready_to_read_index - free_to_write_index;
					 end if;
					 
					 if(distance < input_size)
					 then
					     full <= '1';
					 else
					     full <= '0';
						  
						  if(free_to_write_index <= (buffer_size - input_size))
						  then
						      data(free_to_write_index to (free_to_write_index + input_size - 1)) <= data_in;
						  else
						      distance := buffer_size - free_to_write_index;
								data(free_to_write_index to (buffer_size - 1)) <= data_in(0 to distance-1);
								data(0 to (input_size - distance-1)) <= data_in(distance to input_size-1);
						  end if;
						  
						  free_to_write_index <= (free_to_write_index + input_size) REM buffer_size;
					 end if;
				end if;
		  end if;
	 end process;
	 
	 process(clk_out)
	 variable distance : integer range 0 to buffer_size;
	 begin
	     if(rising_edge(clk_out))
		  then
		      if(reset = '1')
				then
				    empty <= '0';
					 ready_to_read_index <= 0;
					 data_out <= (others => '0');
				elsif(output_enable = '1')
				then
				    if(first_writing_happen = '0')
					 then
					     distance := 0;
					 elsif(free_to_write_index = ready_to_read_index)
					 then
					     if(reader_reach_writer = '1')
						  then
						      distance := 0;
						  else
						      distance := buffer_size;
						  end if;
					 elsif(free_to_write_index < ready_to_read_index)
					 then
					     distance := buffer_size - ready_to_read_index + free_to_write_index;
					 else
					     distance := free_to_write_index - ready_to_read_index;
					 end if;
					 
					 if(distance < output_size)
					 then
					     empty <= '1';
					 else
					     empty <= '0';
						  
						  if(ready_to_read_index <= (buffer_size - output_size))
						  then
						      data_out <= data(ready_to_read_index to (ready_to_read_index + output_size - 1));
						  else
						      distance := buffer_size - ready_to_read_index;
								data_out(0 to (distance - 1)) <= data(ready_to_read_index to (buffer_size - 1));
								data_out(distance to (output_size-1)) <= data(0 to (output_size - distance - 1));
						  end if;
						  
						  if(distance = output_size)
						  then
						      reader_reach_writer <= '1';
						  else
						      reader_reach_writer <= '0';
						  end if;
						  
						  ready_to_read_index <= (ready_to_read_index + output_size) REM buffer_size;
					 end if;
				end if;
		  end if;
	 end process;

end Behavioral;
