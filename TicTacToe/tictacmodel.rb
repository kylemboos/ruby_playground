#A square can be empty, or contain a value
class Square
  attr_accessor :value
  def initialize(value = " ")
    @value = value
  end
end

#In this implementation a player only holds his given letter for the game
#However if we were to add color or ask for Player names we now have a logical place to do so.
class Player
  attr_accessor :letter
  def initialize(letter)
    @letter = letter
  end
end

#The Tic-Tac-Toe board is represented with a single dimensional array instead of a more intuitive 2D Array approach
#We ignore the 0 index and statically store the straight lines of the board in a class variable, lines
#The advantage is the simplicity of checking for a value in the board, since the number corresponding to the position is simply the index.
#The con is the extra memory to store the lines is a 2D array along with the board iteself, but that's ok here.
class Board
  @@lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  attr_accessor :board
  
  def initialize()
    @board = Array.new(10, nil)
    (1..9).each { |i| @board[i] = Square.new }
  end
  
  def get_value(i)
    return @board[i].value
  end
  #takes an array representing a valid line on the board
  #verifies if that line contains all of the same Square
  #does not count if the line contains all 'blank' Squares
  def is_line_same(line)
    return false if @board[line[0]].value == " "
    line.each do |i|
      return false unless @board[i].value == @board[line[0]].value
    end
    return true
  end
  
  #Given the square location and letter, fill that square in the board
  #If the square is taken, return false so that another location can be chosen
  def fill_square(num, letter)
    return false if num == 0
    return false if @board[num].value.is_a? Symbol
    @board[num].value = letter
    return true
  end
  
  #go through every line
  #there is a draw if non are the same
  #and all are full
  def is_draw?
    @@lines.each do |line|
      return false if is_line_same(line)
      line.each do |i|
        return false if @board[i].value == " "
      end
    end
    return true
  end
  
  #for each line
  #if that line is the same and equal to val
  #then that val won the game
  def is_winner?(val)
    @@lines.each do |line|
      return true if is_line_same(line) && @board[line[0]].value == val
    end
    return false
  end
end

#The game is responsible for keeping track of the players, who's turn, and to call functions against the board
#It would be reasonable to also contain some of the looping and game state logic of the game into this class, but not really necessary.
class Game
  attr_reader :player1
  attr_reader :player2
  attr_accessor :turn
  def initialize(player1_sym, player2_sym, whichPlayerStarts)
    @turn = whichPlayerStarts
    @player1 = Player.new(player1_sym)
    @player2 = Player.new(player2_sym)
    @board = Board.new
  end
  
  def switch_turns
    @turn = @turn == 1 ? 2 : 1
  end
  
  def make_move(num)
    sym = turn == 1 ? @player1.letter : @player2.letter
    valid = @board.fill_square(num, sym)
    return false unless valid
    return true
  end
  
  def win?
    if @turn == 1
      win = @board.is_winner?(@player1.letter)
    else
      win = @board.is_winner?(@player2.letter)
    end
    return win
  end
  
  def draw?
    return @board.is_draw?
  end
  
  def print_board
    (1..9).each do |i|
      val = @board.get_value(i)
      if val == " "
       print i
      elsif val == :X
       print "X"
      else
       print "O"
      end
      if i%3==0
        puts"\n---------"
      else
        print " | "
      end
    end
  end
end