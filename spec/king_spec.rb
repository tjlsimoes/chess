
require_relative "../lib/king.rb"

# King class tests.

describe King do
  subject(:king) { King.new("\u2654", "h5")}

  describe "#possible_moves with results sorted" do
    describe "at position h5" do
      it "returns [\"g4\", \"g5\", \"g6\", \"h4\", \"h6\"]" do
        output = king.possible_moves
        expect(output.sort).to eq(["g4", "g5", "g6", "h4", "h6"])
      end
    end
  end
end