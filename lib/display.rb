
# Text needed for chess

module Display

	def intro_msg
		"Let's play a simple chess game in the console! \n\n"
	end

	def display_player_turn(name)
    "#{name}, please select the piece you would like to move and the position to which you would like to move it to, e.g. d5-e6"
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