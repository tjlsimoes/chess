# King class

class King
  attr_accessor :location, :unmoved
  attr_reader :symbol, :colour

  def initialize(symbol, location, unmoved = true)
    @symbol = symbol
    @location = location
    @colour = get_colour
    @unmoved = unmoved
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

    coordinates = location.split("")
    column_idx = columns.index(coordinates[0])

    column_vars = [coordinates[0], columns[column_idx + 1]]
    column_vars << columns[column_idx - 1] if column_idx - 1 >= 0

    row = coordinates[1].to_i
    column = coordinates[0]

    row_vars = [0]
    row_vars.push(-1) if row - 1 >= 1
    row_vars.push(1) if row + 1 <= 8

    possible_moves = []
    for i in column_vars do
      for j in row_vars do
        possible_moves << [i, row + j] unless i == column && j == 0 || i == nil
      end
    end

    possible_moves = possible_moves.map { |coordinates| coordinates.join}
  end
end