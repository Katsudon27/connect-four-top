require "colorize"

# A class that represents a cell on the game board for the Connect Four game
class Cell
  attr_reader :symbol, :empty

  def initialize
    @symbol = "\u25EF"
  end

  def add_piece(player)
    @symbol = player.symbol
  end

  def empty?
    @symbol == "\u25EF"
  end
end
