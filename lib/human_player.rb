require './lib/player'
require './lib/ship'

class HumanPlayer < Player
  def ships_list
    puts "You have the following ships to place on your board: "
    get_ships.each do |ship|
      puts "#{ship.name} = #{ship.length} spaces"
    end
  end

  def get_user_input
    gets.chomp.upcase
  end

  def place_ships
    get_ships.each do |ship|
      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces): "
      coords = get_user_input
      coords_array = Coordinates.to_a(coords)

      until @board.valid_placement?(ship, coords_array) do
        puts "Those are invalid coordinates. Please try again: "
        coords = get_user_input
        coords_array = Coordinates.to_a(coords)
      end
      @board.place(ship, coords_array)
      puts @board.render(true)
    end
  end

  def human_shot(other_player_board)
    coord = validate_player_input(other_player_board)

    until other_player_board.fire_upon(coord) do
      puts "You have already fired upon this square. Please try again."
      coord = validate_player_input(other_player_board)
    end
    return other_player_board.get_cell_at(coord)
  end

  def validate_player_input(other_player_board)
    puts "Enter the coordinate for your shot: "
    coord = get_user_input

    until other_player_board.valid_coordinate?(coord) do
      puts "Please enter valid coordinate: "
      coord = get_user_input
    end
    return coord
  end

  def take_turn(other_player_board)
    cell_fired_on = human_shot(other_player_board)
    if cell_fired_on.empty?
      puts "Your shot on #{cell_fired_on.coordinate} was a miss."
    else
      puts "Your shot on #{cell_fired_on.coordinate} was a hit."
    end
  end
end
