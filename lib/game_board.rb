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
    puts "-------------------------------"
    puts "1  2  3  4  5  6  7"
    @board.each { |row| puts row.map(&:symbol).join("  ") }
    puts "-------------------------------"
  end

  def available_columns
    available_columns = []
    @board[0].each_with_index do |cell, col_index|
      available_columns << col_index + 1 if cell.empty?
    end
    available_columns
  end

  private

  def store_latest_move(cell)
    @latest_move = Matrix[*@board].index(cell)
  end
end
