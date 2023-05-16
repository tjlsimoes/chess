
require_relative "../lib/knight.rb"

# Knight class tests.

describe Knight do
  subject(:knight) { Knight.new("\u2658", "d5")}

  describe "#get_colour" do
    describe "when symbol is black" do
      it "returns 'black'" do
        output = knight.get_colour
        expect(output).to eq('black')
      end
    end

    describe "when symbol is white" do
      subject(:knight) { Knight.new("\u265E", "d5")}

      it "returns 'white'" do
        output = knight.get_colour
        expect(output).to eq('white')
      end
    end
  end
  
  describe "#possible_moves" do
    describe "at position d5 with results sorted" do
      it "returns %w(b4 b6 c3 c7 e3 e7 f4 f6)" do
        output = knight.possible_moves
        expect(output.sort).to eq(["b4", "b6", "c3", "c7", "e3", "e7", "f4", "f6"])
      end
    end
  end
end