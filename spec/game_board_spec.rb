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

  describe "#available columns" do
    context "when all columns on the board still have empty cells" do
      it "returns an array with all column numbers" do
        expect(game_board.available_columns).to eq([1, 2, 3, 4, 5, 6, 7])
      end
    end

    context "when there are no empty cells left on the board" do
      before do
        board.each do |row|
          row.each { |cell| allow(cell).to receive(:empty?).and_return(false) }
        end
      end

      it "returns an empty array" do
        expect(game_board.available_columns).to eq([])
      end
    end
  end
end
