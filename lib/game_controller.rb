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

  def player_win?
    board = @game_board.board
    row, col = @game_board.latest_move
    directions = [[0, 1], [1, 0], [1, 1], [1, -1], [0, -1], [-1, 0], [-1, -1], [-1, 1]]
    count = 1
    directions.each do |direction|
      row_delta, col_delta = direction
      row_temp = row + row_delta
      col_temp = col + col_delta

      while within_array_boundary?(row_temp, col_temp) && board[row_temp][col_temp].symbol == @current_player.symbol
        count += 1
        row_temp += row_delta
        col_temp += col_delta
      end

      return true if count >= 4
    end
    count >= 4
  end

  private

  def within_array_boundary?(row, col)
    row >= 0 && row < 6 && col >= 0 && col < 7
  end
end
