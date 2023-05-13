# Queen class

class Queen
  attr_accessor :location
  attr_reader :symbol, :colour

  def initialize(symbol, location)
    @symbol = symbol
    @location = location
    @colour = get_colour
  end

  def get_colour
    if symbol == "\u2655"
      "white"
    else
      "black"
    end
  end

  def possible_moves
    columns = ["a", "b", "c", "d", "e", "f", "g", "h"]

    possible_moves = []

    coordinates = location.split("")
    row = coordinates[1].to_i

    column_idx = columns.index(coordinates[0])

    i = 0
    while i < columns.length do
      if columns[i] != coordinates[0]
        difference = (column_idx - i).abs

        possible_moves << [columns[i], row + difference].join if row + difference <= 8
        possible_moves << [columns[i], row - difference].join if row - difference >= 0
      end

      i += 1
    end

    columns.delete(coordinates[0])
    column_vars = columns

    rows = Array(1..8)
    rows.delete(row) # Remove location's row.
    row_vars = rows

    for i in column_vars do
      possible_moves << [i, coordinates[1]].join
    end

    for i in row_vars do
      possible_moves << [coordinates[0], i].join
    end

    possible_moves

  end
end