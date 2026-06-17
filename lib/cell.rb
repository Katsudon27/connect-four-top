require "colorize"

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
