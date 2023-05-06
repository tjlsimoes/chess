
# Chess board

class Board
  attr_reader :cells

  def initialize
    @cells = Array.new(43)
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

  def valid_move?()
    
  end

  def game_over?
    
  end

  def update_board()
  
  end
end