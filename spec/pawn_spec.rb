require_relative "../lib/pawn.rb"

# Pawn class tests.

describe Pawn do
  subject(:pawn) { Pawn.new("\u265F", "d5")} # White pawn chess piece.

  describe "#possible_moves" do
    describe "white pawn at position d5 with results sorted" do
      it "returns %w[d6]" do
        pawn.instance_variable_set(:@unmoved, false)
        output = pawn.possible_moves
        expect(output.sort).to eq(%w[d6])
      end
    end

    describe "black pawn at position d5 with results sorted" do
      subject(:pawn) { Pawn.new("\u2659", "d5")}

      it "returns %w[d4]" do
        pawn.instance_variable_set(:@unmoved, false)
        output = pawn.possible_moves
        expect(output.sort).to eq(%w[d4])
      end
    end

    describe "white pawn at position d2 with @unmoved == true and results sorted" do
      subject(:pawn) { Pawn.new("\u265F", "d2")}

      it "returns %w[d3 d4]" do
        pawn.instance_variable_set(:@unmoved, true)
        output = pawn.possible_moves
        expect(output.sort).to eq(%w[d3 d4])
      end
    end

    describe "white pawn at position a2 with @unmoved == true and results sorted" do
      subject(:pawn) { Pawn.new("\u265F", "a2")}

      it "returns %w[a3 a4]" do
        pawn.instance_variable_set(:@unmoved, true)
        output = pawn.possible_moves
        expect(output.sort).to eq(%w[a3 a4])
      end
    end
  end

  describe "#get_colour" do
    context "when symbol is black" do
      subject(:pawn) { Pawn.new("\u2659", "d5")}

      it "returns 'black'" do
        output = pawn.get_colour
        expect(output).to eq('black')
      end
    end

    context "when symbol is white" do
      subject(:pawn) { Pawn.new("\u265F", "d5")}

      it "returns 'white'" do
        output = pawn.get_colour
        expect(output).to eq('white')
      end
    end
  end
end