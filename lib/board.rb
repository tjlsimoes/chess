require_relative "rook.rb"
require_relative "knight.rb"
require_relative "bishop.rb"
require_relative "king.rb"
require_relative "queen.rb"
require_relative "pawn.rb"

# Chess board

class Board
  attr_accessor :white_king_loc, :black_king_loc,
                :cells, :en_passant

  def initialize
    @white_king_loc = "e1"
    @black_king_loc = "e8"
    @cells = initial_board
    @en_passant = []
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

    # Black chess pieces (due to colour contrast with CLI).

    cells[57] = Rook.new("\u2656", "h8")
    cells[64] = Rook.new("\u2656", "a8")

    cells[58] = Knight.new("\u2658", "g8")
    cells[63] = Knight.new("\u2658", "b8")

    cells[59] = Bishop.new("\u2657", "f8")
    cells[62] = Bishop.new("\u2657", "c8")

    cells[61] = Queen.new("\u2655", "d8")
    cells[60] = King.new("\u2654", "e8")

    for i in (49..56) do

      if i % 8 != 0
        number = (i / 8) + 1
        letter = columns[8 - (i % 8)]
      else
        number = i / 8
        letter = "a"
      end
      location = [letter, number].join

      cells[i] = Pawn.new("\u2659", location)
    end

    # White chess pieces (due to contrast with CLI).

    cells[1] = Rook.new("\u265C", "h1")
    cells[8] = Rook.new("\u265C", "a1")

    cells[2] = Knight.new("\u265E", "g1")
    cells[7] = Knight.new("\u265E", "b1")

    cells[3] = Bishop.new("\u265D", "f1")
    cells[6] = Bishop.new("\u265D", "c1")

    cells[4] = King.new("\u265A", "e1")
    cells[5] = Queen.new("\u265B", "d1")

    for i in (9..16) do

      if i % 8 != 0
        number = (i / 8) + 1
        letter = columns[8 - (i % 8)]
      else
        number = i / 8
        letter = "a"
      end

      location = [letter, number].join

      cells[i] = Pawn.new("\u265F", location)
    end

    cells
  end

  def notation_to_cell(coordinate)
    columns = ["a", "b", "c", "d", "e", "f", "g", "h"]
    column = coordinate[0]
    row = coordinate[1].to_i

    cell = row * 8 - columns.index(column)
  end

  def nil_or_opponent?(idx_start, idx_end)
    cells[idx_end].nil? || cells[idx_start].colour != cells[idx_end].colour
  end

  def opponent?(idx_start, idx_end)
    if cells[idx_end].nil?
      false
    elsif cells[idx_start].colour != cells[idx_end].colour
      true
    end
  end

  def unmoved?(idx)
    cells[idx].unmoved == true
  end

  def rook_queen_bishop?(idx)
    cells[idx].kind_of?(Rook) || cells[idx].kind_of?(Queen) || cells[idx].kind_of?(Bishop)
  end

  def take_en_passant?(user_input)
    en_passant.include?(user_input) || en_passant == user_input
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

  def same_row?(start_loc, end_loc)
    start_loc[1] == end_loc[1]
  end

  def king_and_rook?(idx_start, idx_end)
    cells[idx_start].is_a?(King) && cells[idx_end].is_a?(Rook)
  end

  def castling?(idx_start_loc, idx_end_loc, start_loc, end_loc)
    king_and_rook?(idx_start_loc, idx_end_loc) &&
      !opponent?(idx_start_loc, idx_end_loc) &&
        same_row?(start_loc, end_loc)
  end

  def castling_end_locations(start_loc, end_loc)
    columns = %w[a b c d e f g h]
    start_loc_col_idx = columns.index(start_loc[0])

    if start_loc[0] > end_loc[0]
      king_end_loc = [columns[start_loc_col_idx - 2], start_loc[1]].join
      rook_end_loc = [columns[start_loc_col_idx - 1], start_loc[1]].join
    else
      king_end_loc = [columns[start_loc_col_idx + 2], start_loc[1]].join
      rook_end_loc = [columns[start_loc_col_idx + 1], start_loc[1]].join
    end

    [king_end_loc, rook_end_loc]
  end

  def unmoved_pawn_twosq?(idx_start_loc, start_loc, end_loc)
    # Assuming #update_board will only be called on valid
    # two square pawn movements.
    columns = %w[a b c d e f g h]

    row_start = start_loc[1].to_i
    row_end = end_loc[1].to_i

    row_diff = (row_start - row_end).abs

    cells[idx_start_loc].is_a?(Pawn) && row_diff == 2
  end

  def aside(end_loc)
    columns = %w[a b c d e f g h]

    end_column_idx = columns.index(end_loc[0])
    column_var = [columns[end_column_idx + 1]] if end_column_idx + 1 < 8

    return nil if column_var.nil?

    aside = [column_var, end_loc[1]].join
  end

  def aside_opponent_pawn?(idx_start_loc, end_loc)
    moved_pawn_colour = cells[idx_start_loc].colour

    return false if aside(end_loc).nil?

    idx_aside = notation_to_cell(aside(end_loc))

    cells[idx_aside].is_a?(Pawn) &&
      cells[idx_aside].colour != moved_pawn_colour
  end

  def bside(end_loc)
    columns = %w[a b c d e f g h]

    end_column_idx = columns.index(end_loc[0])
    column_var = columns[end_column_idx - 1] if end_column_idx - 1 > 0

    return nil if column_var.nil?

    bside = [column_var, end_loc[1]].join
  end

  def bside_opponent_pawn?(idx_start_loc, end_loc)
    moved_pawn_colour = cells[idx_start_loc].colour

    return false if bside(end_loc).nil?

    idx_bside = notation_to_cell(bside(end_loc))

    cells[idx_bside].is_a?(Pawn) &&
      cells[idx_bside].colour != moved_pawn_colour
  end

  def absides_opponent_pawns?(idx_start_loc, end_loc)
    aside_opponent_pawn?(idx_start_loc, end_loc) &&
      bside_opponent_pawn?(idx_start_loc, end_loc)
  end

  # Upwards and downwards relative to pawn that
  # makes a two square movement and is to be
  # possibly taken on the next move.

  # For example. Vertical downwards is being
  # thought as a movement of a black pawn from
  # "e7" to "e5" that opens a possibily, for
  # example, of a white pawn located at "f5"
  # to take that black pawn, making a move
  # "f5" to "e6".

  def bside_vd_en_passant(start_loc, end_loc, start_loc_row) # Vertical downwards
    en_pass_end_row = start_loc_row - 1
    en_pass_end_loc = [start_loc[0], en_pass_end_row].join

    [bside(end_loc), en_pass_end_loc]
  end

  def aside_vd_en_passant(start_loc, end_loc, start_loc_row) # Vertical downwards
    en_pass_end_row = start_loc_row - 1
    en_pass_end_loc = [start_loc[0], en_pass_end_row].join

    [aside(end_loc), en_pass_end_loc]
  end

  def bside_vu_en_passant(start_loc, end_loc, start_loc_row) # Vertical upwards
    en_pass_end_row = start_loc_row + 1
    en_pass_end_loc = [start_loc[0], en_pass_end_row].join

    [bside(end_loc), en_pass_end_loc]
  end

  def aside_vu_en_passant(start_loc, end_loc, start_loc_row) # Vertical upwards
    en_pass_end_row = start_loc_row + 1
    en_pass_end_loc = [start_loc[0], en_pass_end_row].join

    [aside(end_loc), en_pass_end_loc]
  end

  def vd_en_passant(start_loc, end_loc, start_loc_row, idx_start_loc)
    if absides_opponent_pawns?(idx_start_loc, end_loc)
      possible_en_passant = []
      possible_en_passant << aside_vd_en_passant(start_loc, end_loc, start_loc_row)
      possible_en_passant << bside_vd_en_passant(start_loc, end_loc, start_loc_row)
    elsif bside_opponent_pawn?(idx_start_loc, end_loc)
      bside_vd_en_passant(start_loc, end_loc, start_loc_row)
    elsif aside_opponent_pawn?(idx_start_loc, end_loc)
      aside_vd_en_passant(start_loc, end_loc, start_loc_row)
    end
  end

  def vu_en_passant(start_loc, end_loc, start_loc_row, idx_start_loc)
    if absides_opponent_pawns?(idx_start_loc, end_loc)
      possible_en_passant = []
      possible_en_passant << aside_vu_en_passant(start_loc, end_loc, start_loc_row)
      possible_en_passant << bside_vu_en_passant(start_loc, end_loc, start_loc_row)
    elsif bside_opponent_pawn?(idx_start_loc, end_loc)
      bside_vu_en_passant(start_loc, end_loc, start_loc_row)
    elsif aside_opponent_pawn?(idx_start_loc, end_loc)
      aside_vu_en_passant(start_loc, end_loc, start_loc_row)
    end
  end

  def possible_en_passant(start_loc, end_loc, idx_start_loc)
    start_loc_row = start_loc[1].to_i
    end_loc_row = end_loc[1].to_i

    if start_loc_row > end_loc_row # vertical downwards
      vd_en_passant(start_loc, end_loc, start_loc_row, idx_start_loc)
    else # vertical upwards
      vu_en_passant(start_loc, end_loc, start_loc_row, idx_start_loc)
    end
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

  def pawn_valid_move?(start_loc, end_loc, idx_start_loc, idx_end_loc, user_input)
    columns = ["a", "b", "c", "d", "e", "f", "g", "h"]

    start_column = columns.index(start_loc[0])
    column_vars = [columns[start_column + 1]]
    column_vars << columns[start_column - 1] if start_column - 1 > 0

    if cells[idx_start_loc].possible_moves.include?(end_loc) && intermediate_squares(user_input).all? { |square| cells[notation_to_cell(square)] == nil} && cells[idx_end_loc].nil?
      true
    elsif column_vars.include?(end_loc[0]) && end_loc[1].to_i == start_loc[1].to_i + 1 && opponent?(idx_start_loc, idx_end_loc)
      true
    elsif column_vars.include?(end_loc[0]) && end_loc[1].to_i == start_loc[1].to_i - 1 && opponent?(idx_start_loc, idx_end_loc)
      true
    else
      false
    end
  end

  def castling_valid_move?(start_loc, end_loc, idx_start_loc, idx_end_loc)
    locs_end = castling_end_locations(start_loc, end_loc)
    king_end_loc = locs_end[0]

    king_colour = cells[idx_start_loc].colour

    unmoved?(idx_start_loc) && unmoved?(idx_end_loc) &&
      intermediate_squares([start_loc, end_loc]).all? { |coordinates| cells[notation_to_cell(coordinates)] == nil } &&
        intermediate_squares([start_loc, king_end_loc]).all? { |coordinates| !check?(coordinates, king_colour) } &&
          !check?(start_loc, king_colour) && !check?(king_end_loc, king_colour)
  end

  def valid_move?(user_input)
    start_loc = user_input[0]
    end_loc = user_input[1]

    idx_start_loc = notation_to_cell(user_input[0])
    idx_end_loc = notation_to_cell(user_input[1])

    return true if take_en_passant?(user_input)

    if rook_queen_bishop?(idx_start_loc)
      cells[idx_start_loc].possible_moves.include?(end_loc) && nil_or_opponent?(idx_start_loc, idx_end_loc) &&
        intermediate_squares(user_input).all? { |square| cells[notation_to_cell(square)] == nil}
    elsif cells[idx_start_loc].is_a?(Pawn)
      pawn_valid_move?(start_loc, end_loc, idx_start_loc, idx_end_loc, user_input)
    elsif castling?(idx_start_loc, idx_end_loc, start_loc, end_loc)
      castling_valid_move?(start_loc, end_loc, idx_start_loc, idx_end_loc)
    else
      cells[idx_start_loc].possible_moves.include?(end_loc) && nil_or_opponent?(idx_start_loc, idx_end_loc)
    end
  end

  def game_over?
    checkmate?(white_king_loc) || checkmate?(black_king_loc)
  end

  def unmoved_pawn?(idx)
    cells[idx].is_a?(Pawn) && cells[idx].unmoved == true
  end

  def black_king?(idx)
    cells[idx].is_a?(King) && cells[idx].colour == "black"
  end

  def white_king?(idx)
    cells[idx].is_a?(King) && cells[idx].colour == "white"
  end

  def king_valid_moves(loc)
    poss_moves = cells[notation_to_cell(loc)].possible_moves
    valid_moves = poss_moves.select { |move| valid_move?([loc, move]) }
  end

  def castling_board_update(idx_start_loc, idx_end_loc, locs_end, locs_end_idx)
    @en_passant = []

    cells[idx_start_loc].location = locs_end[0]
    cells[idx_start_loc].unmoved = false
    cells[locs_end_idx[0]] = cells[idx_start_loc]

    cells[idx_end_loc].location = locs_end[1]
    cells[idx_end_loc].unmoved = false
    cells[locs_end_idx[1]] = cells[idx_end_loc]

    cells[idx_start_loc] = nil
    cells[idx_end_loc] = nil
  end

  def default_board_update(idx_start_loc, idx_end_loc, end_loc)
    cells[idx_start_loc].location = end_loc
    cells[idx_end_loc] = cells[idx_start_loc]
    cells[idx_start_loc] = nil

    cells[idx_end_loc].unmoved = false if unmoved_pawn?(idx_end_loc)
  end

  def kings_loc_update(idx_end_loc, end_loc)
    @white_king_loc = end_loc if white_king?(idx_end_loc)
    @black_king_loc = end_loc if black_king?(idx_end_loc)
  end

  def update_board(user_input)
    start_loc = user_input[0]
    end_loc = user_input[1]

    idx_start_loc = notation_to_cell(user_input[0])
    idx_end_loc = notation_to_cell(user_input[1])

    if castling?(idx_start_loc, idx_end_loc, start_loc, end_loc)
      @en_passant = []

      locs_end = castling_end_locations(start_loc, end_loc)
      locs_end_idx = locs_end.map { |notation| notation_to_cell(notation) }

      castling_board_update(idx_start_loc, idx_end_loc, locs_end, locs_end_idx)

      # For posterior king locations' instance variables redefinitions.
      idx_end_loc = locs_end_idx[0]
      end_loc = locs_end[0]

    elsif unmoved_pawn_twosq?(idx_start_loc, start_loc, end_loc)
      @en_passant = possible_en_passant(start_loc, end_loc, idx_start_loc)
      default_board_update(idx_start_loc, idx_end_loc, end_loc)
    else
      @en_passant = []
      default_board_update(idx_start_loc, idx_end_loc, end_loc)
    end

    kings_loc_update(idx_end_loc, end_loc)
  end

  # def check?(king_loc)
  #   if cells[notation_to_cell(king_loc)].colour == "white"
  #     cells.any? do |value|
  #       if !value.nil?
  #         value.colour != "white" && valid_move?([value.location, king_loc])
  #       end
  #     end
  #   else
  #     cells.any? do |value|
  #       if !value.nil?
  #         value.colour != "black" && valid_move?([value.location, king_loc])
  #       end
  #     end
  #   end
  # end

  def check?(king_loc, colour = cells[notation_to_cell(king_loc)].colour)
    if colour == "white"
      cells.any? do |value|
        if !value.nil?
          value.colour != "white" && valid_move?([value.location, king_loc])
        end
      end
    else 
      cells.any? do |value|
        if !value.nil?
          value.colour != "black" && valid_move?([value.location, king_loc])
        end
      end
    end
  end

  def checkmate?(king_loc)
    return false unless check?(king_loc)

    colour = cells[notation_to_cell(king_loc)].colour
    king_valid_moves(king_loc).all? {|move| check?(move, colour)}
  end
end
