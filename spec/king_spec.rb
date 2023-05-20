
require_relative "../lib/king.rb"

# King class tests.

describe King do
  subject(:king) { King.new("\u2654", "h5")}

  describe "#get_colour" do
    describe "when symbol is black" do
      it "returns 'black'" do
        output = king.get_colour
        expect(output).to eq('black')
      end
    end

    describe "when symbol is white" do
      subject(:king) { King.new("\u265A", "d5")}

      it "returns 'white'" do
        output = king.get_colour
        expect(output).to eq('white')
      end
    end
  end

  describe "#possible_moves with results sorted" do
    describe "at position h5" do
      it "returns [\"g4\", \"g5\", \"g6\", \"h4\", \"h6\"]" do
        output = king.possible_moves
        expect(output.sort).to eq(["g4", "g5", "g6", "h4", "h6"])
      end
    end
  end

  describe "#possible_moves with results sorted" do
    describe "at position e1" do
      subject(:king) { King.new("\u265A", "e1")}

      it "returns %w[d1 d2 e2 f1 f2]" do
        output = king.possible_moves
        expect(output.sort).to eq(%w[d1 d2 e2 f1 f2])
      end
    end
  end
end