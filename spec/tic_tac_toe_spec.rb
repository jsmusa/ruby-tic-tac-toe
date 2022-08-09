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
  describe '#initialize' do
    context 'Board class is sent a method' do
      it 'receives initialize call' do
        expect(Board).to receive(:new)
        described_class.new
      end
    end
  end

  describe '#create_player' do
    subject(:game) { described_class.new }

    context 'Player class receives a call' do
      it 'receives :new call' do
        allow(game).to receive(:print)
        allow(game).to receive(:gets).and_return('Asda')

        symbol = 'X'
        number = 1
        expect(Player).to receive(:new).with('Asda', symbol)
        game.create_player(number, symbol)
      end
    end
  end

  describe '#check' do
    subject(:game) { described_class.new }

    context 'when an array element are all the same' do
      it 'returns true' do
        array = [%w[X X X], [4, 'O', 'O'], [7, 8, 9]]
        expect(game.check(array)).to be true
      end
    end

    context 'when no element of an array are all the same' do
      it 'returns false' do
        array = [%w[X O X], %w[O X O], %w[X O X]]
        expect(game.check(array)).to be false
      end
    end
  end

  describe '#diagonal_check' do
    subject(:game) { described_class.new }

    context 'when the diagonal in the array aren\'t all the same' do
      it 'returns false' do
        array = [%w[X O O],
                 %w[O X X],
                 ['X', 8, 9]]
        expect(game.diagonal_check(array)).to be false
      end
    end

    context 'when the diagonal in the array are all the same' do
      it 'returns true' do
        array = [%w[X O O],
                 %w[O X X],
                 %w[X O X]]
        expect(game.diagonal_check(array)).to be true
      end

      it 'returns true' do
        array = [%w[X O O],
                 %w[X O X],
                 %w[O X O]]
        expect(game.diagonal_check(array)).to be true
      end
    end
  end

  describe '#over?' do
    subject(:game) { described_class.new(board) }
    let(:board) { instance_double(Board) }

    before do
      allow(board).to receive(:array).and_return(Array.new)
      allow(board.array).to receive(:transpose)
    end

    context 'check method is used on game board\'s array\'s transpose' do
      it 'is over' do
        allow(game).to receive(:check).and_return(true)
        expect(game).to be_over
      end
    end

    context 'check method is used on game board\'s array' do
      it 'is over' do
        allow(game).to receive(:check).and_return(false, true)
        expect(game).to be_over
      end
    end

    context 'diagonal check method is used on game board\'s array' do
      it 'is over' do
        allow(game).to receive(:check).and_return(false, false)
        allow(game).to receive(:diagonal_check).and_return(true)
        expect(game).to be_over
      end
    end

    it 'isn\'t over' do
      allow(game).to receive(:check).and_return(false)
      allow(game).to receive(:diagonal_check).and_return(false)
      expect(game).not_to be_over
    end
  end

  describe '#player_input' do
    subject(:game) { described_class.new }
    let(:player) { double('player') }

    before do
      allow(player).to receive(:name)
      allow(game).to receive(:puts)
      intro = "Enter your move, #{player.name}:"
      expect(game).to receive(:puts).and_return(intro)
    end

    context 'input is valid' do
      it 'returns number 9' do
        number = '9'
        allow(game).to receive(:gets).and_return(number)
        expect(game.player_input(player)).to be(9)
      end

      it 'returns number 1' do
        number = '1'
        allow(game).to receive(:gets).and_return(number)
        expect(game.player_input(player)).to be(1)
      end
    end

    context 'input is invalid' do
      it 'prints a message once' do
        invalid = '100'
        valid = '8'
        allow(game).to receive(:gets).and_return(invalid, valid)
        error_message = 'Invalid input, please try again'
        expect(game).to receive(:puts).and_return(error_message).once
        game.player_input(player)
      end
    end
  end

  describe '#play' do
    # 
  end
end