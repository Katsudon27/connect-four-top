require_relative "cell"
require "matrix"

class GameBoard
  attr_reader :board, :latest_move

  def initialize
    @board = Array.new(6) { Array.new(7) { Cell.new } }
  end

  def add_piece(col_num, player)
    @board.transpose[col_num - 1].reverse.each do |cell|
      next unless cell.empty?

      cell.add_piece(player)
      store_latest_move(cell)
      break
    end
  end

  def display
    @board.each { |row| puts row.map(&:symbol).join("  ") }
  end

  def cells_empty?
    @board.each do |row|
      row.each do |cell|
        return true if cell.empty?
      end
    end
    false
  end

  private

  def store_latest_move(cell)
    @latest_move = Matrix[*@board].index(cell)
  end
end
