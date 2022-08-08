# frozen_string_literal: true

require_relative '../lib/main'

describe Board do
  describe '#initialize' do
    # no method to test in initialize
  end

  describe '#change' do
    subject(:board) { described_class.new }

    context 'when a move is valid' do  
      it 'turns valid_move to true' do
        position = 1
        symbol = 'O'
        expect { board.change(position, symbol) }.to change { board.valid_move }.to true
      end
    end

    context 'when a move is not valid' do
      it 'doesn\'t change valid_move' do
        position = 10
        symbol = 'X'
        expect { board.change(position, symbol) }.not_to(change{ board.valid_move })
      end
    end

    context 'changes a position in the board\'s array into either X or O' do
      it 'changes 1 into X' do
        number = 1
        symbol = 'X'
        board.change(number, symbol)
        expect(board.array.flatten[number - 1]).to eq('X')
      end

      it 'changes 5 into X' do
        number = 5
        symbol = 'X'
        board.change(number, symbol)
        expect(board.array.flatten[number - 1]).to eq('X')
      end

      it 'changes 9 into O' do
        number = 9
        symbol = 'O'
        board.change(number, symbol)
        expect(board.array.flatten[number - 1]).to eq('O')
      end
    end
  end

  describe '#display' do
    subject(:board) { described_class.new }

    before  do
      allow(board).to receive(:puts)
      allow(board).to receive(:print)
    end

    context 'displays three arrays joined together' do
      it 'prints three times' do
        expect(board).to receive(:print).thrice
        board.display
      end

      it 'puts four times' do
        expect(board).to receive(:puts).exactly(4).times
        board.display
      end
    end
  end

  describe '#full?' do
    context 'when the board array has no integers' do
      subject(:board) { described_class.new([%w[X O X], %w[O O X], %w[X X O]]) }

      it 'is full' do
        expect(board).to be_full
      end
    end

    context 'when the board has numbers' do
      subject(:board) { described_class.new([[1, 'X', 3], [4, 'O', 'X'], [7, 8, 9]]) }

      it 'is not full' do
        expect(board).not_to be_full
      end
    end
  end
end

describe Game do
# 
end