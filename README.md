# connect-four-top

A simple console-based Connect Four game made with OOP and TDD in Ruby.

## Usage instruction
    `ruby main.rb`

## Challenges
The biggest challenge that I encountered working on this project is the algorithm used for determining the winner of the game. I started with an initial attempt that looped through each cell of the board to determine if each player has cells that are placed horizontally, vertically or diagonally in a row.

While the initial solution worked, it was not quite efficient because it loops through the entire board each time the method was called and I could tell there were some redundant code, so I embarked on a journey with extensive troubleshooting between rspec and playing the game myself. I am quite happy with the end result that is much elegant than the previous solution.
