
require_relative "../lib/knight.rb"

# Knight class tests.

describe Knight do
  subject(:knight) { Knight.new("\u2658", "d5")}

  describe "#possible_moves" do
    describe "at position d5 with results sorted" do
      it "returns %w(b4 b6 c3 c7 e3 e7 f4 f6)" do
        output = knight.possible_moves
        expect(output.sort).to eq(["b4", "b6", "c3", "c7", "e3", "e7", "f4", "f6"])
      end
    end
  end
end