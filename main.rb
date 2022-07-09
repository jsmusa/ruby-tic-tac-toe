class Board
  def initialize
    @array = [[2, 1], [7, 2], [6, 3], [9, 4],[5, 5], [1, 6], [4, 7], [3, 8], [8, 9]] 
  end

  def pick(number)
    @array[number - 1][0]
  end

  def display
    @array.each_with_index do |inner_array, idx|
      puts if (idx + 1) % 3 == 1
      print "| #{inner_array[1]} | "
    end
    puts
  end
end

class Player
  attr_accessor :name

  def initialize(name)
    @name = name
    @array = []
  end

  def add_to_array(number)
    @array.push(number)
  end
end

class Game
  def initialize
    @player_one = create_player(1)
    @player_two = create_player(2)
    @board = Board.new
  end

  def create_player(number)
    print "Player #{number}: "
    name = gets.chomp
    Player.new(name)
  end

  def show
    @board.display
  end
end

my_game = Game.new
my_game.show
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