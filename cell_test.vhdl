entity cell_test is
end cell_test;

architecture arch of cell_test is
  
  component cell
    port (
      upper_left, upper, upper_right,
      left, right,
      lower_left, lower, lower_right : in integer range 0 to 1;
      alive : inout  integer range 0 to 1
    );
  end component;
  
  for cell_1: cell use entity work.cell;
  
  signal alive, upper_left, upper, upper_right, left, right,
    lower_left, lower, lower_right : integer range 0 to 1;
  
  begin
    cell_1: cell port map (upper_left => upper_left, upper => upper, upper_right => upper_right,
                           left => left, right => right,
                           lower_left => lower_left, lower => lower, lower_right => lower_right, alive => alive);
    
    process
    begin
      assert alive = 0
        report "cell should start as dead" severity error;
    
      left <= 1;
      right <= 1;
    
      wait for 1 ns;
      assert alive = 0
        report "cell should stay dead with only two neighbors" severity error;
    
      lower <= 1;
    
      wait for 1 ns;
      assert alive = 1
      report "cell should come to life" severity error;
    
      wait for 1 ns;
      assert alive = 1
        report "cell should stay alive" severity error;

      upper <= 1;
    
      wait for 1 ns;
      assert alive = 0
        report "cell should die from over-population" severity error;

      upper <= 0;

      wait for 1 ns;
      assert alive = 1
        report "cell should come to life" severity error;

      lower <= 0;
      wait for 1 ns;  
      assert alive = 1
        report "cell should stay alive" severity error;
    
      left <= 0;
      wait for 1 ns;
      assert alive = 0
        report "cell should die from under-population" severity error;
    
      wait;
    end process;
end arch;
