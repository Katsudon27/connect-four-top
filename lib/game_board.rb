require_relative "cell"

class GameBoard
  def initialize
    @board = Array.new(6) { Array.new(7) { Cell.new } }
  end

  def add_piece(col_num, player)
    @board.transpose[col_num - 1].reverse.each do |cell|
      if cell.empty?
        cell.add_piece(player)
        break
      end
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
end
