class Board
  attr_reader :array

  def initialize
    @array = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] 
  end

  def change(position, symbol)
    @array.map! do |numbers|
      unless numbers.index(position) == nil
        numbers[numbers.index(position)] = symbol
        numbers 
      else numbers end
    end
  end

  def display
    @array.each do |inner_array|
      puts
      print inner_array.join(" | ")
    end

    puts
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

  def is_over?
    check(@board.array.transpose) || check(@board.array)
  end

  def play
    loop do
      puts "Enter your move, #{@current_player[0].name}:"
      @number = gets.chomp.to_i
      @board.change(@number, @current_player[0].symbol)
      
      show()
      @current_player.reverse! 
    
      break if (is_over?() == true)
    end
  end
end

my_game = Game.new
my_game.show
my_game.play
# user inputs name
# creates user array
# other user inputs name
# creates other user array 
# start game
# user inputs move
# move gets stored in user array
# other user inputs move
# move gets stored in other user array
# repeat until somebody wins