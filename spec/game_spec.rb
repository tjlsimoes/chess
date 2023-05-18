require_relative "../lib/game.rb"
require_relative "../lib/board.rb"
require_relative "../lib/player.rb"


# Game class tests.

describe Game do
  subject(:game) {Game.new}

  describe "#player_piece_match?" do

    context "player 1 selecting a white pawn" do
      it "returns true" do
        user_input = ["a2", "a3"]
        player = game.instance_variable_get(:@current_player)
        output = game.player_piece_match?(user_input, player)

        expect(output).to eq(true)
      end
    end

    context "player 1 selecting a black pawn" do
      it "returns false" do
        user_input = ["a7", "a6"]
        player = game.instance_variable_get(:@current_player)
        output = game.player_piece_match?(user_input, player)

        expect(output).to eq(false)
      end
    end

  end
end