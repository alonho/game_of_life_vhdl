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
    writeline (output, l);
    for i in work.matrix_pkg.X downto 1 loop
      for j in work.matrix_pkg.Y downto 1 loop
        write (l, mat(i,j));
      end loop;
      writeline (output, l);
    end loop;
    return 0; 
  end print_matrix;

  component board
    port (
      mat: inout work.matrix_pkg.matrix;
      clock: in integer range 0 to 1
    );
  end component;

  for board_1: board use entity work.board;
  
  signal mat: work.matrix_pkg.matrix;
  signal clock: integer range 0 to 1;
  
  begin
    board_1: board port map (mat => mat, clock => clock);
    process
    variable l: integer range 0 to 1;
    begin
      mat(0,3) <= 1;
      mat(0,4) <= 1;
      mat(0,5) <= 1;
      mat(0,6) <= 1;
      mat(0,7) <= 1;
      mat(0,8) <= 1;
      mat(0,9) <= 1;
      
      clock <= 1 - clock;
      wait for 1 ns;
      l := print_matrix(mat);

      --mat(0,3) <= 0;
      --mat(0,4) <= 0;
      --mat(0,5) <= 0;
      --mat(0,6) <= 0;
      --mat(0,7) <= 0;
      for i in 1 to 20 loop
        clock <= 1 - clock;
        wait for 1 ns;
        l := print_matrix(mat);
      end loop;
      wait;
    end process;
end arch;
