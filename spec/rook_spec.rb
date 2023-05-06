
require_relative "../lib/rook.rb"

# Rook class tests.

describe Rook do
  subject(:rook) { Rook.new("\u2656", "d5")}

  describe "#possible_moves" do
    describe "at position d5 with results sorted" do
      it "returns [\"a5\", \"b5\", \"c5\", \"d1\", \"d2\", \"d3\", \"d4\", \"d5\", \"d6\", \"d7\", \"d8\", \"e5\", \"f5\", \"g5\", \"h5\"]" do
        output = rook.possible_moves
        expect(output.sort).to eq(["a5", "b5", "c5", "d1", "d2", "d3", "d4", "d5", "d6", "d7", "d8", "e5", "f5", "g5", "h5"])
      end
    end
  end
end