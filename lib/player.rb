
# Game needs two players

class Player
	attr_reader :name, :pieces_colour

	def initialize(name, pieces_colour)
		@name = name
		@pieces_colour = pieces_colour
	end
end