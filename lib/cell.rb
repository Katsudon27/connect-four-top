require "colorize"

class Cell
  attr_reader :symbol

  def initialize
    @symbol = "\u25EF"
  end

  def add_piece(player)
    @symbol = player.symbol.colorize(player.colour)
  end
end
