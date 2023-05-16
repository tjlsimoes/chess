# Rook/Tower class

class Rook
  attr_accessor :location
  attr_reader :symbol, :colour

  def initialize(symbol, location)
    @symbol = symbol
    @location = location
    @colour = get_colour
  end

  def get_colour
    if symbol == "\u2656"
      "black"
    else
      "white"
    end
  end

  def possible_moves
    coordinates = location.split("")

    columns = ["a", "b", "c", "d", "e", "f", "g", "h"]
    columns.delete(coordinates[0])
    column_vars = columns

    rows = Array(1..8)
    rows.delete(coordinates[1].to_i)
    row_vars = rows

    possible_moves = []

    for i in column_vars do
      possible_moves << [i, coordinates[1]].join
    end

    for i in row_vars do
      possible_moves << [coordinates[0], i].join
    end

    possible_moves
  end
end