class Board
  attr_reader :array, :valid

  def initialize
    @array = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  def change(position, symbol)
    @valid = false
    @array.map! do |numbers|
      unless numbers.index(position) == nil
        @valid = true
        numbers[numbers.index(position)] = symbol
        numbers 
      else 
        numbers 
      end
    end
  end

  def display
    @array.each do |inner_array|
      puts
      print inner_array.join(" | ")
    end

    puts
  end

  def is_full?
    @array.flatten.none?(Integer)
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
  def initialize
    @player_one = create_player(1, "X")
    @player_two = create_player(2, "O")
    @board = Board.new
    @current_player = [@player_one, @player_two]
    @game_over = false
  end

  def create_player(number, symbol)
    print "Player #{number}: "
    name = gets.chomp
    Player.new(name, symbol)
  end

  def show
    @board.display
    puts
  end

  def check(array)
    array.each do |inner_array|
      if inner_array.uniq.length == 1 then return true end
    end

    false
  end

  def diagonal_check(array)
    if [array[0][0], array[1][1], array[2][2]].uniq.size == 1 || 
       [array[0][2], array[1][1], array[2][0]].uniq.size == 1
      return true
    else false end
  end

  def is_over?
    @game_over = check(@board.array.transpose) || check(@board.array) ||
                 diagonal_check(@board.array)
  end

  def play
    loop do
      puts "Enter your move, #{@current_player[0].name}:"
      @number = gets.chomp.to_i
      @board.change(@number, @current_player[0].symbol)
      show()

      if @board.valid == true
        is_over?()
        @current_player.reverse!
      else puts "Invalid Input", "\n" end
    
      if @game_over == true
        puts "#{@current_player[1].name} wins!"
        break
      elsif @board.is_full? == true
        puts "Game Over! It's a tie game!"
        break
      end
    end
  end
end

my_game = Game.new
my_game.show
my_game.play