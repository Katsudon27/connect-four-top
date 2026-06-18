require_relative "../lib/game_controller"
require_relative "../lib/game_board"
require_relative "../lib/player"

describe GameController do
  subject(:game_controller) { described_class.new(first_player, second_player, game_board) }

  let(:first_player) { instance_double(Player) }
  let(:second_player) { instance_double(Player) }
  let(:game_board) { instance_double(GameBoard) }

  describe "#switch_turn" do
    context "when the current player is player 1" do
      it "switches to the other player as the current player" do
        game_controller.switch_turn
        expect(game_controller.instance_variable_get(:@current_player)).to eq(second_player)
      end
    end
  end

  describe "#draw_game?" do
    before do
      allow(game_board).to receive(:cells_empty?)
    end

    it "sends #cells_empty? to game board" do
      game_controller.draw_game?
      expect(game_board).to have_received(:cells_empty?)
    end
  end
end
