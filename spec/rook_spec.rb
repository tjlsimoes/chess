
require_relative "../lib/rook.rb"

# Rook class tests.

describe Rook do
  subject(:rook) { Rook.new("\u2656", "d5")}

  describe "#get_colour" do
    describe "when symbol is black" do
      it "returns 'black'" do
        output = rook.get_colour
        expect(output).to eq('black')
      end
    end

    describe "when symbol is white" do
      subject(:rook) { Rook.new("\u265C", "d5")}

      it "returns 'white'" do
        output = rook.get_colour
        expect(output).to eq('white')
      end
    end
  end

  describe "#possible_moves" do
    describe "at position d5 with results sorted" do
      it "returns [\"a5\", \"b5\", \"c5\", \"d1\", \"d2\", \"d3\", \"d4\",\"d6\", \"d7\", \"d8\", \"e5\", \"f5\", \"g5\", \"h5\"]" do
        output = rook.possible_moves
        expect(output.sort).to eq(["a5", "b5", "c5", "d1", "d2", "d3", "d4", "d6", "d7", "d8", "e5", "f5", "g5", "h5"])
      end
    end
  end
end