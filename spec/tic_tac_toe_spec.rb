require_relative '../lib/main'

describe Board do
  describe '#initialize' do
    # no method to test in initialize
  end

  describe '#change' do
    context 'when a move is valid' do
      subject(:board) { described_class.new }
      it 'turns valid_move to true' do
        position = 1
        symbol = 'O'
        expect { board.change(position, symbol) }.to change { board.valid_move }.to true
      end
    end
  end
end