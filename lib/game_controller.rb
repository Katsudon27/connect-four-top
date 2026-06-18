require_relative "game_board"
require_relative "player"

# Controls the flow of the Tic Tac Toe game
class GameController
  def initialize(player1, player2, game_board)
    @player1 = player1
    @player2 = player2
    @game_board = game_board
    @current_player = @player1
  end

  def switch_turn
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def draw_game?
    @game_board.cells_empty?
  end
end
