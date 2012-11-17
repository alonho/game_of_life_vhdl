library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cell is
port (
  upper_left, upper, upper_right,
  left, right,
  lower_left, lower, lower_right : in integer range 0 to 1;
  alive : inout integer range 0 to 1
  );
end cell;
 
architecture arch of cell is
begin
  
  alive <= 1 when (upper_left + upper + upper_right + left + right + lower_left + lower + lower_right) = 3 or (alive = 1 and (upper_left + upper + upper_right + left + right + lower_left + lower + lower_right) = 2) else 0;
  
end arch;
