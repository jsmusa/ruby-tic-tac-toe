class Board
  attr_reader :array, :valid_move

  def initialize(array = [[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    @array = array
    @valid_move = false
  end

  def change(position, symbol)
    @valid_move = false

    @array.map! do |numbers|
      if numbers.index(position)
        numbers[numbers.index(position)] = symbol
        @valid_move = true
      end

      numbers
    end
  end

  def display
    @array.each do |inner_array|
      puts
      print inner_array.join(' | ')
    end

    puts "\n\n"
  end

  def full?(array = @array)
    array.flatten.none?(Integer)
  end
end

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Game
  def initialize(board = Board.new)
    @player_one = nil
    @player_two = nil
    @board = board
  end

  def create_player(number, symbol)
    print "Player #{number}: "
    name = gets.chomp
    Player.new(name, symbol)
  end

  def check(array)
    array.each { |mini_array|return true if mini_array.uniq.size == 1 }

    false
  end

  def diagonal_check(array)
    if [array[0][0], array[1][1], array[2][2]].uniq.size == 1 ||
       [array[0][2], array[1][1], array[2][0]].uniq.size == 1
      true
    else
      false
    end
  end

  def over?
    check(@board.array.transpose) || check(@board.array) || diagonal_check(@board.array)
  end

  def player_input(player)
    loop do
      puts "Enter your move, #{player.name}:"
      number = gets.chomp
      break number.to_i if number.match?(/^[1-9]$/)

      puts 'Invalid input, please try again'
    end
  end

  def play
    @player_one = create_player(1, 'X')
    @player_two = create_player(2, 'O')
    current_player = [@player_one, @player_two]

    loop do
      @board.display

      if over?
        puts "#{current_player[1].name} wins!"
        break
      elsif @board.full?
        puts 'Game Over! It\'s a tie game!'
        break
      end

      number = player_input(current_player[0])
      puts `clear`
      @board.change(number, current_player[0].symbol)
      @board.valid_move ? current_player.reverse! : (puts 'Invalid move')
    end
  end
end

# my_game = Game.new
# my_game.play
