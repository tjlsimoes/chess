# King class

class King
  attr_accessor :location
  attr_reader :symbol, :colour

  def initialize(symbol, location)
    @symbol = symbol
    @location = location
    @colour = get_colour
  end

  def get_colour
    if symbol == "\u2654"
      "black"
    else
      "white"
    end
  end

  def possible_moves
    columns = ["a", "b", "c", "d", "e", "f", "g", "h"]
    row_vars = [1, 0, -1]

    coordinates = location.split("")
    column_idx = columns.index(coordinates[0])

    column_vars = [columns[column_idx - 1], coordinates[0], columns[column_idx + 1]]

    row = coordinates[1].to_i
    column = coordinates[0]
    coordinates = [column, row]


    possible_moves = []
    for i in column_vars do
      for j in row_vars do
        possible_moves << [i, coordinates[1] + j] unless i == coordinates[0] && j == 0 || i == nil
      end
    end

    possible_moves = possible_moves.map { |coordinates| coordinates.join}
  end
end