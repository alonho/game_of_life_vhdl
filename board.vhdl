library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package matrix_pkg is
type matrix is array(0 to 10, 0 to 10) of integer range 0 to 1;
end package matrix_pkg;

use work.matrix_pkg.all;

entity board is
port (
  mat: inout matrix;
  clock: in integer range 0 to 1
  );
end board;

architecture arch of board is

  component cell
    port (
      clock,
      upper_left, upper, upper_right,
      left, right,
      lower_left, lower, lower_right : in integer range 0 to 1;
      alive : inout integer range 0 to 1
    );
  end component;
  
begin
  
outer:
  for i in 1 to 9 generate
    begin
      inner:
        for j in 1 to 9 generate
          begin
            cell: entity work.cell port map
              (clock => clock,
               upper_left => mat(i - 1, j - 1),
               upper => mat(i, j - 1),
               upper_right => mat(i + 1, j - 1),
               left => mat(i - 1, j),
               right => mat(i + 1, j),
               lower_left => mat(i - 1, j + 1),
               lower => mat(i, j + 1),
               lower_right => mat(i + 1, j + 1),
               alive => mat(i, j));
      end generate inner;
  end generate outer;
end arch;
