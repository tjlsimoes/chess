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
# - Exchange of pieces when other end of
#   board is reached.


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
# Something in the lines of 2a-3a, for example.

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

# Now a decision has to be made on what
# type of values ought to be passed to
# each class' location instance variable.

# Whether the board cell index or the
# "letter + number" notation.

# Be it as it may, a conversion is possible
# between the two:

# cell = row * 8 - (8 - column)
# cell = number * 8 -(8 - letter)

# columns = {a: 0, b: 1, c: 2, d: 3,
#              e: 4, f: 5, g: 6, h: 7}

# e.g. e1 == 1 * 8 - (8 - 4) == 4, cell[4]


# As regards the intialization of each
# chess piece class instance the concrete
# manner of filling out the location
# instance variable doesn't seem to favour
# any one side more than the other...

# Where it might be relevant is in regard to:
# 1. Changing the location instance variable
#    due to user input.
#    If notation is used to set location
#    instance variable its update wouldn't
#    have to rely on a translation of the user
#    user input.
# 2. Calculation of the possible moves.
#    On connect-four-tdd project the relation
#    between certain squares of the board and
#    others was explored using board indexes.
#    Would the exploration of the chess board
#    - required, at least to some extent, for
#    each piece on the board - have to rely
#    on a permanent translation of every chess
#    board position/index to a notation value?
#    If so and in a glance, this seems to imply
#    much more translation than the mere
#    translation of user input.

# Let's assume the mistake: location instance
# variable to be defined in the notation terms
# previously exemplified: [a-h][1-8].
# Possible moves method ought to translate
# notation value into cell index and explore
# its relation to other chess board squares
# in that manner: comparing board indexes.

# In connect-four-tdd a problem arose: that of
# "wrapping children"; that is, the relation
# between indexes of end-of-row and beggining-
# -of-new-row.
# Would that be avoided in using notation
# instead of cell indexes?
# From a far-sighted perspective, it seems not.

# How would the relation between chess board
# squares be explored in notation terms?
# In the same manner, it seems, as when
# board indexes are used. Only the possible
# changes, the possible moves would be expressed
# as variations in rows [1-8] and in columns [a-h].

# Only variations in columns would not be obtained,
# at least directly, through an arithmetic operation
# such as the addition or subraction of x units.
# To be sure that could be made if an array of [a-h]
# was created where "a" would stand for 0 and "h" for 7.

# Let us take a concrete example and examine the
# different possibilities.

# Let us take a king at cell[33]. King's possible
# moves would be:

# 34,             # 41, 42,               # 25, 26

# However, generally, a king would admit the moves
# derived from the addition of the following numbers:

# vars = [-1, 1, 8, -8, 9, -9, 7, -7]

# As was identified not all those variations should
# actually be counted as possible for a king at
# cells[33].
# As was done in connect-four-tdd this problem could
# be solved by introducing a guard clause.

# However the question that is now being explored
# is whether or not this problem would not arise
# if the notation previously defined ([a-h][1-8])
# was used to define the changes that could result
# in the possible moves for a given chess piece.

# Let us again consider a king at cells[33], that is
# at h5. King's possible moves would be:

# g5,             # g6, h6,               # g4, h4

# The question then now is how could one obtain
# the king's possible moves in notation terms?

# Formally:
# row_vars = [1, 0, -1]
# column_vars = [1, 0, -1]

# Kings possible moves would be expressed through a
# nested loop covering each element of the two arrays
# identified.

# Notation columns could be translated into numbers
# for that purpose.
# Directly, using a hash as the one downbelow:
# columns = {a: 0, b: 1, c: 2, d: 3,
#              e: 4, f: 5, g: 6, h: 7}

# Or perhaps more usefully, in reference to an ordered
# data structure such as an array. Where the letter's
# index would correspond to its actual value. As
# shown below:
# columns = ["a", "b", "c", "d", "e", "f", "g", "h"]
# columns[0] = a
# columns[1] = b

# Given this framework how could one translate a notation
# value into something that could be used to attain its
# possible moves?

# Using the coordinates h5.
# columns = ["a", "b", "c", "d", "e", "f", "g", "h"]
# row_vars = [1, 0, -1]
# column_vars = [1, 0, -1]
# coordinates_notation = "h5"

# coordinates = coordinates_notation.split("")      #== ["h", "5"]
# column = columns.index(coordinates[0])            #== 7
# row = coordinates[1].to_i                         #== 5
# coordinates = [column, row]

# possible_moves = []
# for i in column_vars do
#   for j in row_vars do
#     possible_moves << [coordinates[0] + i, coordinates[1] + j] unless i == 0 && j == 0
#   end
# end

# possible_moves    #== [[8, 6], [8, 5], [8, 4], [7, 6], [7, 5], [7, 4], [6, 6], [6, 5], [6, 4]]

# possible_moves = possible_moves.map { |coordinates| [columns[coordinates[0]], coordinates[1]].join}

#         #== ["6", "5", "4", "h6", "h5", "h4", "g6", "g5", "g4"]

# possible_moves = possible_moves.select { |coordinates| coordinates.length == 2 }

#         #== ["h6", "h4", "g6", "g5", "g4"]


# And how would one obtain king's possible
# moves using its cell index? 

# As said above, generally, a king would admit the moves
# derived from the addition of the following numbers:

# vars = [-1, 1, 8, -8, 9, -9, 7, -7]

# However, safeguard conditions have to be put in place
# of when king would be at the first column or at the 
# last column.

# last_column_idxs = [1, 9, 17, 25, 33, 41, 49, 57]
# first_column_idxs = [8, 16, 24, 32, 40, 48, 56, 64]

# Will not work with king on last column (h):
# -1, -9, 7

# Will not work with king on first column (a):
# 1, 9, -7

# vars_last_column = [ 1, 8, -8, 9, -7]
# vars_first_column = [-1, 8, -8, -9, 7]

# Let us take a king at cells[33]

# coordinates = 33

# def possible_moves(idx)
#   possible_moves = []

#   last_column_idxs = [1, 9, 17, 25, 33, 41, 49, 57]
#   first_column_idxs = [8, 16, 24, 32, 40, 48, 56, 64]

#   vars = [-1, 1, 8, -8, 9, -9, 7, -7]
#   vars_last_column = [ 1, 8, -8, 9, -7]
#   vars_first_column = [-1, 8, -8, -9, 7]

#   if last_column_idxs.include?(idx)
#     vars_last_column.each do |value|
#       possible_moves << idx + value
#     end
#   elsif first_column_idxs.include?(idx)
#     vars_first_column.each do |value|
#       possible_moves << idx + value
#     end
#   else
#     vars.each do |value|
#       possible_moves << idx + value
#     end
#   end
#   possible_moves
# end

# possible_moves(33)  #==[34, 41, 25, 42, 26]

# Must not forget however that user input
# will be in notation. A conversion of the
# notation value into index will, thus, be
# needed.

######### Conversion from notation to index:
# cell == number * 8 -(8 - letter) ### Wrong!!!
# cell == number * 8 - letter

######### Conversion from index to notation:
# columns = ["a", "b", "c", "d", "e", "f", "g", "h"]
# if cell % 8 != 0
#   number = (cell / 8) + 1
#   columns[8 - (cell % 8)]
# else
#   number = cell / 8   ### Corrected!!!
#   letter = "a"


############### 6 May ######################

# Problem being tackled was:
# - Articulation between user input and
#   possible_moves method inherent to each
#   chess piece class.

# The fundamental question was on which terms
# ought the location instance variable inherent
# to each chess piece class be defined: either
# in notation terms or in indexes terms.

# And a train of thought was constructed
# focusing on the articulation between the
# location instance variable and the method
# possible_moves.

# Two different possible implementations
# of possible_moves were sketched out.

########################
########## Possibility 1 for possible_moves:
# [Using notation terms as input and output.]

# def possible_moves(coordinates_notation)
#   columns = ["a", "b", "c", "d", "e", "f", "g", "h"]
#   row_vars = [1, 0, -1]
#   column_vars = [1, 0, -1]

#   coordinates = coordinates_notation.split("")
#   column = columns.index(coordinates[0])
#   row = coordinates[1].to_i
#   coordinates = [column, row]

#   possible_moves = []
#   for i in column_vars do
#     for j in row_vars do
#       possible_moves << [coordinates[0] + i, coordinates[1] + j] unless i == 0 && j == 0
#     end
#   end

#   possible_moves = possible_moves.map { |coordinates| [columns[coordinates[0]], coordinates[1]].join}

#   possible_moves = possible_moves.select { |coordinates| coordinates.length == 2 }
# end
# There might me a way to refactor the code
# up above.

########################
########## Possibility 2 for possible_moves:
# [Using notation terms as input and output.]

# def possible_moves(coordinates_notation)
#   columns = ["a", "b", "c", "d", "e", "f", "g", "h"]
#   row_vars = [1, 0, -1]

#   coordinates = coordinates_notation.split("")
#   column_idx = columns.index(coordinates[0])

#   column_vars = [columns[column_idx - 1], coordinates[0], columns[column_idx + 1]]

#   row = coordinates[1].to_i
#   column = coordinates[0]
#   coordinates = [column, row]


#   possible_moves = []
#   for i in column_vars do
#     for j in row_vars do
#       possible_moves << [i, coordinates[1] + j] unless i == coordinates[0] && j == 0 || i == nil
#     end
#   end

#   possible_moves = possible_moves.map { |coordinates| coordinates.join}
# end

# Possiblity 3 could be here showcased
# using cell index as input, but there
# doesn't seem to be a need for that.

# Assuming user input will be on notation
# terms, #possible_moves input and output
# ought also to be on notation terms.

# As of right now, then:
# - A principle is established:
#   #possible_moves will take location
#   in notation terms and its output
#   will also be in notation terms.

# - That being defined, I have a deficient
#   possible_moves method for the king
#   chess piece.

# Why deficient?
# - It takes into no account whether
#   the position is occupied on the board
#   by another chess piece of the same
#   colour.
# - It is not currently associated with
#   location instance variable!

# How ought this to be fixed?
# - To be resolved in board #valid_move?
#   instead of in chess piece's
#   possible_moves method?

# This seems as good an idea as any.
# At a distant, a different way of seeing
# things looms, but it seems to involve
# somehow making each chess piece class
# overlap with the board class.

# This could be "as simple" as adding
# the state of the board as another parameter
# to #possible_moves. However, this doesn't
# seem, right now, to be the right thing to
# do. Problem to be resolved in #valid_move?
# of Board class!

# Also solved:
# ✓ It is not currently associated with
#   location instance variable!

# This being said an expansion of the various
# chess pieces' classes could now be attempted.
# The addition of the respective possible_moves
# method.


# Let us start with the Rook class [Tower class].

# Formally, a rook's possible moves will
# correspond to all possible variations on the
# x-axis with the y-axis unaltered, on the one
# hand and, on the other hand, all possible
# variations on the y-axis with the x-axis
# unaltered.

# Let us take "d5" as the rook's location.

# location = "d5"

# columns = ["a", "b", "c", "d", "e", "f", "g", "h"]

# possible_moves = []

# coordinates = location.split("")

# columns.delete(coordinates[0])
# column_vars = columns


# rows = Array(1..8)
# (Array(1..8)).delete(coordinates[1])
# row_vars = rows

# for i in column_vars do
#   possible_moves << [i, coordinates[1]].join
# end

# for i in row_vars do
#   possible_moves << [coordinates[0], i].join
# end

# possible_moves

############### 8 May ######################

# Problem being tackled:
# - #possible_moves for each chess piece
#   respective class.
#       ✓ King, Rook
#       - Bishop, Queen, Knight, Pawn

# Let's tackle Bishop's #possible_moves

# Formally:
# Bishop's possible moves will correspond
# to all possible changes within a board
# with linear proportinal and simultaneous
#  changes in the x-axis and the y axis.

# Let us take "d5" as the bishop's location.

# #possible_moves will have to output:
# ["a8", "a2", "b7", "b3", "c6", "c4",
#  "e6", "e4", "f7", "f3", "g8", "g2",
#   "h1"]

# location = "d5"

# columns = ["a", "b", "c", "d", "e", "f", "g", "h"]

# possible_moves = []

# coordinates = location.split("")
# row = coordinates[1].to_i

# column_idx = columns.index(coordinates[0])


# i = 0
# while i < columns.length do
#   if columns[i] != coordinates[0]
#     difference = (column_idx - i).abs

#     p difference

#     possible_moves << [columns[i], row + difference].join if row + difference <= 8
#     possible_moves << [columns[i], row - difference].join if row - difference >= 0
#   end

#   i += 1
# end

# p possible_moves


###### Notes:
# - There might be a lack of consistency
# between the logic behind the board display
# and the way each #possible_moves is being
# designed...
# - Not to mention that #possible_moves
# does not, as of yet, give actual possible
# moves. Actual possible moves will require
# a more thourough evaluation of the state
# of the board.

# Problem being tackled:
# - #possible_moves for each chess piece
#   respective class.
#       ✓ King, Rook, Bishop
#       - Queen, Knight, Pawn


# Let's tackle Queen's #possible_moves

# Formally, queen's possible moves
# correspond to the combined moves of the
# rook and the bishop.

# Problem being tackled:
# - #possible_moves for each chess piece
#   respective class.
#       ✓ King, Rook, Bishop, Queen
#       - Knight, Pawn


# Let's tackle Knight's #possible_moves

# Formally:
# -1/+1 column => +2/-2 row
# -2/+2 column => +1/-1 row

# Let us take "d5" as the knight's location.

# #possible_moves will have to output:
# %w(e3 e7 f4 f6 b4 b6 c3 c7)

# location = "d5"

# columns = ["a", "b", "c", "d", "e", "f", "g", "h"]

# coordinates = location.split("")
# column_idx = columns.index(coordinates[0])

# possible_moves = []

# [-2, -1, 1, 2].each do |shift|

#   new_column = columns[column_idx + shift]

#   if shift.abs == 2
#     possible_moves << [new_column, coordinates[1].to_i + 1].join
#     possible_moves << [new_column, coordinates[1].to_i - 1].join
#   else
#     possible_moves << [new_column, coordinates[1].to_i + 2].join
#     possible_moves << [new_column, coordinates[1].to_i - 2].join
#   end

# end

# possible_moves

############### 9 May ######################

# Problem being tackled:
# - #possible_moves for each chess piece
#   respective class.
#       ✓ King, Rook, Bishop, Queen, Knight
#       - Pawn

# Let's tackle Pawn's #possible_moves

# Pawn is a weird piece.
# Not only does it move differently
# when it has never moved, it also moves
# differently when takin an opponent's
# chess piece.

# For the time being the best course of
# action seems to be to include possible
# diagonal moves into #possible_moves.
# And also, in a conditional flow, the
# possible two square initial move.

# Perhaps later implement an additional
# layer of validation of user input
# in Board#valid_move? ?

# Also ignoring en passant move for now.

# Add a @unmoved instance variable to each
# pawn piece. Set by default to true. With
# a setter method enabled.

# #possible_moves ought to output different
# results in light of @unmoved's value.

# Irregardless of that, pawn's possible moves
# equal, formally, to two most close forward
# diagonal squares and closemost forward square.

# Assuming a pawn at "d5".
# possible_moves ought to equal:
# ["d6", "e6", "c6"]

# location = "d5"

# columns = ["a", "b", "c", "d", "e", "f", "g", "h"]
# possible_moves = []

# coordinates = location.split("")
# column_idx = columns.index(coordinates[0])
# row = coordinates[1].to_i

# column_vars = [columns[column_idx - 1], coordinates[0], columns[column_idx + 1]]

# for i in column_vars do

#   possible_moves << [i, row + 1 ].join if row + 1 <= 8
# end

# p possible_moves

# Additional logic has to be added for
# it to have a conditional flow in respect
# to the @unmoved instance variable.

# unmoved = true
# location = "d5"

# columns = ["a", "b", "c", "d", "e", "f", "g", "h"]
# possible_moves = []

# coordinates = location.split("")
# column_idx = columns.index(coordinates[0])
# row = coordinates[1].to_i

# column_vars = [columns[column_idx - 1], columns[column_idx], columns[column_idx + 1]]


# for i in column_vars do
#   if unmoved && i == coordinates[0]
#     possible_moves << [i, row + 1 ].join if row + 1 <= 8
#     possible_moves << [i, row + 2 ].join if row + 1 <= 8
#   else
#     possible_moves << [i, row + 1 ].join if row + 1 <= 8
#   end
# end

# p possible_moves


# Problem being tackled:
# ✓ #possible_moves for each chess piece
#   respective class.
# ✓ King, Rook, Bishop, Queen, Knight, Pawn


# ###### High-level game overview renovated:
# - Game between two players playing
#   alternatively.

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
# - Exchange of pieces when other end of
#   board is reached.

# What ought to be my next working point?
# Ideally the next most immediate goal
# ought to be to have an actually working
# chess game on the terminal.

# The next most immmediate logic step in
# that direction seems to be to work
# on Board#valid_move? and Board#update_board
# methods.

# Board#valid_moved? would be called from
# within Board#update_board.

# Conceptually I was thinking on one single
# user input which would need to include two
# things given simultaneously: location of
# the desired piece to be moved and the end
# location of that same piece.

# However that user input could be broken into
# two moments: (1) which chess piece ought to
# and (2)to where it ought to move.

# Be that as it may, Board#update_board will
# take in the previously stated two elements,
# come as they may (simultaneously or not).

# Board#update_board ought to call from
# Board#valid_move? and then update the board
# and the board display accordingly.

# Conceptually Board#valid_move? was being
# thought as something as simple as checking
# whether or not the designated chess piece
# at the specified location included the
# desired location in its respective
# possible_moves method output.

# Things don't seem, however, to be that
# simple.
# Why?
# Possibly due to a misconception as regards
# to what #possible_moves ought to be.

# #possible_moves currently lists all possible
# moves of a given chess piece in an empty board!

# More than that, as is the case with Pawn,
# it lists "possibly not possible" moves -
# the diagonal moves are only valid if there is
# an opponent piece at that square.

# Not to mention it currently also doesn't
# take in account of en passant, castling
# and possible exchange between pieces.

# But one thing at a time.

# One thing than can - and perhaps ought to -
# be done before all this is to make Board.new
# generate a duly populated board!

############### 10 May #####################

# Problem to be tackled:
# - Duly populate Board with initial board.

# Problem solved:
# ✓ Duly populate Board with initial board.

# The next most immmediate logic step in
# that direction seems to be to work
# on Board#valid_move? and Board#update_board
# methods.

# Conceptually Board#valid_move? was being
# thought as something as simple as checking
# whether or not the designated chess piece
# at the specified location included the
# desired location in its respective
# possible_moves method output.

# However as #possible_moves is currently
# implemented that logic is not enough.

# #possible_moves does not take in account:
# - Impeded lines to certain squares by other
# chess pieces.
# - As regards to Pawn it contains "possibly
#   not possible" positions: diagonal takes.
# - It also doesn't take into account:
#   en passant, castling, chess piece's
#   exchange.
# - Restrictions on moves due to mate and
#   checkmate.

# Question seems to be:
# How ought these problems to be adrressed?
# - Do they call for a refactor of
#   #possible_moves?
# - Or ought #possible_moves to stay as is
#   and adress these problems at the level
#   of the Board#valid_move? ?

# Perhaps a combination of both answers is
# the way to go.

# If these problems were to be addressed at
# the level of Board#valid_move?, what
# concrete solutions would have to be
# put forward?

# What mechanism could be implemented so as
# to prevent assumption of certain squares
# as possible moves, regardless of the path
# towards them being blocked?

# A certain dependency between possible moves
# would have to be implemented.
# Such that when some or one is not possible
# it would have a cascading effect on the
# possible moves: they would seize to be
# taken as possible moves.

# With the current possible_moves method,
# Board#valid_move? can not be as simple as
# checking if desired end position for a
# given chess piece is included in its
# possible_moves method output.
# It has also to check:
# (a) If end-position is free or occupied
#     by an opponent's chess piece.
# (b) If path to desired location is blocked.
# (c) Pawn's disparate possible movements.
# (d) Mate and checkmate conditions.
# (e) Castling, en passant, exchange.

# If (a) was the only problem, the solution
# would be simple:
# To the verification that the end-position
# would be on #possible_moves output, extra
# conditions would have to be placed: for it
# to be either free or occupied by an
# opponent's chess piece. The latter case
# would then have to result in a peculiar
# form of Board#update_board. Not only would
# it have to remove and relocate one piece,
# but also remove another entirely from the
# board.

# Problem (b) calls for the evalution of the
# board status in certain possible lines of
# movement.

# In light of problem (b) it seems that a
# certain definition of the relation between
# the designated piece location and its
# desired end-location has to be defined.

# If it requires an horizontal movement, to
# the left or to the right.
# If it requires a vertical movement, upwards
# or downwards.
# If it requires a diagonal movement, in any
# of the 4 possible directions:
# - right upwards;        # - left upwards;
# - right downwards;      # - left downwads;

# In light of this valid_move? ought to still
# check if desired end-positon would be
# included in the piece's #possible_moves.
# But it would have to additionally define
# the relation between location and
# end-location so as to avoid making
# impossible moves (path being blocked).

# Moreover it seems that problem (b) only
# concerns certain pieces: rook, bishop,
# queen.

# How could one extract the type of movement
# involved in a certain play from the user
# input of piece-location and desired
# piece end-location?

# Horizontal movement:
# Same row, different collumn.
# If end-column > initial-column: (i)
#     horizontal to the right;
# If end-column < initial-column: (ii)
#     horizontal to the right;

# Vertical movement:
# Same column, different row.     (I)
# If end-row > initial-row:
#     vertical upwards
# If end-row < initial-row:       (II)
#     vertical downwards

# Diagonal movement:
# (i), (I): right upwards;
# (i), (II): right downwards;
# (ii), (I): left upwards;
# (ii), (II): left downwards;

# Based on this information it could
# be verified whether all positions
# between chess piece location and its
# desired end-location are free.

# For horizontal and vertical movement
# the code for that seems somewhat
# straightforward.

# Horizontal movement:
# Maintain row, change column by factor
# of 1, incresing or decreasing in light
# of specific horizontal movement.
# Of course, an equiparation between
# numbers and columns would have to be made
# here.

# Vertical movement:
# Maintain column, change row by factor of 1,
# increasing or decreasing in light of
# specific vertical movement.

# Diagonal movement seems a bit more complex.

# Diagonal movement:
# Both column and row would have to vary.
# And perhaps vary differently in light of
# specific diagonal movement.
# Diagonal movement would correspond to the
# combined variation of the row and column
# by a factor of 1, in light of the specific
# diagonal movement.

# Different moments of functionality:
# - Assess type of movement;
# - Check if there are pieces between
#   initial-location and end-location.

##### Board#valid_move? high-level overview:
# 1. Check if end-location is in
#    #possible_moves.
# 2. Check if end-location is nil or an
#    opponent chess-piece.
# 3. Assess type of movement.
# 4. Check if there are pieces between
#    initial-location and end-location.


############### 11 May #####################

# Point to be worked on:
# - Board#valid_move?

##### Board#valid_move? high-level overview:
# 1. Check if end-location is in
#    #possible_moves.
# 2. Check if end-location is nil or an
#    opponent chess-piece.
# 3. Assess type of movement.
# 4. Check if there are pieces between
#    initial-location and end-location.

# Assuming Board#valid_move? will take an
# array with two string values - corresponding
# to the two locations from user input - as
# input, how ought the assessment of the
# type of movement look like?

# Board#valid_move? ought, then, to look like
# something like:

# def intermediate_squares(user_input)

#   start_loc = user_input[0]
#   end_loc = user_input[1]

#   start_loc_col = start_loc[0]
#   start_loc_row = start_loc[1].to_i

#   end_loc_col = end_loc[0]
#   end_loc_row = end_loc[1].to_i

#   # No precaution here set for same end and
#   # starting location.

#   intermediate_squares = []
#   columns = ["a", "b", "c", "d", "e", "f", "g", "h"]

#   if start_loc_col == end_loc_col # vertical movement

#     if start_loc_row > end_loc_row # downwards

#       i = start_loc_row - 1
#       while i > end_loc_row

#         intermediate_squares << [start_loc_col, i].join
#         i -= 1
#       end

#     else # upwards

#       i = start_loc_row + 1
#       while i < end_loc_row

#         intermediate_squares << [start_loc_col, i].join
#         i += 1
#       end
#     end

#   elsif start_loc_row == end_loc_row # horizontal movement

#     if start_loc_column > end_loc_row # to the left

#       i = columns.index(start_loc_col) - 1
#       while i > columns.index(end_loc_col)

#         intermediate_squares << [columns[i], start_loc_row].join
#         i -= 1
#       end
#     else # to the right

#       i = columns.index(start_loc_col) + 1
#       while i < columns.index(end_loc_col)

#         intermediate_squares << [columns[i], start_loc_row].join
#         i += 1
#       end
#     end

#   elsif diag_right_up?(start_loc_col, end_loc_col, start_loc_row, end_loc_row)

#     j = start_loc_row + 1
#     i = columns.index(start_loc_col) + 1
#     while i < columns.index(end_loc_col) && j < end_loc_row

#       intermediate_squares << [columns[i], j].join

#       i += 1
#       j += 1
#     end

#   elsif diag_right_down?(start_loc_col, end_loc_col, start_loc_row, end_loc_row)

#     j = start_loc_row - 1
#     i = columns.index(start_loc_col) + 1
#     while i < columns.index(end_loc_col) && j > end_loc_row

#       intermediate_squares << [columns[i], j].join

#       i += 1
#       j -= 1
#     end

#   elsif diag_left_up?(start_loc_col, end_loc_col, start_loc_row, end_loc_row)

#     j = start_loc_row + 1
#     i = columns.index(start_loc_col) - 1
#     while i > columns.index(end_loc_col) && j < end_loc_row

#       intermediate_squares << [columns[i], j].join

#       i -= 1
#       j += 1
#     end

#   elsif diag_left_down?(start_loc_col, end_loc_col, start_loc_row, end_loc_row)

#     j = start_loc_row - 1
#     i = columns.index(start_loc_col) - 1
#     while i > columns.index(end_loc_col) && j > end_loc_row

#       intermediate_squares << [columns[i], j].join

#       i -= 1
#       j -= 1
#     end
#   end

#   intermediate_squares
# end

# user_input = ["d5", "d2"]
# p intermediate_squares(user_input)

# Diagonal movement could more than likely
# benefit from a set of helper functions.

# Previous annotations: 

# Horizontal movement:
# Same row, different collumn.
# If end-column > initial-column: (i)
#     horizontal to the right;
# If end-column < initial-column: (ii)
#     horizontal to the right;

# Vertical movement:
# Same column, different row.     (I)
# If end-row > initial-row:
#     vertical upwards
# If end-row < initial-row:       (II)
#     vertical downwards

# Diagonal movement:
# (i), (I): right upwards;
# (i), (II): right downwards;
# (ii), (I): left upwards;
# (ii), (II): left downwards;


# def diag_right_up?(start_loc_col, end_loc_col, start_loc_row, end_loc_row)
#   end_loc_col > start_loc_col && end_loc_row > start_loc_row
# end

# def diag_right_down?(start_loc_col, end_loc_col, start_loc_row, end_loc_row)
#   end_loc_col > start_loc_col && start_loc_row > end_loc_row
# end

# def diag_left_up?(start_loc_col, end_loc_col, start_loc_row, end_loc_row)
#   start_loc_col > end_loc_col && end_loc_row > start_loc_row
# end

# def diag_left_down?(start_loc_col, end_loc_col, start_loc_row, end_loc_row)
#   start_loc_col > end_loc_col && start_loc_row > end_loc_row
# end


# Current situation as regards to
# Board#valid_move?:
# As of right now, code up above ought to
# identify type of movement and output the
# intermediate squares to be verified.


############### 13 May #####################

# Point to be worked on:
# - Board#valid_move?

##### Board#valid_move? high-level overview:
# 1. Translate selected piece's location
#    to respective board cell.
# 2. Check if end-location is in
#    #possible_moves.
# 3. Check if end-location is nil or an
#    opponent chess-piece.
# 4. Assess type of movement.
# 5. Check if there are pieces between
#    initial-location and end-location.

# def notation_to_cell(coordinate)
#   column = coordinate[0]
#   row = coordinate[1].to_i

#   columns = ["a", "b", "c", "d", "e", "f", "g", "h"]

#   cell = row * 8 - columns.index(column)
# end

# p notation_to_cell("h7")

# How to check if end-location contains
# an opponent's piece?
# More than likely through the constant
# variations on the symbol instance
# variable.

# Black chess pieces' symbols end with a
# letter.
# White chess pieces' symbols end with a
# number.

# Can't seem to make that work.
# Alternative: add a colour instance variable
# to each chess piece...

# - Fix bug on pawn definition on
#     Board#initial_board
# - Add Board#nil_or_opponent?
# - Add Board#rook_queen_bishop?
# - Implement rough version of
#     Board#valid_move?

############### 14 May #####################

# - Fix bug on pawn definition on
#     Board#initial_board
# - Add Board#nil_or_opponent?
# - Add Board#rook_queen_bishop?
# - Implement rough version of
#     Board#valid_move?
# - Fix bug on queen definition on
#     Board#initial_board (black chess
#     pieces).
# - Remove trailing white-space

# Board#valid_move? has also to check:
# (a) If end-position is free or occupied
#     by an opponent's chess piece. ✓
# (b) If path to desired location is blocked. ✓
# (c) Pawn's disparate possible movements.
# (d) Mate and checkmate conditions.
# (e) Castling, en passant, exchange.

# How could pawn's disparate possible
# be accounted for?
# Focusing, for now, on the possible
# two-square initial move, the possible
# diagonal move to take an opponent piece
# and the impossibility of forward movement
# if any piece lays immediately ahead.

# It seems as if pawn pieces require a
# separate treatment within Board#valid_move?

############### 15 May #####################

# Point to be worked on:
# - Articulation between pawn's disparate
#   possible movements and Board#valid_move?

# Current problems with the articulation
# between Pawn#possible_moves? and
# Board#valid_move?:
# - Board#intermediate_squares is not called
#   when pawn is to be moved two squares.
# - Pawn's forward movements ought not to be
#   considered possibles if said square is
#   occupied either by a "friendly" chess
#   or by an opponent's chess piece!
# - As of right now pawn's possible diagonal
#   movements are always valid. And not only
#   when there are opponent's pieces on the
#   end-square selected.

# How could these problems be solved?
# Let's try and think this through.
# A pawn's move will be valid if:
# - Moved one square forward to an unoccupied
#   square.
# - Moved two squares forward to an unoccupied
#   square if intermediate square is not
#   occupied and pawn to be moved has not yet
#   been moved.
# - Moved to the right or left diagonal
#   square occupied by an opponent's piece.
# - [En passant.]

# if row + 1 && unoccupied
# if row + 2 && unoccupied && unmoved == true
# if row + 1, column +/- 1 && occupied opponent

# Chess pieces are wrongly set on the chess
# board... Black chess pieces are where white
# chess pieces are meant to be...

# Point to be worked on:
# ✓ Articulation between pawn's disparate
#   possible movements and Board#valid_move?
# (roughly though and in need of refactor).
# - Board#initial_board: chess pieces'
#   correct placement.

# Board is initially correctly filled with
# black and white chess pieces references.
# However the command line inverts the chess
# pieces' colours!!!

############### 16 May #####################

# Point to be worked on:
# ✓ Correct initial_board and chess piece's
#   colour evaluation for there to be a match
#   between visual output and game mechanics.

# Board#valid_move? has also to check:
# (a) If end-position is free or occupied
#     by an opponent's chess piece. ✓
# (b) If path to desired location is blocked. ✓
# (c) Pawn's disparate possible movements. ✓
# (d) Mate and checkmate conditions.
# (e) Castling, en passant, exchange.

# With this provisional Board#valid_move?
# work can perhaps be done on
# Board#update_board.

# Board#update_board ought to work based
# on validated user input.
# At least for now it ought to work in
# regard to two possible cases:
# (a) end_loc == nil;
# (b) end_loc != nil;

# Case (b) regards a possible take movement.
# For now there seems no need to store
# the taken pieces in any variable.
# Hence, case (b) ought to be analogous to
# case (a): redefinition of two array
# elements.

# Board#update_board ought perhaps also to
# update pawn's unmoved instance variable
# if piece to be moved is a pawn.
# ✓ Done.

# Having Board#update_board and
# Board#valid_move? sketched out it is
# perhaps time to look into getting that
# user input.
# ✓ Done - for the effect at least.

############### 17 May #####################

# Identified problems in need of fix:
# ✓ Pawn#possible_moves is incorrectly
#   defined: pawns from the upper part of
#   the chess board won't move to rows
#   with increased number, but to rows
#   of lesser values.
# ✓ Pawn's special valid_move? conditions
#   also suffer from the same problem.
#   Current Pawn#possible_moves only works
#   for pawns from the bottom part of the
#   chess board.
# ✓ At each player turn, every piece can
#   be selected and moved, irregardless
#   of its being a piece that belongs to
#   the player playing or not.
# - Errors due to invalid user input result
#   in game crashing.

############### 18 May #####################

# Points that need work:
# - Errors due to invalid user input result
#   in game crashing.
# - Mate and chekmate evaluation.
# - En passant, castling, exchange of pieces.

# What is check?
# When the king of a player can be taken by
#  a piece of the opponent, one says that
# the king is in check.

# It is not allowed to make a move,
#  such that ones king is in check after
# the move.

# There are three different possible ways
# to remove a check:
# 1. Move the king away to a square where
#    he is not in check.
# 2. Take the piece that gives the check.
# 3. In case of a check, given by a rook,
#     bishop or queen: move a piece between
#     the checking piece and the king.

# What is checkmate?
# When a player is in check, and he cannot
# make a move such that after the move,
# the king is not in check, then he is mated.

# The player that is mated lost the game,
# and the player that mated him won the game.

# Essentially:
# Check seems to call for an evaluation
# of the king's status. If it is in danger
# of being taken by any of the opponent's
# pieces.
# Checkmate seems to call not only for a
# check evaluation, but also for a check
# evaluation to all the possible king
# movements.

# How could a check evaluation be most
# efficiently done?

# It could be achieved by:
# - Checking if any of the kings' opponent
#   pieces include its location in their
#   respective possible moves method. Plus
#   an evaluation of it being an actual
#   valid move.

# This seems to require, for each king:
# - Evaluation of the king's colour and
#   location (in notation terms).
# - Collecting the values for all the
#   opponent pieces #possible_moves
#   values.
# - Checking if they include the king's
#   location.
# - Checking if the piece with that
#   "possible move" translates to an actual
#   valid move.
#    - This last point seems to require more
#      than a mere collection of the
#      #possible_moves output for each
#      opponent piece on the board. A link
#      between the piece and its
#      #possible_moves has to be mantained.
#      Perhaps an hash or an array with
#      nested arrays would do the trick.
#      Or perhaps a more complex evaluation
#      of the opponent's chess pieces on the
#      board would suffice. For instances,
#      a search for an opponent's chess piece
#      (disparate colour) that contains the
#      king's location in its #possible_moves.

# The addition of two board instance variables
# with the two kings' respective locations
# would save a scan on the board every play.

# ✓ Sketch of Board#check?

############### 20 May #####################

# What ought Board#checkmate? to constitute?
# Evaluation of:
# - Check on king.
# - Check on every of king's actually
#   possible moves.

############### 23 May #####################

# ✓ Sketch of Board#checkmate? and, hence,
#   of Board#game_over?