library ieee;
use std.textio.all;

entity board_test is
end board_test;

architecture arch of board_test is

  function print_matrix(mat: work.matrix_pkg.matrix)
    return integer is
    variable l : line;  
  begin
    writeline (output, l);
    for i in work.matrix_pkg.X downto 0 loop
      for j in work.matrix_pkg.Y downto 0 loop
        write (l, ' ');
        write (l, mat(i,j));
      end loop;
      writeline (output, l);
    end loop;
    return 0; 
  end print_matrix;

  component board
    generic (
      init_state : work.matrix_pkg.matrix := ((0, 1, 0, 0, 0),
                                              (0, 0, 1, 0, 0),
                                              (1, 1, 1, 0, 0),
                                              (0, 0, 0, 0, 0),
                                              (0, 0, 0, 0, 0))
      );
    port (
      mat: inout work.matrix_pkg.matrix;
      clock: in integer range 0 to 1
      );
  end component;

  for board_1: board use entity work.board;
  
  signal mat: work.matrix_pkg.matrix;
  signal clock: integer range 0 to 1;
  
  begin
    board_1: board
      port map (mat => mat, clock => clock);
    process
    variable l: integer range 0 to 1;
    begin
      for i in 1 to 12 loop
        l := print_matrix(mat);
        clock <= 1 - clock;
        wait for 1 ns;
      end loop;
      wait;
    end process;
end arch;
