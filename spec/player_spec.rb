require_relative "../lib/player"

describe Player do
  subject(:player) { described_class.new("Player 1", :red) }

  describe "#choose_column" do
    context "when the player typed 2 into the terminal" do
      before do
        allow(player).to receive(:puts)
        allow(player).to receive(:gets).and_return("2")
      end

      it "returns 2" do
        expect(player.choose_column).to eq(2)
      end
    end
  end
end
