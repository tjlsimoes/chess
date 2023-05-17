# Pawn class

class Pawn
  attr_accessor :location, :unmoved
  attr_reader :symbol, :colour

  def initialize(symbol, location, unmoved = true)
    @symbol = symbol
    @location = location
    @colour = get_colour
    @unmoved = unmoved
  end

  def get_colour
    if symbol == "\u2659"
      "black"
    else
      "white"
    end
  end

  def possible_moves
    coordinates = location.split("")
    row = coordinates[1].to_i

      if colour == "white"
        white_possible_moves(coordinates, row)
      else
        black_possible_moves(coordinates, row)
      end
  end

  def white_possible_moves(coordinates, row)
    possible_moves = []

      if @unmoved 
        possible_moves << [coordinates[0], row + 1].join if row + 1 <= 8
        possible_moves << [coordinates[0], row + 2].join if row + 2 <= 8
      else
        possible_moves << [coordinates[0], row + 1].join if row + 1 <= 8
      end

    possible_moves
  end

  def black_possible_moves(coordinates, row)
    possible_moves = []

    if @unmoved 
      possible_moves << [coordinates[0], row - 1].join if row - 1 >= 0
      possible_moves << [coordinates[0], row - 2].join if row - 2 >= 0
    else
      possible_moves << [coordinates[0], row - 1].join if row - 1 >= 0
    end

    possible_moves
  end
end