require_relative 'board'

playAgain = true

while (playAgain) do
  board = Board.new()
  puts "Enter the 1st player's name"
  name = gets.chomp
  puts "First dibs! Enter the sign you want to use for your player: X or O"
  sign = gets.chomp.upcase
  board.assignPlayer(name, sign)
  puts "Enter the 2nd player's name"
  name = gets.chomp
  sign = sign == 'X' ? 'O' : 'X'
  puts "#{name} has been auto-assigned the #{sign} sign"
  board.assignPlayer(name, sign)
  board.beginGame()
  while (board.move_count < 9) do
    board.make_a_move()
    board.check_board if (board.num_count['X'] >= 3 || board.num_count['O'] >= 3)
    if board.finished
      puts "#{board.winner} is the winner! Congrats!"
      break
    end
  end
  puts 'The game is finished, would you like to play again? Y or N'
  answer = gets.chomp.upcase
  playAgain = false if (answer == 'N')
end
