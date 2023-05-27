require_relative "../lib/board.rb"

# Board class tests.

describe Board do
  subject(:board) { Board.new }

  describe "#initial_board" do
    it "returns an array of corectly placed 65 elements" do
      board.show
      output = board.cells # Also works with Board.initial_board
      expect(output.length).to eq(65)
    end
  end

  describe "#notation_to_cell" do
    context "when given 'd5'" do
      it "returns 37" do
        output = board.notation_to_cell("d5")
        expect(output).to eq(37)
      end
    end

    context "when given 'h8'" do
      it "returns 57" do
        output = board.notation_to_cell("h8")
        expect(output).to eq(57)
      end
    end

    context "when given 'a1'" do
      it "returns 8" do
        output = board.notation_to_cell("a1")
        expect(output).to eq(8)
      end
    end

    context "when given 'e8'" do
      it "returns 60" do
        output = board.notation_to_cell("e8")
        expect(output).to eq(60)
      end
    end
  end

  describe "#castling?" do
    context "taking indexes of king and rook of the same colour and same rows" do
      it "returns true" do
        output = board.castling?(60, 64, "e8", "a8")

        expect(output).to eq true
      end
    end

    context "taking indexes of king and rook of same colour and disparate rows" do

      before do
        cells = Array.new(65)
        cells[37] = King.new("\u265A", "d5")
        cells[45] = Rook.new("\u265C", "d6")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns false" do
        output = board.castling?(37, 45, "d5", "d6")

        expect(output).to eq false
      end
    end

    context "taking indexes of king and rook of different colour and same rows" do
      before do
        cells = Array.new(65)
        cells[37] = King.new("\u265A", "d5")
        cells[40] = Rook.new("\u2656", "a5")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns false" do
        output = board.castling?(37, 40, "d5", "a5")

        expect(output).to eq false
      end
    end

    context "taking indexes of king and bishop of the same colour and same rows" do
      it "returns true" do
        output = board.castling?(60, 62, "e8", "c8")

        expect(output).to eq false
      end
    end
  end

  describe "#castling_end_locations" do
    context "king at e8 and rook at a8" do
      it "returns %w[c8 d8]" do
        output = board.castling_end_locations("e8", "a8")

        expect(output).to eq(%w[c8 d8])
      end
    end
  end

  describe "#unmoved_pawn_twosq?" do
    context "unmoved pawn two square forward movement" do
      it "returns true" do
        output = board.unmoved_pawn_twosq?(16, "a2", "a4")

        expect(output).to eq true
      end
    end

    context "unmoved pawn one square forward movement" do
      it "returns false" do
        output = board.unmoved_pawn_twosq?(16, "a2", "a3")

        expect(output).to eq false
      end
    end
  end

  describe "#aside" do
    context "taking \"d5\" as input" do
      it "outputs \"e5\"" do
        output = board.aside("d5")

        expect(output).to eq("e5")
      end
    end

    context "taking \"h5\" as input" do
      it "outputs nil" do
        output = board.aside("h5")

        expect(output).to be_nil
      end
    end
  end

  describe "#aside_opponent_pawn?" do
    context "initial board and unmoved pawn two squares forward movement" do
      it "returns false" do
        output = board.aside_opponent_pawn?(16, "a4")

        expect(output).to eq false
      end
    end

    context "white unmoved pawn two squares forward movement next to opponent on the right" do
      before do
        cells = Array.new(65)
        cells[16] = Pawn.new("\u265F", "a2")
        cells[31] = Pawn.new("\u2659", "b4")
        board.instance_variable_set(:@cells, cells)
      end
      it "returns true" do
        output = board.aside_opponent_pawn?(16, "a4")

        expect(output).to eq true
      end
    end

    context "black unmoved pawn two squares forward movement next to opponent on the right" do
      before do
        cells = Array.new(65)
        cells[48] = Pawn.new("\u2659", "a6")
        cells[31] = Pawn.new("\u265F", "b4")
        board.instance_variable_set(:@cells, cells)
      end
      it "returns true" do
        output = board.aside_opponent_pawn?(48, "a4")

        expect(output).to eq true
      end
    end
  end

  describe "#bside" do
    context "taking \"d5\" as input" do
      it "outputs \"c5\"" do
        output = board.bside("d5")

        expect(output).to eq("c5")
      end
    end

    context "taking \"a5\" as input" do
      it "outputs nil" do
        output = board.bside("a5")

        expect(output).to be_nil
      end
    end
  end

  describe "#bside_opponent_pawn?" do
    context "initial board and unmoved pawn two squares forward movement" do
      it "returns false" do
        output = board.bside_opponent_pawn?(13, "d2")

        expect(output).to eq false
      end
    end

    context "white unmoved pawn two squares forward movement next to opponent on the left" do
      before do
        cells = Array.new(65)
        cells[13] = Pawn.new("\u265F", "d2")
        cells[30] = Pawn.new("\u2659", "c4")
        board.instance_variable_set(:@cells, cells)
      end
      it "returns true" do
        output = board.bside_opponent_pawn?(13, "d4")

        expect(output).to eq true
      end
    end

    context "black unmoved pawn two squares forward movement next to opponent on the left" do
      before do
        cells = Array.new(65)
        cells[45] = Pawn.new("\u2659", "d6")
        cells[30] = Pawn.new("\u265F", "c4")
        board.instance_variable_set(:@cells, cells)
      end
      it "returns true" do
        output = board.bside_opponent_pawn?(45, "d4")

        expect(output).to eq true
      end
    end
  end

  describe "#absides_opponent_pawns?" do
    context "initial board and unmoved pawn two squares forward movement" do
      it "returns false" do
        output = board.absides_opponent_pawns?(13, "d2")

        expect(output).to eq false
      end
    end

    context "white unmoved pawn two squares forward movement next to opponent on the left" do
      before do
        cells = Array.new(65)
        cells[13] = Pawn.new("\u265F", "d2")
        cells[30] = Pawn.new("\u2659", "c4")
        board.instance_variable_set(:@cells, cells)
      end
      it "returns false" do
        output = board.absides_opponent_pawns?(13, "d4")

        expect(output).to eq false
      end
    end

    context "white unmoved pawn two squares forward movement next to opponent on the left and on the right" do
      before do
        cells = Array.new(65)
        cells[13] = Pawn.new("\u265F", "d2")
        cells[30] = Pawn.new("\u2659", "c4")
        cells[28] = Pawn.new("\u2659", "e4")
        board.instance_variable_set(:@cells, cells)
      end
      it "returns true" do
        output = board.absides_opponent_pawns?(13, "d4")

        expect(output).to eq true
      end
    end

    context "white unmoved pawn two squares forward movement on column h landing next to opponent on the left" do
      before do
        cells = Array.new(65)
        cells[9] = Pawn.new("\u265F", "h2")
        cells[26] = Pawn.new("\u2659", "g4")
        board.instance_variable_set(:@cells, cells)
      end
      it "returns false" do
        output = board.absides_opponent_pawns?(9, "h4")

        expect(output).to eq false
      end
    end

    context "white unmoved pawn two squares forward movement on column a landing next to opponent on the right" do
      before do
        cells = Array.new(65)
        cells[16] = Pawn.new("\u265F", "a2")
        cells[47] = Pawn.new("\u2659", "b4")
        board.instance_variable_set(:@cells, cells)
      end
      it "returns false" do
        output = board.absides_opponent_pawns?(16, "a4")

        expect(output).to eq false
      end
    end
  end

  describe "#bside_vd_en_passant" do
    context "black pawn two square movement from \"e7\" to \"e5\"" do
      it "returns %w[d5 e6]" do
        output = board.bside_vd_en_passant("e7", "e5", 7)

        expect(output).to eq(%w[d5 e6])
      end
    end
  end

  describe "#aside_vd_en_passant" do
    context "black pawn two square movement from \"e7\" to \"e5\"" do
      it "returns %w[f5 e6]" do
        output = board.aside_vd_en_passant("e7", "e5", 7)

        expect(output).to eq(%w[f5 e6])
      end
    end
  end

  describe "#bside_vu_en_passant" do
    context "black pawn two square movement from \"d2\" to \"d4\"" do
      it "returns %w[c4 d3]" do
        output = board.bside_vu_en_passant("d2", "d4", 2)

        expect(output).to eq(%w[c4 d3])
      end
    end
  end

  describe "#aside_vu_en_passant" do
    context "black pawn two square movement from \"d2\" to \"d4\"" do
      it "returns %w[e4 d3]" do
        output = board.aside_vu_en_passant("d2", "d4", 2)

        expect(output).to eq(%w[e4 d3])
      end
    end
  end

  describe "#vd_en_passant" do
    context "absides_opponent_pawns? == true" do

      before do
        cells = Array.new(65)
        cells[53] = Pawn.new("\u2659", "d7")
        cells[38] = Pawn.new("\u265F", "c5")
        cells[36] = Pawn.new("\u265F", "e5")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns [%w[e5 d6],%w[c5 d6]]" do
        output = board.vd_en_passant("d7", "d5", 7, 53)

        expect(output).to eq([%w[e5 d6], %w[c5 d6]])
      end
    end

    context "bside_opponent_pawn? == true" do
      before do
        cells = Array.new(65)
        cells[53] = Pawn.new("\u2659", "d7")
        cells[38] = Pawn.new("\u265F", "c5")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns %w[c5 d6]" do
        output = board.vd_en_passant("d7", "d5", 7, 53)

        expect(output).to eq(%w[c5 d6])
      end
    end

    context "aside_opponent_pawn? == true" do
      before do
        cells = Array.new(65)
        cells[53] = Pawn.new("\u2659", "d7")
        cells[36] = Pawn.new("\u265F", "e5")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns %w[e5 d6]" do
        output = board.vd_en_passant("d7", "d5", 7, 53)

        expect(output).to eq(%w[e5 d6])
      end
    end
  end

  describe "#vu_en_passant" do
    context "absides_opponent_pawns? == true" do
      before do
        cells = Array.new(65)
        cells[13] = Pawn.new("\u265F", "d2")
        cells[30] = Pawn.new("\u2659", "c4")
        cells[28] = Pawn.new("\u2659", "e4")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns [%w[e4 d3], %w[c4 d3]]" do
        output = board.vu_en_passant("d2", "d4", 2, 13)

        expect(output).to eq([%w[e4 d3], %w[c4 d3]])
      end
    end

    context "bside_opponent_pawn? == true" do
      before do
        cells = Array.new(65)
        cells[13] = Pawn.new("\u265F", "d2")
        cells[30] = Pawn.new("\u2659", "c4")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns %w[c4 d3]" do
        output = board.vu_en_passant("d2", "d4", 2, 13)

        expect(output).to eq(%w[c4 d3])
      end
    end

    context "aside_opponent_pawn? == true" do
      before do
        cells = Array.new(65)
        cells[16] = Pawn.new("\u265F", "a2")
        cells[31] = Pawn.new("\u2659", "b4")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns %w[c4 d3]" do
        output = board.vu_en_passant("a2", "a4", 2, 16)

        expect(output).to eq(%w[b4 a3])
      end
    end
  end

  describe "#intermediate_squares" do

    context "vertical upwards movement" do
      context "when given %w[d3 d8]" do
        it "returns %w[d4 d5 d6 d7]" do
          output = board.intermediate_squares(%w[d3 d8])
          expect(output).to eq(%w[d4 d5 d6 d7])
        end
      end
    end

    context "vertical downwards movement" do
      context "when given %w[e8 e2]" do
        it "returns %w[e7 e6 e5 e4 e3]" do
          output = board.intermediate_squares(%w[e8 e2])
          expect(output).to eq(%w[e7 e6 e5 e4 e3])
        end
      end
    end

    context "horizontal rightwards movement" do
      context "when given %w[b2 g2]" do
        it "returns %w[c2 d2 e2 f2]" do
          output = board.intermediate_squares(%w[b2 g2])
          expect(output).to eq(%w[c2 d2 e2 f2])
        end
      end
    end

    context "horizontal leftwards movement" do
      context "when given %w[h5 a5]" do
        it "returns %w[g6 f5 e5 d5 c5 b5]" do
          output = board.intermediate_squares(%w[h5 a5])
          expect(output).to eq(%w[g5 f5 e5 d5 c5 b5])
        end
      end
    end

    context "diagonal up-left movement" do
      context "when given %w[d5 a8]" do
        it "returns %w[c6 b7]" do
          output = board.intermediate_squares(%w[d5 a8])
          expect(output).to eq(%w[c6 b7])
        end
      end
    end

    context "diagonal down-left movement" do
      context "when given %w[d5 a2]" do
        it "returns %w[c4 b3]" do
          output = board.intermediate_squares(%w[d5 a2])
          expect(output).to eq(%w[c4 b3])
        end
      end
    end

    context "diagonal down-right movement" do
      context "when given %w[d5 h1]" do
        it "returns %w[e4 f3 g2]" do
          output = board.intermediate_squares(%w[d5 h1])
          expect(output).to eq(%w[e4 f3 g2])
        end
      end
    end
  end

  describe "#castling_valid_move?" do
    context "with intermediate steps occupied" do
      it "returns false" do
        output = board.castling_valid_move?("e8", "a8", 60, 64)

        expect(output).to eq false
      end
    end

    context "valid castling move" do
      before do
        cells = Array.new(65)
        cells[64] = Rook.new("\u2656", "a8")
        cells[60] = King.new("\u2654", "e8")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns true" do
        output = board.castling_valid_move?("e8", "a8", 60, 64)

        expect(output).to eq true
      end
    end
  end

  describe "#valid_move?" do

    context "initial pawn moved two squares" do
      it "returns true" do
        output = board.valid_move?(['a2', 'a4'])
        expect(output).to eq(true)
      end
    end

    context "initial pawn moved one square" do
      it "returns true" do
        output = board.valid_move?(['a2', 'a3'])
        expect(output).to eq(true)
      end
    end

    context "pawn moved one square to occupied square" do
      before do
        cells = Array.new(65)
        cells[9] = Pawn.new("\u265F", "h2")
        cells[17] = Pawn.new("\u2659", "h3")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns false" do
        output = board.valid_move?(['h2', 'h3'])
        expect(output).to eq(false)
      end
    end

    context "pawn moved two squares but intermediate square is occupied" do
      before do
        cells = Array.new(65)
        cells[9] = Pawn.new("\u265F", "h2")
        cells[17] = Pawn.new("\u2659", "h3")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns false" do
        output = board.valid_move?(['h2', 'h4'])
        expect(output).to eq(false)
      end
    end

    context "pawn moved two squares but @unmoved == false" do
      before do
        cells = Array.new(65)
        cells[9] = Pawn.new("\u265F", "h2")
        cells[9].instance_variable_set(:@unmoved, false)
        board.instance_variable_set(:@cells, cells)
      end

      it "returns false" do
        output = board.valid_move?(['h2', 'h4'])
        expect(output).to eq(false)
      end
    end

    context "pawn moved two squares to occupied square" do
      before do
        cells = Array.new(65)
        cells[9] = Pawn.new("\u265F", "h2")
        cells[25] = Pawn.new("\u2659", "h4")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns false" do
        output = board.valid_move?(['h2', 'h4'])
        expect(output).to eq(false)
      end
    end

    context "pawn moved diagonally right to take opponent chess piece" do
      before do
        cells = Array.new(65)
        cells[37] = Pawn.new("\u265F", "d5")
        cells[44] = Pawn.new("\u2659", "e6")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns true" do
        output = board.valid_move?(['d5', 'e6'])
        expect(output).to eq(true)
      end
    end

    context "pawn moved diagonally left to take opponent chess piece" do
      before do
        cells = Array.new(65)
        cells[37] = Pawn.new("\u265F", "d5")
        cells[46] = Pawn.new("\u2659", "c6")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns true" do
        output = board.valid_move?(['d5', 'c6'])
        expect(output).to eq(true)
      end
    end

    context "pawn moved diagonally left to unoccupied square" do
      before do
        cells = Array.new(65)
        cells[37] = Pawn.new("\u265F", "d5")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns false" do
        output = board.valid_move?(['d5', 'c6'])
        expect(output).to eq(false)
      end
    end

    context "pawn moved diagonally left two squares to take opponent chess piece" do
      before do
        cells = Array.new(65)
        cells[55] = Pawn.new("\u2659", "b7")
        cells[37] = Pawn.new("\u265F", "d5")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns false" do
        output = board.valid_move?(['d5', 'b7'])
        expect(output).to eq(false)
      end
    end

    context "bishop moved to square occupied by opponent's piece" do

      before do
        cells = Array.new(65)
        cells[37] = Bishop.new("\u265D", "d5")
        cells[51] = Pawn.new("\u2659", "f7")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns true" do
        output = board.valid_move?(['d5', 'f7'])
        expect(output).to eq(true)
      end
    end

    context "bishop moved to square occupied by opponent's piece but path to it blocked" do

      before do
        cells = Array.new(65)
        cells[37] = Bishop.new("\u265D", "d5")
        cells[44] = Bishop.new("\u265D", "e6")
        cells[51] = Pawn.new("\u2659", "f7")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns false" do
        output = board.valid_move?(['d5', 'f7'])
        expect(output).to eq(false)
      end
    end

    context "rook moved to square occupied by opponent's piece" do

      before do
        cells = Array.new(65)
        cells[57] = Rook.new("\u265C", "h8")
        cells[9] = Pawn.new("\u2659", "h2")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns true" do
        output = board.valid_move?(['h8', 'h2'])
        expect(output).to eq(true)
      end
    end

    context "rook moved to square occupied by opponent's piece but path to it blocked" do

      before do
        cells = Array.new(65)
        cells[57] = Rook.new("\u265C", "h8")
        cells[33] = Pawn.new("\u2659", "h5")
        cells[9] = Pawn.new("\u2659", "h2")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns false" do
        output = board.valid_move?(['h8', 'h2'])
        expect(output).to eq(false)
      end
    end

    context "queen moved to square occupied by opponent's piece" do

      before do
        cells = Array.new(65)
        cells[61] = Queen.new("\u265A", "d8")
        cells[37] = Pawn.new("\u2659", "d5")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns true" do
        output = board.valid_move?(['d8', 'd5'])
        expect(output).to eq(true)
      end
    end

    context "knight moved to square occupied by opponent's piece" do

      before do
        cells = Array.new(65)
        cells[58] = Knight.new("\u265E", "g8")
        cells[41] = Pawn.new("\u2659", "h6")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns true" do
        output = board.valid_move?(['g8', 'h6'])
        expect(output).to eq(true)
      end
    end

    context "valid castling move" do
      before do
        cells = Array.new(65)
        cells[64] = Rook.new("\u2656", "a8")
        cells[60] = King.new("\u2654", "e8")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns true" do
        output = board.valid_move?(["e8", "a8"])

        expect(output).to eq true
      end
    end
  end

  describe "#update_board" do

    context "initial pawn moved two squares" do
      it "returns piece with updated location" do
        expected = board.cells[16]
        expected.instance_variable_set(:@location,"a4")
        board.update_board(['a2', 'a4'])
        target_square = board.cells[32]

        expect(target_square).to eq(expected)
      end
    end

    context "initial pawn moved two squares" do
      it "@unmoved updated to false" do
        board.update_board(['a2', 'a4'])
        pawn = board.cells[32]

        expect(pawn.unmoved).to eq(false)
      end
    end

    context "initial pawn moved two squares" do
      it "returns piece with updated location" do
        expected = board.cells[16]
        expected.instance_variable_set(:@location,"a3")
        board.update_board(['a2', 'a3'])
        target_square = board.cells[24]

        expect(target_square).to eq(expected)
      end
    end

    context "pawn moved diagonally right to take opponent chess piece" do
      before do
        cells = Array.new(65)
        cells[37] = Pawn.new("\u265F", "d5")
        cells[44] = Pawn.new("\u2659", "e6")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns piece with updated location" do
        expected = board.cells[37]
        expected.instance_variable_set(:@location,"e6")
        board.update_board(['d5', 'e6'])
        target_square = board.cells[44]

        expect(target_square).to eq(expected)
      end
    end

    context "pawn moved diagonally right to take opponent chess piece" do
      before do
        cells = Array.new(65)
        cells[37] = Pawn.new("\u265F", "d5")
        cells[44] = Pawn.new("\u2659", "e6")
        board.instance_variable_set(:@cells, cells)
      end

      it "starting square is updated to nil" do
        board.update_board(['d5', 'e6'])
        start_square = board.cells[37]

        expect(start_square).to be_nil
      end
    end

    context "bishop moved to square occupied by opponent's piece" do

      before do
        cells = Array.new(65)
        cells[37] = Bishop.new("\u265D", "d5")
        cells[51] = Pawn.new("\u2659", "f7")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns piece with updated location" do
        expected = board.cells[37]
        expected.instance_variable_set(:@location,"f7")
        board.update_board(['d5', 'f7'])
        target_square = board.cells[51]

        expect(target_square).to eq(expected)
      end
    end

    context "bishop moved to square occupied by opponent's piece" do

      before do
        cells = Array.new(65)
        cells[37] = Bishop.new("\u265D", "d5")
        cells[51] = Pawn.new("\u2659", "f7")
        board.instance_variable_set(:@cells, cells)
      end

      it "starting square is updated to nil" do
        board.update_board(['d5', 'f7'])
        start_square = board.cells[37]

        expect(start_square).to be_nil
      end
    end

    context "white king moved to square occupied by opponent's piece" do

      before do
        cells = Array.new(65)
        cells[37] = King.new("\u265A", "d5")
        cells[45] = Pawn.new("\u2659", "d6")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns piece with updated location" do
        expected = board.cells[37]
        expected.instance_variable_set(:@location,"d6")
        board.update_board(['d5', 'd6'])
        target_square = board.cells[45]

        expect(target_square).to eq(expected)
      end
    end

    context "black king moved to square occupied by opponent's piece" do

      before do
        cells = Array.new(65)
        cells[37] = King.new("\u2654", "d5")
        cells[45] = Pawn.new("\u265F", "d6")
        board.instance_variable_set(:@cells, cells)
      end

      it "updates board @black_king_loc correctly" do
        board.update_board(['d5', 'd6'])
        black_king_loc = board.black_king_loc

        expect(black_king_loc).to eq("d6")
      end
    end

    context "white king moved to square occupied by opponent's piece" do

      before do
        cells = Array.new(65)
        cells[37] = King.new("\u265A", "d5")
        cells[45] = Pawn.new("\u2659", "d6")
        board.instance_variable_set(:@cells, cells)
      end

      it "updates board @white_king_loc correctly" do
        board.update_board(['d5', 'd6'])
        white_king_loc = board.white_king_loc

        expect(white_king_loc).to eq("d6")
      end
    end

    context "castling move" do
      before do
        cells = Array.new(65)
        cells[64] = Rook.new("\u2656", "a8")
        cells[60] = King.new("\u2654", "e8")
        board.instance_variable_set(:@cells, cells)
        # board.show
      end

      it "returns king with correctly updated location" do
        expected = board.cells[60]
        expected.instance_variable_set(:@location,"a8")
        board.update_board(['e8', 'a8'])
        target_square = board.cells[62]

        # board.show

        expect(target_square).to eq(expected)
      end
    end

    context "castling move" do
      before do
        cells = Array.new(65)
        cells[64] = Rook.new("\u2656", "a8")
        cells[60] = King.new("\u2654", "e8")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns rook with correctly updated location" do
        expected = board.cells[64]
        expected.instance_variable_set(:@location,"d8")
        board.update_board(['e8', 'a8'])
        target_square = board.cells[61]

        expect(target_square).to eq(expected)
      end
    end

    context "castling move" do
      before do
        cells = Array.new(65)
        cells[64] = Rook.new("\u2656", "a8")
        cells[60] = King.new("\u2654", "e8")
        board.instance_variable_set(:@cells, cells)
      end

      it "updates king and rook's @unmoved to false" do
        board.update_board(['e8', 'a8'])
        king_unmoved = board.cells[62].unmoved
        rook_unmoved = board.cells[61].unmoved
        output = [king_unmoved, rook_unmoved]
        output = output.all? { |value| value == false }

        expect(output).to eq(true)
      end
    end

    context "castling move" do
      before do
        cells = Array.new(65)
        cells[64] = Rook.new("\u2656", "a8")
        cells[60] = King.new("\u2654", "e8")
        board.instance_variable_set(:@cells, cells)
      end

      it "updates previously occupied squares to nil" do
        board.update_board(['e8', 'a8'])
        previous = [board.cells[60], board.cells[64]]

        expect(previous.compact).to eq([])
      end
    end

    context "castling move with black king" do
      before do
        cells = Array.new(65)
        cells[64] = Rook.new("\u2656", "a8")
        cells[60] = King.new("\u2654", "e8")
        board.instance_variable_set(:@cells, cells)
      end

      it "updates board @black_king_loc correctly" do
        board.update_board(['e8', 'a8'])
        black_king_loc = board.black_king_loc

        expect(black_king_loc).to eq("c8")
      end
    end
  end

  describe "#king_valid_moves" do
    context "initial board called with white_king_loc" do
      it "returns an empty array" do
        output = board.king_valid_moves(board.white_king_loc)

        expect(output).to eq([])
      end
    end
  end

  describe "#check?" do
    context "initially: no check on black king" do
      it "returns false" do
        output = board.check?(board.black_king_loc)

        expect(output).to eq false
      end
    end

    context "initially: no check on white king" do
      it "returns false" do
        output = board.check?(board.white_king_loc)

        expect(output).to eq false
      end
    end

    context "check on black king" do

      before do
        cells = Array.new(65)
        cells[45] = King.new("\u2654", "d6")
        cells[36] = Pawn.new("\u265F", "e5")
        board.instance_variable_set(:@black_king_loc, "d6")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns true" do
        output = board.check?(board.black_king_loc)

        expect(output).to eq true
      end
    end
  end

  describe "#checkmate?" do

    context "initially: no checkmate on white king" do
      it "returns false" do
        output = board.checkmate?(board.white_king_loc)

        expect(output).to eq false
      end
    end

    context "checkmate on black king" do

      before do
        cells = Array.new(65)
        cells[57] = King.new("\u2654", "h8")
        cells[33] = Rook.new("\u265C", "h5")
        cells[51] = Queen.new("\u265C", "f7")
        board.instance_variable_set(:@black_king_loc, "h8")
        board.instance_variable_set(:@cells, cells)
      end

      it "returns true" do
        output = board.checkmate?(board.black_king_loc)

        expect(output).to eq true
      end
  end
  end
end