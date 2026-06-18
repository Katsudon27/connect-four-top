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
    context "when there are still empty cells on the board" do
      before do
        allow(game_board).to receive(:available_columns).and_return([1, 2])
      end

      it "returns false" do
        expect(game_controller).not_to be_draw_game
      end
    end

    context "when there are no empty cells left on the board" do
      before do
        allow(game_board).to receive(:available_columns).and_return([])
      end

      it "returns an empty array" do
        expect(game_controller).to be_draw_game
      end
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

    context "when a player places four pieces horizontally with [5, 0] as last move" do
      before do
        allow(created_board[5][0]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[5][1]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[5][2]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[5][3]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(game_board).to receive(:latest_move).and_return([5, 0])
      end

      it "returns true" do
        expect(game_controller).to be_player_win
      end
    end

    context "when a player places four pieces vertically with [4, 3] as last move" do
      before do
        allow(created_board[1][3]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[2][3]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[3][3]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[4][3]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(game_board).to receive(:latest_move).and_return([4, 3])
      end

      it "returns true" do
        expect(game_controller).to be_player_win
      end
    end

    context "when a player places four pieces in an ascending diagonal with [2, 1] as last move" do
      before do
        allow(created_board[3][0]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[2][1]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[1][2]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[0][3]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(game_board).to receive(:latest_move).and_return([2, 1])
      end

      it "returns true" do
        expect(game_controller).to be_player_win
      end
    end

    context "when a player places four pieces in a descending diagonal with [2, 5] as last move" do
      before do
        allow(created_board[0][3]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[1][4]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[2][5]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(created_board[3][6]).to receive(:symbol).and_return("\u25CF".colorize(:red))
        allow(game_board).to receive(:latest_move).and_return([2, 5])
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
        allow(game_board).to receive(:latest_move).and_return([1, 4])
      end

      it "returns false" do
        expect(game_controller).not_to be_player_win
      end
    end
  end

  describe "#prompt_player_input" do
    before do
      allow(first_player).to receive(:choose_column)
    end

    it "sends make_move to the current player" do
      game_controller.prompt_player_input
      expect(first_player).to have_received(:choose_column).once
    end
  end

  describe "#add_piece" do
    context "when the current player places his piece in column 1" do
      before do
        allow(game_board).to receive(:add_piece)
      end

      it "sends add_piece" do
        player_move = "1"
        game_controller.add_piece(player_move)
        expect(game_board).to have_received(:add_piece)
      end
    end
  end
end
