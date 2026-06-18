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
    horizontal_win? || vertical_win? || asc_diagonal_win? || desc_diagonal_win?
  end

  private

  def horizontal_win?
    board = @game_board.board
    board.each_with_index do |row, row_idx|
      row.each_with_index do |cell, col_idx|
        break if col_idx > 4

        if cell.symbol == @current_player.symbol && board[row_idx][col_idx + 1].symbol == @current_player.symbol && board[row_idx][col_idx + 2].symbol == @current_player.symbol && board[row_idx][col_idx + 3].symbol == @current_player.symbol
          return true
        end
      end
    end
    false
  end

  def vertical_win?
    board = @game_board.board
    board.each_with_index do |row, row_idx|
      break if row_idx > 2

      row.each_with_index do |cell, col_idx|
        if cell.symbol == @current_player.symbol && board[row_idx + 1][col_idx].symbol == @current_player.symbol && board[row_idx + 2][col_idx].symbol == @current_player.symbol && board[row_idx + 3][col_idx].symbol == @current_player.symbol
          return true
        end
      end
    end
    false
  end

  def asc_diagonal_win?
    board = @game_board.board
    board.each_with_index do |row, row_idx|
      next if row_idx < 3

      row.each_with_index do |cell, col_idx|
        break if col_idx > 4

        if cell.symbol == @current_player.symbol && board[row_idx - 1][col_idx + 1].symbol == @current_player.symbol && board[row_idx - 2][col_idx + 2].symbol == @current_player.symbol && board[row_idx - 3][col_idx + 3].symbol == @current_player.symbol
          return true
        end
      end
    end
    false
  end

  def desc_diagonal_win?
    board = @game_board.board
    board.each_with_index do |row, row_idx|
      next if row_idx < 3

      row.each_with_index do |cell, col_idx|
        next if col_idx < 3

        if cell.symbol == @current_player.symbol && board[row_idx - 1][col_idx - 1].symbol == @current_player.symbol && board[row_idx - 2][col_idx - 2].symbol == @current_player.symbol && board[row_idx - 3][col_idx - 3].symbol == @current_player.symbol
          return true
        end
      end
    end
    false
  end
end
