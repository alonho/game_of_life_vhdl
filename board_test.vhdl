entity board_test is
end board_test;
use std.textio.all;


architecture arch of board_test is
  function ret1 (a: integer)
    return integer is
  begin
    return 1; 
  end ret1;

  function print_matrix(mat: work.matrix_pkg.matrix)
    return integer is
    variable l : line;  
  begin
    for i in 5 downto 1 loop
      for j in 5 downto 1 loop
        write (l, mat(i,j));
      end loop;
      writeline (output, l);
    end loop;
    return 0; 
  end print_matrix;

  component board
    port (
      mat: inout work.matrix_pkg.matrix := ((0, 0, 0, 0, 0, 0),
                                            (0, 0, 0, 0, 0, 0),
                                            (0, 0, 1, 1, 1, 0),
                                            (0, 0, 1, 1, 1, 0),
                                            (0, 0, 1, 0, 0, 0),
                                            (0, 0, 0, 0, 0, 0))
    );
  end component;

  for board_1: board use entity work.board;
  
  signal mat: work.matrix_pkg.matrix;
  
  begin
    board_1: board port map (mat => mat);
    process
    variable l: integer range 0 to 1;
    begin
      --mat(1, 1) <= 1;
      l := print_matrix(mat);
      --wait for 1 ns;
      --wait;
    end process;
end arch;
