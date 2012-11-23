library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package matrix_pkg is
constant X: integer := 4;
constant Y: integer := 4;
type matrix is array(0 to X, 0 to Y) of integer range 0 to 1;
end package matrix_pkg;

use work.matrix_pkg.all;

entity board is
generic (
  init_state : matrix
);
port (
  mat: inout matrix;
  clock: in integer range 0 to 1
  );
end board;

architecture arch of board is

  component cell
    generic (
      start_alive : integer range 0 to 1
    );
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
  for i in 0 to X generate
    begin
      inner:
        for j in 0 to Y generate
          begin
            upper_left:
              if (i = 0 and j = 0) generate 
              cell: entity work.cell
              generic map
              (start_alive => init_state(i, j))
              port map
              (clock => clock,
               upper_left => 0,
               upper => 0,
               upper_right => 0,
               left => 0,
               right => mat(i + 1, j),
               lower_left => 0,
               lower => mat(i, j + 1),
               lower_right => mat(i + 1, j + 1),
               alive => mat(i, j));
            end generate upper_left;
            upper:
              if (i > 0 and i < X and j = 0) generate 
              cell: entity work.cell
              generic map
              (start_alive => init_state(i, j))
              port map
              (clock => clock,
               upper_left => 0,
               upper => 0,
               upper_right => 0,
               left => mat(i - 1, j),
               right => mat(i + 1, j),
               lower_left => mat(i - 1, j + 1),
               lower => mat(i, j + 1),
               lower_right => mat(i + 1, j + 1),
               alive => mat(i, j));
            end generate upper;
            upper_right:
              if (i = X and j = 0) generate 
              cell: entity work.cell
              generic map
              (start_alive => init_state(i, j))
              port map
              (clock => clock,
               upper_left => 0,
               upper => 0,
               upper_right => 0,
               left => mat(i - 1, j),
               right => 0,
               lower_left => mat(i - 1, j + 1),
               lower => mat(i, j + 1),
               lower_right => 0,
               alive => mat(i, j));
            end generate upper_right;
            left:
              if (i = 0 and j > 0 and j < Y) generate 
              cell: entity work.cell
              generic map
              (start_alive => init_state(i, j))
              port map
              (clock => clock,
               upper_left => 0,
               upper => mat(i, j - 1),
               upper_right => mat(i + 1, j - 1),
               left => 0,
               right => mat(i + 1, j),
               lower_left => 0,
               lower => mat(i, j + 1),
               lower_right => mat(i + 1, j + 1),
               alive => mat(i, j));
            end generate left;
            middle:
              if (i > 0 and i < X and j > 0 and j < Y) generate 
              cell: entity work.cell
              generic map
              (start_alive => init_state(i, j))
              port map
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
            end generate middle;
            right:
              if (i = X and j > 0 and j < Y) generate 
              cell: entity work.cell
              generic map
              (start_alive => init_state(i, j))
              port map
              (clock => clock,
               upper_left => mat(i - 1, j - 1),
               upper => mat(i, j - 1),
               upper_right => 0,
               left => mat(i - 1, j),
               right => 0,
               lower_left => mat(i - 1, j + 1),
               lower => mat(i, j + 1),
               lower_right => 0,
               alive => mat(i, j));
            end generate right;
            lower_left:
              if (i = 0 and j = Y) generate 
              cell: entity work.cell
              generic map
              (start_alive => init_state(i, j))
              port map
              (clock => clock,
               upper_left => 0,
               upper => mat(i, j - 1),
               upper_right => mat(i + 1, j - 1),
               left => 0,
               right => mat(i + 1, j),
               lower_left => 0,
               lower => 0,
               lower_right => 0,
               alive => mat(i, j));
            end generate lower_left;
            lower:
              if (i > 0 and i < X and j = Y) generate 
              cell: entity work.cell
              generic map
              (start_alive => init_state(i, j))
              port map
              (clock => clock,
               upper_left => mat(i - 1, j - 1),
               upper => mat(i, j - 1),
               upper_right => mat(i + 1, j - 1),
               left => mat(i - 1, j),
               right => mat(i + 1, j),
               lower_left => 0,
               lower => 0,
               lower_right => 0,
               alive => mat(i, j));
            end generate lower;
            lower_right:
              if (i = X and j = Y) generate 
              cell: entity work.cell
              generic map
              (start_alive => init_state(i, j))
              port map
              (clock => clock,
               upper_left => mat(i - 1, j - 1),
               upper => mat(i, j - 1),
               upper_right => 0,
               left => mat(i - 1, j),
               right => 0,
               lower_left => 0,
               lower => 0,
               lower_right => 0,
               alive => mat(i, j));
            end generate lower_right;
      end generate inner;
  end generate outer;
end arch;
