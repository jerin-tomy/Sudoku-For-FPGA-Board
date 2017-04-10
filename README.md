# Sudoku-For-FPGA-Board

The following is a color-based implementation of Sudoku written in Verilog for the Nexys3 FPGA board.
The VGA output was used to display our current state of the board.
Buttons on the Nexys3 FPGA board were utilized to allow the player to navigate and change the state of the Sudoku grid.
The seven segment display on the board showd the amount of time left for the game while the game 
was still running, or the current and high score when the game ended.
Additionally,a switch was used that allowed players to reset the state of the game while maintaining the current high score.
These features allowed us to create a new game in the case that the player wanted to start over.
