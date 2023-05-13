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
end