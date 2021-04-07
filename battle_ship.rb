require './lib/human_player'
require './lib/computer_player'

def print_boards
  puts "=============COMPUTER BOARD============="
  puts computer_player.render_board
  puts "==============PLAYER BOARD=============="
  puts human_player.render_board(true)
end

human_board = Board.new(10)
computer_board = Board.new(10)

human_player = HumanPlayer.new(human_board)
computer_player = ComputerPlayer.new(computer_board)

puts "Welcome to BATTLESHIP"
print "Enter p to play. Enter q to quit: "
menu_select = gets.chomp.downcase

while menu_select != 'p' and menu_select != 'q'
  puts "Invalid menu option"
  print "Enter p to play. Enter q to quit: "
  menu_select = gets.chomp.downcase
end

case menu_select
when 'p'
  computer_player.place_ships

  puts "I have laid out my ships on the grid."
  puts "You now need to lay out your two ships."

  human_player.ships_list
  puts human_player.render_board(true)
  human_player.place_ships

  loop do
    print_boards

    human_player.take_turn(computer_board)
    computer_player.take_turn(human_board)

    if human_player.all_sunk?
      puts "I win!"
      break
    end

    if computer_player.all_sunk?
      puts "You win!"
      break
    end
  end
when 'q'
  puts 'Bye'
end

print_boards