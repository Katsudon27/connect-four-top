require_relative "../lib/game_board"
require_relative "../lib/cell"
require_relative "../lib/player"

describe GameBoard do
  subject(:game_board) { described_class.new }

  let(:player1) { instance_double(Player) }
  let(:board) { game_board.instance_variable_get(:@board) }
  let(:cell1_col2) { board[5][1] }

  describe "#add_piece" do
    context "when a player places a piece in an empty column 2" do
      before do
        allow(cell1_col2).to receive(:add_piece)
      end

      it "sends add_piece to the last cell of the column" do
        game_board.add_piece(2, player1)
        expect(cell1_col2).to have_received(:add_piece).once
      end
    end

    context "when a player places a piece in a non-empty column 2" do
      let(:cell2_col2) { board[4][1] }

      before do
        allow(cell1_col2).to receive(:empty?).and_return(false)
        allow(cell2_col2).to receive(:add_piece)
      end

      it "sends add_piece to the cell above the non-empty cell" do
        game_board.add_piece(2, player1)
        expect(cell2_col2).to have_received(:add_piece).once
      end
    end
  end

  describe "#cells_empty?" do
    context "when there are still empty cells left on the board" do
      it "returns true" do
        expect(game_board).to be_cells_empty
      end
    end

    context "when there are no empty cells left on the board" do
      before do
        board.each do |row|
          row.each { |cell| allow(cell).to receive(:empty?).and_return(false) }
        end
      end

      it "returns false" do
        expect(game_board).not_to be_cells_empty
      end
    end
  end
end
