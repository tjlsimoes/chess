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

    describe "#check_on_oneself?(user_input, player)" do

      context "black pawn move covering black king from check" do
        before do
          cells = Array.new(65)
          cells[60] = King.new("\u2654", "e8")
          game.board.instance_variable_set(:@black_king_loc, "e8")
          cells[53] = Pawn.new("\u2659", "d7")
          cells[32] = Queen.new("\u265B", "a4")
          game.board.instance_variable_set(:@cells, cells)

          game.instance_variable_set(:@current_player, game.second_player)
        end

        it "returns true" do
          output = game.check_on_oneself?(%w[d7 d6], game.current_player)

          expect(output).to eq true
        end
      end

      context "black pawn move covering black king from check" do
        before do
          cells = Array.new(65)
          cells[4] = King.new("\u265A", "e1")
          game.board.instance_variable_set(:@white_king_loc, "e1")
          cells[11] = Pawn.new("\u265F", "f2")
          cells[25] = Queen.new("\u2655", "h4")
          game.board.instance_variable_set(:@cells, cells)
        end

        it "returns true" do
          output = game.check_on_oneself?(%w[f2 f3], game.current_player)

          expect(output).to eq true
        end
      end
    end
end