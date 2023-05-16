
require_relative "../lib/queen.rb"

# Queen class tests.

describe Queen do
  subject(:queen) { Queen.new("\u2655", "d5")}

  describe "#get_colour" do
    describe "when symbol is black" do
      it "returns 'black'" do
        output = queen.get_colour
        expect(output).to eq('black')
      end
    end

    describe "when symbol is white" do
      subject(:queen) { Queen.new("\u265B", "d5")}

      it "returns 'white'" do
        output = queen.get_colour
        expect(output).to eq('white')
      end
    end
  end

  describe "#possible_moves" do
    describe "at position d5 with results sorted" do
      it "returns rook and bishop combined moves" do
        output = queen.possible_moves
        expect(output.sort).to eq(["a2", "a5", "a8", "b3", "b5", "b7", "c4", "c5", "c6", "d1", "d2", "d3", "d4", "d6", "d7", "d8", "e4", "e5", "e6", "f3", "f5", "f7", "g2", "g5", "g8", "h1", "h5"])
      end
    end
  end
end