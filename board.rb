require_relative 'user'
require 'set'

class Board
  attr_reader :users, :move_count, :num_count, :finished, :winner
  def initialize
    @board = Array.new(3) { Array.new(3, '?') }
    @users = []
    @move_count = 0
    @current_move = 0
    @num_count = {"X" => 0, "O" => 0}
    @finished = false
    @winner = nil
    @player_signs = {"X" => "", "Y" => ""}
  end

  def assignPlayer(name, sign)
    user = User.new(name, sign)
    if @users.length < 2
      @player_signs[sign] = name
      @users << user
    else
      puts 'Cannot have more than 2 players!'
    end
  end

  def beginGame
    if @users.length == 2
      puts 'Game starting...'
    else
      puts 'You need atleast 2 players to play!'
    end
  end

  def display_board
    puts '****************'
    for i in (0...@board.length)
      str = ""
      puts '*    *    *    *'
      for j in (0...@board[i].length)
        if j == 0
          str += "* #{@board[i][j]}  *"
        else
          str += " #{@board[i][j]}  *"
        end
      end
      puts str
      puts '*    *    *    *'
      puts '****************'
    end
  end

  def make_a_move
    puts "#{users[@current_move].name}, please make your move! The following squares are currently available:"
    display_board
    puts 'Make your choice from one of the squares (1-9)'
    square = gets.chomp.to_i
    i = ((square - 1)/3)
    j = (square - 1) % 3
    if (@board[i][j] != '?')
      puts 'That square is already taken, please choose another square!'
      make_a_move
    else
      puts 'Move registered!'
      @move_count += 1
      sign = users[@current_move].sign
      @board[i][j] = sign
      @num_count[sign] += 1
      @current_move = @current_move == 0 ? 1 : 0
      display_board
    end
  end

  def check_board
    check_rows
    check_columns
    check_diagonals
  end

  def check_rows
    set = Set.new()
    for i in (0...@board.length)
      set = Set.new(@board[i])
      if (set.size === 1 && (set.to_a[0] == 'X' || set.to_a[0] == 'O'))
        @finished = true
        @winner = @player_signs[set.to_a[0]]
      end
    end
  end

  def check_columns
    for i in (0...@board.length)
      set = Set.new()
      for j in (0...@board[i].length)
        set.add(@board[j][i])
      end
      if (set.size === 1 && (set.to_a[0] == 'X' || set.to_a[0] == 'O'))
        @finished = true
        @winner = @player_signs[set.to_a[0]]
      end
    end
  end

  def check_diagonals
    #hard coded the diagonals because when is a tic-tac square not 3x3?
    left_diagonal = [@board[0][0], @board[1][1], @board[2][2]]
    right_diagonal = [@board[0][2], @board[1][1], @board[2][0]]
    set = Set.new(left_diagonal)
    if (set.size === 1 && (set.to_a[0] == 'X' || set.to_a[0] == 'O'))
      @finished = true
      @winner = @player_signs[set.to_a[0]]
      return
    end
    set = Set.new(right_diagonal)
    if (set.size === 1 && (set.to_a[0] == 'X' || set.to_a[0] == 'O'))
      @finished = true
      @winner = @player_signs[set.to_a[0]]
    end
  end

end



