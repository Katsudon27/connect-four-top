require_relative "../lib/game_controller"
require_relative "../lib/game_board"
require_relative "../lib/player"
require_relative "../lib/cell"

describe GameController do
  subject(:game_controller) { described_class.new(first_player, second_player, game_board) }

  let(:first_player) { instance_double(Player) }
  let(:second_player) { instance_double(Player) }
  let(:game_board) { instance_double(GameBoard) }
  let(:created_board) { Array.new(6) { Array.new(7) { instance_double(Cell) } } }

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

  describe "#player_win?" do
    before do
      allow(first_player).to receive(:symbol).and_return("\u25CF".colorize(:red))
      allow(game_board).to receive(:board).and_return(created_board)
      created_board.each do |row|
        row.each { |cell| allow(cell).to receive(:symbol).and_return("") }
      end
    end

    context "when a player places four pieces horizontally" do
      before do
        allow(created_board[5][0]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[5][1]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[5][2]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[5][3]).to receive(:symbol).and_return("\u25CF".colorize(:red))
      end

      it "returns true" do
        expect(game_controller).to be_player_win
      end
    end

    context "when a player places four pieces vertically" do
      before do
        allow(created_board[1][3]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[2][3]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[3][3]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[4][3]).to receive(:symbol).and_return("\u25CF".colorize(:red))
      end

      it "returns true" do
        expect(game_controller).to be_player_win
      end
    end

    context "when a player places four pieces in an ascending diagonal" do
      before do
        allow(created_board[3][0]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[2][1]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[1][2]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[0][3]).to receive(:symbol).and_return("\u25CF".colorize(:red))
      end

      it "returns true" do
        expect(game_controller).to be_player_win
      end
    end

    context "when a player places four pieces in a descending diagonal" do
      before do
        allow(created_board[0][3]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[1][4]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[2][5]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[3][6]).to receive(:symbol).and_return("\u25CF".colorize(:red))
      end

      it "returns true" do
        expect(game_controller).to be_player_win
      end
    end

    context "when a player has not yet won" do
      before do
        allow(created_board[0][3]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[1][4]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[2][5]).to receive(:symbol).and_return("\u25CF".colorize(:red))
      end

      it "returns false" do
        expect(game_controller).not_to be_player_win
      end
    end
  end
end
