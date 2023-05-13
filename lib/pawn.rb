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
      "white"
    else
      "black"
    end
  end

  def possible_moves
    columns = ["a", "b", "c", "d", "e", "f", "g", "h"]
    possible_moves = []

    coordinates = location.split("")
    column_idx = columns.index(coordinates[0])
    row = coordinates[1].to_i

    column_vars = [columns[column_idx], columns[column_idx + 1]]
    column_vars << columns[column_idx - 1] if column_idx - 1 > 0

    for i in column_vars do
      if @unmoved && i == coordinates[0]
        possible_moves << [i, row + 1].join if row + 1 <= 8
        possible_moves << [i, row + 2].join if row + 1 <= 8
      else
        possible_moves << [i, row + 1].join if row + 1 <= 8
      end
    end

    possible_moves
  end
end