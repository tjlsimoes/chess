require_relative "../lib/board.rb"

# Board class tests.

describe Board do
  subject(:board) {Board.new}

  describe "#initial_board" do

    it "returns an array of corectly placed 65 elements" do
      board.show
      output = board.cells # Also works with Board.initial_board
      expect(output.length).to eq(65)
    end
  end
end