
require_relative 'display.rb'

# Logic to play the game

class Game
  include Display
  attr_reader :first_player, :second_player, :board, :current_player

  def initialize
    @board = Board.new
    @first_player = Player.new("Player 1")
    @second_player = Player.new("Player 2")
    @current_player = first_player
  end

  def play
    puts intro_msg
    board.show
    player_turns
    conclusion
  end

  def turn(player)
    ### = turn_input(player)
    board.update_board()
    board.show
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
    # puts display_player_turn()
    # number = gets.chomp.to_i
    # return number if (1..7).include?(number) && board.valid_move?(number)

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
      puts display_winner(current_player.name)
    else
      puts display_tie
    end
  end
end
