
require_relative 'display.rb'

# Logic to play the game

class Game
  include Display
  attr_reader :first_player, :second_player, :board, :current_player

  def initialize
    @board = Board.new
    @first_player = Player.new("Player 1", "white")
    @second_player = Player.new("Player 2", "black")
    @current_player = first_player
  end

  def play
    puts intro_msg
    board.show
    player_turns
    conclusion
  end

  def turn(player)
    user_input = turn_input(player)
    board.update_board(user_input)
    # p board.en_passant
    board.show
  end

  def valid_input?(user_input)
    separator = (user_input[2] == "-")
    letters = [user_input[0], user_input[3]].all? { |letter| Array('a'..'h').include?(letter) }
    numbers = [user_input[1], user_input[4]].all? { |number| Array(1..8).include?(number.to_i) }

    separator && letters && numbers
  end

  def player_piece_match?(user_input, player)
    selected_piece = board.cells[board.notation_to_cell(user_input[0])]
    player.pieces_colour == selected_piece.colour
  end

  def check_on_oneself?(user_input, player)
    fict_board = Board.new
    duplicate_cells = board.cells.map { |value| value }
    fict_board.cells = duplicate_cells
    fict_board.white_king_loc = board.white_king_loc
    fict_board.black_king_loc = board.black_king_loc

    fict_board.update_board(user_input)

    if player.pieces_colour == "white"
      fict_board.check?(fict_board.white_king_loc, "white")
    else
      fict_board.check?(fict_board.black_king_loc, "black")
    end
  end

  def input_guard_clauses(user_input_orig, user_input, player)
    valid_input?(user_input_orig) && board.non_nil_cell?(user_input[0]) && 
      board.valid_move?(user_input) && player_piece_match?(user_input, player) && 
        !check_on_oneself?(user_input, player)
  end

  private

  def player_turns
    @current_player = first_player
    until board.game_over?
      turn(current_player)
      @current_player = switch_current_player
    end
  end

  def turn_input(player)
    puts display_player_turn(player.name)
    user_input_orig = gets.chomp
    user_input = user_input_orig.split("-")
    # p valid_input?(user_input_orig)
    # p board.valid_move?(user_input)
    return user_input if input_guard_clauses(user_input_orig, user_input, current_player)

    puts display_input_warning
    turn_input(player)
  end

  def switch_current_player
    if current_player == first_player
      second_player
    else
      first_player
    end
  end

  def conclusion
    if board.game_over?
      board.assign_winner
      puts display_winner(board.winner)
    else
      puts display_tie
    end
  end
end
