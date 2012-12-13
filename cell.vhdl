entity cell is

  generic (
    start_alive : integer range 0 to 1 := 0
  );

  port (
    clock, left, right,
    upper_left, upper, upper_right,
    lower_left, lower, lower_right : in integer range 0 to 1;
    alive : inout integer range 0 to 1 := start_alive
  );

end cell;
 
architecture arch of cell is
begin
  
  process (clock)
    variable neighbors: integer range 0 to 8;
    begin
      neighbors := upper_left + upper + upper_right + left +
                   right + lower_left + lower + lower_right;
      if (neighbors = 3) or (alive = 1 and (neighbors) = 2) then
        alive <= 1;
      else
        alive <= 0;
      end if;
    end process;
    
end arch;
