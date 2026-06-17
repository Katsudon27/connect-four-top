class Player
  def initialize(name, colour)
    @name = name
    @symbol = "\u25CF"
    @colour = colour
  end

  def choose_column
    puts "#{@name}'s turn: Please choose a valid column (1 - 7) to place your piece"
    gets.chomp.to_i
  end
end
