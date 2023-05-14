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

  describe "#valid_move?" do
    context "initial pawn moved two places" do
      it "returns true" do
        output = board.valid_move?(['a2', 'a4'])
        expect(output).to eq(true)
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
  end
end