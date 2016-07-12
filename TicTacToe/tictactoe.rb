require_relative 'tictacmodel'

puts "Let's Play Tic Tac Toe..."

#--Coin Toss--
puts "Player 1, heads or tails?... (H/T):"
playerOneCall = gets.chomp.downcase
until playerOneCall == "h" || playerOneCall == "t" do
  puts "Incorrect Call, Try Again:"
  playerOneCall = gets.chomp.downcase
end
playerOneBit = playerOneCall == "h" ? 0 : 1
coinFlip = Random.rand(2)
#XOR the call against the random coin flip to determine who won
playerChoice = playerOneBit^coinFlip == 1 ? 2 : 1
puts "Player #{playerChoice} won the toss. Pick X or O?... (X/O):"

#--Pick Pieces--
playerPiece = gets.chomp.downcase
until playerPiece == 'x' || playerPiece == 'o' do
  puts "Incorrect Piece, X or O buddy:"
  playerPiece = gets.chomp.downcase
end
playerPiece = playerPiece == 'x' ? :X : :O
secondPiece = playerPiece == :X ? :O : :X
#Initialize the game based on who goes first and the chosen pieces 
if(playerChoice == 1)
  $game = Game.new(playerPiece, secondPiece, playerChoice)  
else
  $game = Game.new(secondPiece, playerPiece, playerChoice) 
end

#--Game Loop--
#in every loop:
#the game board is printed.
#the current player picks a number on the board that is free
#that move is made if valid
#the game checks whether or not the game is over
#if not the players switch
while true do
  $game.print_board
  puts "Player #{$game.turn}, your turn. Pick a number.."
  moveNumber = gets.chomp.to_i
  success = $game.make_move(moveNumber)
  until success == true do
    puts "Not a valid move.. a number I said!"
    moveNumber = gets.chomp.to_i
    success = $game.make_move(moveNumber)
  end
  if $game.win? 
    puts "Player #{$game.turn} Wins!"
    break
  elsif $game.draw?
    puts "Tie Game!"
    break
  else
    $game.switch_turns
  end
end