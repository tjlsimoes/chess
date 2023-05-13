
require_relative "../lib/king.rb"

# King class tests.

describe King do
  subject(:king) { King.new("\u2654", "h5")}

  describe "#get_colour" do
    describe "when symbol is white" do
      it "returns 'white'" do
        output = king.get_colour
        expect(output).to eq('white')
      end
    end

    describe "when symbol is black" do
      subject(:king) { King.new("\u265A", "d5")}

      it "returns 'black'" do
        output = king.get_colour
        expect(output).to eq('black')
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
end