require_relative "lib/game_controller"
require_relative "lib/game_board"
require_relative "lib/player"

def print_instructions
  puts "Console-based Connect Four game"
  puts "-------------------------------"
  puts "Prior to playing the game, please decide among yourselves to be Player 1 or Player 2"
  puts "- Player 1 will be represented with red colour"
  puts "- Player 2 will be represented with yellow colour"
  puts "-------------------------------"
  puts "The goal for both players is to place 4 pieces in a row, column, or diagonal on the board."
  puts "-------------------------------"
  puts "START GAME"
end

print_instructions

game_board = GameBoard.new
player1 = Player.new("Player 1", :red)
player2 = Player.new("Player 2", :yellow)
game_controller = GameController.new(player1, player2, game_board)

loop do
  game_board.display
  player_move = game_controller.prompt_player_input

  unless (1..7).to_a.include?(player_move)
    puts "Invalid input: Please enter a valid column number"
    redo
  end

  unless game_board.available_columns.include?(player_move)
    puts "Invalid input: Please choose a valid column to place your piece"
    redo
  end

  game_controller.add_piece(player_move)

  if game_controller.player_win?
    game_board.display
    puts "Congratulations! #{game_controller.current_player.name} has won the game!"
    break
  elsif game_controller.draw_game?
    game_board.display
    puts "Oh... it seems like we have a draw!"
    break
  end

  game_controller.switch_turn
end
