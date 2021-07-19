require './lib/human_player'
require './lib/computer_player'

class BattleShipGame
  def initialize
    human_board = Board.new(10)
    computer_board = Board.new(10)
    @human_player = HumanPlayer.new(human_board)
    @computer_player = ComputerPlayer.new(computer_board)
  end

  def start
    welcome_menu
    place_ships
    game_loop
  end

  def welcome_menu
    puts "Welcome to BATTLESHIP"
    print "Enter p to play. Enter q to quit: "
    menu_select = gets.chomp.downcase

    while menu_select != 'p' and menu_select != 'q'
      puts "Invalid menu option"
      print "Enter p to play. Enter q to quit: "
      menu_select = gets.chomp.downcase
    end
  end

  def place_ships
    @computer_player.place_ships

    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your ships."

    @human_player.ships_list
    puts @human_player.render_board(true)
    @human_player.place_ships
  end

  def game_loop
    loop do
      print_boards

      @human_player.take_turn(@computer_player.board)
      @computer_player.take_turn(@human_player.board)

      if @human_player.all_sunk?
        puts "I win!"
        break
      end

      if @computer_player.all_sunk?
        puts "You win!"
        break
      end
    end
  end
  
  def print_boards
    puts "=============COMPUTER BOARD============="
    puts @computer_player.render_board
    puts "==============PLAYER BOARD=============="
    puts @human_player.render_board(true)
  end

  def play
    welcome_menu
    case menu_select
    when 'p'
      place_ships
      game_loop
      print_boards
    when 'q'
      puts 'Bye'
    end
  end
end
