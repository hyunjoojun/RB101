Tic Tac Toe is a 2 player game played on a 3x3 board.
Each player takes a turn and marks a square on the board.
First player to reach 3 squares in a row, including diagonals, wins.
If all 9 squares are marked and no player has 3 squares in a row,
then the game is a tie.

1. Display the initial empty 3x3 board.
2. Ask the user to mark a square.
3. Computer marks a square.
4. Display the updated board state.
5. If winner, display winner.
6. If board is full, display tie.
7. If neither winner nor board is full, go to #2
8. Play again?
9. If yes, go to #1
10. Good bye!

1. Display the 3x3 board.
- Set the length of empty spaces.
- Use string interpolation to create a line.
- Display strings line by line to create the board.
     |     |
     |     |
-----+-----+-----
     |     |
     |     |
-----+-----+-----
     |     |
     |     |
2. The user marks a square.
- Get user's input to choose one box. (1 to 9)
- Choose a line to mark according to the user's input.
- Delete one empty space and replace it with X.
3. Computer marks a square.
- Choose a box randomly except the ones that user already chose.
- Choose a line to mark accordingly.
- Delete one empty space and replace it with X.
4. Display the updated board state.
