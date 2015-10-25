#ttt game using OOP

class Board
  WINNING_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

  attr_accessor :data
 
  def initialize
    @data = {}
    (1..9).each {|n| @data[n] = ' '}
  end

  def draw
    sleep(0.5)
    system 'clear'
    puts " #{data[1]} | #{data[2]} | #{data[3]}"
    puts "-----------"
    puts " #{data[4]} | #{data[5]} | #{data[6]}"
    puts "-----------"
    puts " #{data[7]} | #{data[8]} | #{data[9]}"
  end

  def available_squares
    @data.select {|_, value| value == ' '}.keys 
  end

  def square_open?(position)
    available_squares.include?(position)
  end

  def mark_square(position, mark)
    @data[position] = mark
  end

  def no_available_squares?
    available_squares.empty?
  end

  def winning_position?(mark)
    WINNING_LINES.each do |line|
      return true if @data[line[0]] == mark && @data[line[1]] == mark && @data[line[2]] == mark
    end
    false
  end
end

class Player
  attr_accessor :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end
end

class Game

  def initialize
    @board = Board.new
    @human = Player.new('Andrew', 'X')
    @computer = Player.new('T-1000', 'O')
    @current_player = @human
    puts "Let's Play Tic Tac Toe!"
  end

  def play
    loop do
    @board.draw
    current_player_marks_square
    @board.draw
      if @board.no_available_squares?
        puts "It's a tie."
        break
      end
      
      if @board.winning_position?(@current_player.mark)
        puts "#{@current_player.name} wins!"
        break
      end
    alternate
    end 
  end

  def current_player_marks_square
    if @current_player == @human
      puts "Choose an empty square between 1-9"
      position = gets.chomp.to_i
        until @board.square_open?(position)
          puts "You must choose an open square."
          position = gets.chomp.to_i              
        end 
    else
      position = @board.available_squares.sample     
    end 
    @board.mark_square(position, @current_player.mark)
  end

  def alternate
    if @current_player == @human
      @current_player = @computer
    else
      @current_player = @human
    end
  end
end

Game.new.play