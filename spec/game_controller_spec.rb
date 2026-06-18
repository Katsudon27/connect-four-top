require_relative "../lib/game_controller"
require_relative "../lib/game_board"
require_relative "../lib/player"

describe GameController do
  subject(:game_controller) { described_class.new(player1, player2, game_board) }

  let(:first_player) { instance_double(Player) }
  let(:second_player) { instance_double(Player) }
  let(:game_board) { instance_double(GameBoard) }
end
