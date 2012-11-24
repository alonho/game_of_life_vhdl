library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity cell is
generic (
  start_alive : integer range 0 to 1
  );
port (
  clock,
  upper_left, upper, upper_right,
  left, right,
  lower_left, lower, lower_right : in integer range 0 to 1;
  alive : inout integer range 0 to 1 := start_alive
  );
end cell;
 
architecture arch of cell is
begin

  process (clock)
    begin
      if ((upper_left + upper + upper_right +
           left + right +
           lower_left + lower + lower_right) = 3) or
        (alive = 1 and (upper_left + upper + upper_right +
                        left + right +
                        lower_left + lower + lower_right) = 2) then
        alive <= 1;
      else
        alive <= 0;
      end if;
    end process;
end arch;
