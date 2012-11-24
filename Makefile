
all: test

cell:
	ghdl -a cell.vhdl

cell_test: cell
	ghdl -a cell_test.vhdl

board: cell
	ghdl -a board.vhdl

board_test: board
	ghdl -a board_test.vhdl

test: cell_test board_test 
	ghdl -r cell_test
	ghdl -r board_test

view_cell_test: cell_test
	ghdl -r cell_test --vcd=cell_test.vcd
	gtkwave cell_test.vcd
