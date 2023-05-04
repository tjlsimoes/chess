# Pawn class

class Pawn
  attr_accessor :location
  attr_reader :symbol
  def initialize(symbol, location)
    @symbol = symbol
    @location = location
  end

  def possible_moves

  end
end