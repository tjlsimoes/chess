require_relative "rook.rb"
require_relative "knight.rb"
require_relative "bishop.rb"
require_relative "king.rb"
require_relative "queen.rb"
require_relative "pawn.rb"
# Chess board

class Board
  attr_reader :cells

  def initialize
    @cells = initial_board
  end

  def show
    scells = @cells.map do |value|
      if value == nil
        ' '
      else
        value.symbol
      end

    end
    puts <<-HEREDOC
      -----------------------------------------
      | 8     | #{scells[64]} | #{scells[63]} | #{scells[62]} | #{scells[61]} | #{scells[60]} | #{scells[59]} | #{scells[58]} | #{scells[57]} |
      -----------------------------------------
      | 7     | #{scells[56]} | #{scells[55]} | #{scells[54]} | #{scells[53]} | #{scells[52]} | #{scells[51]} | #{scells[50]} | #{scells[49]} |
      -----------------------------------------
      | 6     | #{scells[48]} | #{scells[47]} | #{scells[46]} | #{scells[45]} | #{scells[44]} | #{scells[43]} | #{scells[42]} | #{scells[41]} |
      -----------------------------------------
      | 5     | #{scells[40]} | #{scells[39]} | #{scells[38]} | #{scells[37]} | #{scells[36]} | #{scells[35]} | #{scells[34]} | #{scells[33]} |
      -----------------------------------------
      | 4     | #{scells[32]} | #{scells[31]} | #{scells[30]} | #{scells[29]} | #{scells[28]} | #{scells[27]} | #{scells[26]} | #{scells[25]} |
      -----------------------------------------
      | 3     | #{scells[24]} | #{scells[23]} | #{scells[22]} | #{scells[21]} | #{scells[20]} | #{scells[19]} | #{scells[18]} | #{scells[17]} |
      -----------------------------------------
      | 2     | #{scells[16]} | #{scells[15]} | #{scells[14]} | #{scells[13]} | #{scells[12]} | #{scells[11]} | #{scells[10]} | #{scells[9]} |
      -----------------------------------------
      | 1     | #{scells[8]} | #{scells[7]} | #{scells[6]} | #{scells[5]} | #{scells[4]} | #{scells[3]} | #{scells[2]} | #{scells[1]} |
      -----------------------------------------
              ---------------------------------
              | a | b | c | d | e | f | g | h |
              ---------------------------------
    HEREDOC
  end

  def initial_board
    cells = Array.new(65)
    columns = ["a", "b", "c", "d", "e", "f", "g", "h"]

    # Black chess pieces.

    cells[57] = Rook.new("\u265C", "h8")
    cells[64] = Rook.new("\u265C", "a8")

    cells[58] = Knight.new("\u265E", "g8")
    cells[63] = Knight.new("\u265E", "b8")

    cells[59] = Bishop.new("\u265D", "f8")
    cells[62] = Bishop.new("\u265D", "c8")

    cells[60] = Queen.new("\u265A", "d8")
    cells[61] = King.new("\u265B", "e8")

    for i in (49..56) do

      if i % 8 != 0
        number = (i / 8) + 1
        letter = columns[8 - (i % 8)]
      else
        number = i % 8
        letter = "a"
      end
      location = [letter, number].join

      cells[i] = Pawn.new("\u265F", location)
    end

    # White chess pieces.

    cells[1] = Rook.new("\u2656", "h1")
    cells[8] = Rook.new("\u2656", "a1")

    cells[2] = Knight.new("\u2658", "g1")
    cells[7] = Knight.new("\u2658", "b1")

    cells[3] = Bishop.new("\u2657", "f1")
    cells[6] = Bishop.new("\u2657", "c1")

    cells[4] = King.new("\u2654", "e1")
    cells[5] = Queen.new("\u2655", "d1")

    for i in (9..16) do

      if i % 8 != 0
        number = (i / 8) + 1
        letter = columns[8 - (i % 8)]
      else
        number = i % 8
        letter = "a"
      end

      location = [letter, number].join

      cells[i] = Pawn.new("\u2659", location)
    end

    cells
  end

  def diag_right_up?(start_loc_col, end_loc_col, start_loc_row, end_loc_row)
    end_loc_col > start_loc_col && end_loc_row > start_loc_row
  end
  
  def diag_right_down?(start_loc_col, end_loc_col, start_loc_row, end_loc_row)
    end_loc_col > start_loc_col && start_loc_row > end_loc_row
  end
  
  def diag_left_up?(start_loc_col, end_loc_col, start_loc_row, end_loc_row)
    start_loc_col > end_loc_col && end_loc_row > start_loc_row
  end
  
  def diag_left_down?(start_loc_col, end_loc_col, start_loc_row, end_loc_row)
    start_loc_col > end_loc_col && start_loc_row > end_loc_row
  end

  def intermediate_squares(user_input)

    start_loc = user_input[0]
    end_loc = user_input[1]
  
    start_loc_col = start_loc[0]
    start_loc_row = start_loc[1].to_i
  
    end_loc_col = end_loc[0]
    end_loc_row = end_loc[1].to_i
  
    # No precaution here set for same end and
    # starting location.
  
    intermediate_squares = []
    columns = ["a", "b", "c", "d", "e", "f", "g", "h"]
  
    if start_loc_col == end_loc_col # vertical movement
  
      if start_loc_row > end_loc_row # downwards
  
        i = start_loc_row - 1
        while i > end_loc_row
  
          intermediate_squares << [start_loc_col, i].join
          i -= 1
        end
  
      else # upwards
  
        i = start_loc_row + 1
        while i < end_loc_row
  
          intermediate_squares << [start_loc_col, i].join
          i += 1
        end
      end
  
    elsif start_loc_row == end_loc_row # horizontal movement
  
      if start_loc_col > end_loc_col # to the left
  
        i = columns.index(start_loc_col) - 1
        while i > columns.index(end_loc_col)
  
          intermediate_squares << [columns[i], start_loc_row].join
          i -= 1
        end
      else # to the right
  
        i = columns.index(start_loc_col) + 1
        while i < columns.index(end_loc_col)
  
          intermediate_squares << [columns[i], start_loc_row].join
          i += 1
        end
      end
  
    elsif diag_right_up?(start_loc_col, end_loc_col, start_loc_row, end_loc_row)
  
      j = start_loc_row + 1
      i = columns.index(start_loc_col) + 1
      while i < columns.index(end_loc_col) && j < end_loc_row
  
        intermediate_squares << [columns[i], j].join
  
        i += 1
        j += 1
      end
  
    elsif diag_right_down?(start_loc_col, end_loc_col, start_loc_row, end_loc_row)
  
      j = start_loc_row - 1
      i = columns.index(start_loc_col) + 1
      while i < columns.index(end_loc_col) && j > end_loc_row
  
        intermediate_squares << [columns[i], j].join
  
        i += 1
        j -= 1
      end
  
    elsif diag_left_up?(start_loc_col, end_loc_col, start_loc_row, end_loc_row)
  
      j = start_loc_row + 1
      i = columns.index(start_loc_col) - 1
      while i > columns.index(end_loc_col) && j < end_loc_row
  
        intermediate_squares << [columns[i], j].join
  
        i -= 1
        j += 1
      end
  
    elsif diag_left_down?(start_loc_col, end_loc_col, start_loc_row, end_loc_row)
  
      j = start_loc_row - 1
      i = columns.index(start_loc_col) - 1
      while i > columns.index(end_loc_col) && j > end_loc_row
  
        intermediate_squares << [columns[i], j].join
  
        i -= 1
        j -= 1
      end
    end
  
    intermediate_squares
  end

  def valid_move?()
    
  end

  def game_over?
    
  end

  def update_board()
  
  end
end
