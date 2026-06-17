require_relative "../lib/cell"
require_relative "../lib/player"
require "colorize"

describe Cell do
  subject(:cell) { described_class.new }

  describe "#add_piece" do
    context "when the player's colour is red" do
      let(:player1) { instance_double(Player) }

      before do
        allow(player1).to receive(:symbol).and_return("\u25CF".colorize(:red))
      end

      it "updates its symbol to be same as the player" do
        cell.add_piece(player1)
        expect(cell.symbol).to eq("\u25CF".colorize(:red))
      end
    end
  end
end
