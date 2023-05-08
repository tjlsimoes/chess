
require_relative "../lib/bishop.rb"

# Bishop class tests.

describe Bishop do
  subject(:bishop) { Bishop.new("\u2657", "d5")}

  describe "#possible_moves" do
    describe "at position d5 with results sorted" do
      it "returns %w(a2 a8 b3 b7 c4 c6 e4 e6 f3 f7 g2 g8 h1)" do
        output = bishop.possible_moves
        expect(output.sort).to eq(%w(a2 a8 b3 b7 c4 c6 e4 e6 f3 f7 g2 g8 h1))
      end
    end
  end
end