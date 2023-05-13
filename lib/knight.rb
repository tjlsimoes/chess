# Knight class

class Knight
  attr_accessor :location
  attr_reader :symbol, :colour

  def initialize(symbol, location)
    @symbol = symbol
    @location = location
    @colour = get_colour
  end

  def get_colour
    if symbol == "\u2658"
      "white"
    else
      "black"
    end
  end

  def possible_moves

    columns = ["a", "b", "c", "d", "e", "f", "g", "h"]

    coordinates = location.split("")
    column_idx = columns.index(coordinates[0])

    possible_moves = []

    [-2, -1, 1, 2].each do |shift|

      new_column = columns[column_idx + shift]

      if shift.abs == 2
        possible_moves << [new_column, coordinates[1].to_i + 1].join
        possible_moves << [new_column, coordinates[1].to_i - 1].join
      else
        possible_moves << [new_column, coordinates[1].to_i + 2].join
        possible_moves << [new_column, coordinates[1].to_i - 2].join
      end

    end

    possible_moves
  end
end