############################################
############### Chess ######################
############################################

############### 3 May ######################
# Assignment:
# 1. Build a command line Chess game where 
#    two players can play against each other.
# 2. The game should be properly constrained 
#    – it should prevent players from making 
#      illegal moves and declare check or 
#      check mate in the correct situations.
# 3. Make it so you can save the board at 
#    any time.
# 4. Write tests for the important parts.
# 5. Do your best to keep your classes modular 
#    and clean and your methods doing only one 
#    thing each.

# ###############  High-level game overview:
# - Game between two players playing 
#   alternatively.

# - Board class initialized with the expected
#   pieces.
# - Somehow pieces will have to be black and
#   white and so must - in some manner - also
#   the chessboard squares be.

# - There ought to be a class for each type
#   of piece: rook, bishop, queen, king, ...


# - Input from users will be limited to 
#   the reference to two positions, the 
#   position of the piece to be moved and the
#   desired position of that same piece.
# - Somehow each user input will have to be
#   verified. It might not be valid.
# - Not only ought each user input be 
#   verified to be valid, but it ought also
#   be verified whether or not such a move
#   "takes" an opponent's chess piece.
# - Must not forget: taking en-passant and
#   castling.

# Must also not forget: 
# - Check and checkmate evaluations; 
# - Possibilty to quit at any time;
# - Proposition of a draw after a move made.
# - Draw claim through repetition of moves.


# Let's tackle the game board display.

# Chess symbols listed at
# https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode
# output symbols with very small dimensions.
# One can always play with an enlarged version of
# the command line... But even then... it's small.

# Possible black square: "\u25FB"
# Possible white sqaure: "\u25FC"
# Though, in fact, the display in irb suggests
# the contrary.

# Another possibility would be to display
# each chess piece preceded by the initial
# of its corresponding colour's name and 
# let each empty square either be empty as 
# in an empty grid or be filled with the 
# respective coordinates.


################# Possible display solution:

# scells = Array.new(65, " ")

# # Black chess pieces.

# scells[57] = "\u265C"
# scells[64] = "\u265C"

# scells[58] = "\u265E"
# scells[63] = "\u265E"

# scells[59] = "\u265D"
# scells[62] = "\u265D"

# scells[61] = "\u265B"
# scells[60] = "\u265A"

# for i in (49..56) do
#   scells[i] = "\u265F"
# end

# # White chess pieces.


# scells[1] = "\u2656"
# scells[8] = "\u2656"

# scells[2] = "\u2658"
# scells[7] = "\u2658"

# scells[3] = "\u2657"
# scells[6] = "\u2657"

# scells[5] = "\u2655"
# scells[4] = "\u2654"

# for i in (9..16) do
#   scells[i] = "\u2659"
# end


# puts <<-HEREDOC
#       -----------------------------------------
#       | 8     | #{scells[64]} | #{scells[63]} | #{scells[62]} | #{scells[61]} | #{scells[60]} | #{scells[59]} | #{scells[58]} | #{scells[57]} |
#       -----------------------------------------
#       | 7     | #{scells[56]} | #{scells[55]} | #{scells[54]} | #{scells[53]} | #{scells[52]} | #{scells[51]} | #{scells[50]} | #{scells[49]} |
#       -----------------------------------------
#       | 6     | #{scells[41]} | #{scells[42]} | #{scells[43]} | #{scells[44]} | #{scells[45]} | #{scells[46]} | #{scells[47]} | #{scells[48]} |
#       -----------------------------------------
#       | 5     | #{scells[40]} | #{scells[39]} | #{scells[38]} | #{scells[37]} | #{scells[36]} | #{scells[35]} | #{scells[34]} | #{scells[33]} |
#       -----------------------------------------
#       | 4     | #{scells[32]} | #{scells[31]} | #{scells[30]} | #{scells[29]} | #{scells[28]} | #{scells[27]} | #{scells[26]} | #{scells[25]} |
#       -----------------------------------------
#       | 3     | #{scells[24]} | #{scells[23]} | #{scells[22]} | #{scells[21]} | #{scells[20]} | #{scells[19]} | #{scells[18]} | #{scells[17]} |
#       -----------------------------------------
#       | 2     | #{scells[16]} | #{scells[15]} | #{scells[14]} | #{scells[13]} | #{scells[12]} | #{scells[11]} | #{scells[10]} | #{scells[9]} |
#       -----------------------------------------
#       | 1     | #{scells[8]} | #{scells[7]} | #{scells[6]} | #{scells[5]} | #{scells[4]} | #{scells[3]} | #{scells[2]} | #{scells[1]} |
#       -----------------------------------------
#               ---------------------------------
#               | a | b | c | d | e | f | g | h |
#               ---------------------------------
#     HEREDOC


# i = 66
# while i >= 0
#   print "| \#{scells[#{i}]} "
#   i -= 1
# end
# puts " "


# Cells expressed in terms of axis values:

# First column == multiples of 8.
# Hence, for instance, cell[8] could be thought
# as 8 * 1 - 0 [a]

# And cell[1], could be thought as
# 8 * 1 - 7 [h]

# And cell[57], could be thought as
# 8 * 8 - 7 [h]

# cell = row * 8 - (8 - column)

# where rows span from 1-8
# and columns span from a-h, i.e. 0-7

# Hence,
# columns = {a: 0, b: 1, c: 2, d: 3, 
#              e: 4, f: 5, g: 6, h: 7}


############### 4 May ######################

# Let's try and use connect-four-tdd files
# to get a basic sketch of the chess game.

# How ought the various chess pieces be 
# treated?

# - In the end they ought to have an 
#   instance variable for the respective
#   symbol.
# - Ought they all to derive from one class,
# ChessPiece class?
# - Ought they to have an instance variable
# for its possible moves?

# In the end, if thinking this through
# correctly, user input will be as simple
# as the location of the piece to be moved
# with the final desired destination location.
# Something in the lines 2a-3a, for example.

# Under the hood:
# There will have to be an update_board method
# that verifies that move desired by user
# is valid and changes the board and the 
# board display accordingly.

# The verification that a desired move by a user
# is valid could perhaps be made interrogating
# the respetive piece's node whether that
# desired move is included in an instance 
# variable which would countain its
# possible moves.

# Two ways to arrange things present themselves:
# 1. Piece class to be initialized with symbol
#    and possible_moves as instance variables.
#    Bishop, rook, pawn, queen, knight classes
#    inherit from Piece class but fill 
#    possible_moves instance variables with 
#    respective methods.
# 2. Do away with Piece superclass and just 
#    create the various chess pieces' classes
#    separately.

# There really doesn't seem to be a need for 
# there to be a chess piece superclass...
# At least at the moment...

# Besides what would this inherit framework
# look like?

# class ChessPiece ; end

# class King < ChessPiece
#   attr_reader :symbol
#   def initialize(symbol)
#     @symbol = symbol
#   end

#   def possible_moves
#     ["hello"]
#   end
# end

# king = King.new("\u2654")
# p king.possible_moves
# p king.symbol

# As of right now, something that doesn't
# seem all that useful, specially if 
# it means what was above layed out.

# A class for each ChessPiece is to be then.

# Does each ChessPiece class need an 
# instance variable for its position?

# #possible_moves, currently associated with
# each ChessPiece class, will more than likely
# need the location of the respective piece
# and the current state of the board.

# So a location instance variable associated
# with each ChessPiece variable may make things
# easier for the possible_moves method.

# Class for each ChessPiece will then have
# as instance variables: location and symbol.
# Possible moves can perhaps remain a method.

# Location ought to have a setter method, as it
# ought to be able to change.
# Symbol can perhaps only have a getter method.

# Example: 

# class King
#   attr_accessor :location
#   attr_reader :symbol
#   def initialize(symbol, location)
#     @symbol = symbol
#     @location = location
#   end

#   def possible_moves

#   end
# end

# king = King.new("\u2654", "e1")

# p king.symbol
# p king.location