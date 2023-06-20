
# Text needed for chess

module Display

	def intro_msg
		"Let's play a simple chess game in the console! \n\n"
	end

	def display_player_turn(name)
<<-HEREDOC
#{name}, please select the piece you would like to move and 
the position to which you would like to move it to, e.g. d5-e6.

For a castling move input the actual king location followed by
the rook location, e.g. e1-a1, where e1 contains the king and
a1 contains the rook in their pre-castling positions!
HEREDOC
  end

  def display_promotion
    "Please select the piece that you would like to promote your pawn into. Options: pawn, rook, knight, bishop, queen."
  end

	def display_input_warning
    "\e[31mSorry, that is an invalid input. Please, try again.\e[0m"
  end

	def display_winner(player)
    "GAME OVER! #{player} is the winner!"
  end
	
	def display_tie
    "It's a draw!"
  end
end