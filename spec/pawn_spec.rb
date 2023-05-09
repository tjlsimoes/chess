require_relative "../lib/pawn.rb"

# Pawn class tests.

describe Pawn do
  subject(:pawn) { Pawn.new("\u2659", "d5")}

  describe "#possible_moves" do
    describe "at position d5 with results sorted" do
      it "returns %w[c6 d6 e6]" do
        pawn.instance_variable_set(:@unmoved, false)
        output = pawn.possible_moves
        expect(output.sort).to eq(%w[c6 d6 e6])
      end
    end

    describe "at position d2 with @unmoved == true and results sorted" do
      subject(:pawn) { Pawn.new("\u2659", "d2")}

      it "returns %w[c3 d3 d4 e3]" do
        pawn.instance_variable_set(:@unmoved, true)
        output = pawn.possible_moves
        expect(output.sort).to eq(%w[c3 d3 d4 e3])
      end
    end
  end
end