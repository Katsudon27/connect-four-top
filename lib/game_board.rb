require_relative "cell"

class GameBoard
  def initialize
    @board = Array.new(6) { Array.new(7) { Cell } }
  end
end
