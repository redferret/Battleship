require './lib/player'
require './lib/ships'

class ComputerPlayer < Player

  HORIZONTAL = :horizontal
  VERTICAL = :vertical

  def initialize(board)
    super
    @computer_ships = Ships.new
  end

  def get_random_coordinate
    y_range = rand(1..@board.size) + 64
    x_range = rand(1..@board.size)

    "#{y_range.chr}#{x_range}"
  end

  def get_ship(ship_id)
    @computer_ships.ships[ship_id]
  end

  def make_coordinates_for_ship(ship, coordinate, orientation)
    ship_length = ship.length
    start_x_coord = coordinate[1..-1].to_i
    case orientation
    when HORIZONTAL
      start_y_coord = coordinate[0]
      coordinates = []
      for count in (0...ship_length) do
        coordinates << "#{start_y_coord}#{count + start_x_coord}"
      end
      return coordinates
    when VERTICAL
      start_y_coord = coordinate[0].ord - 64
      coordinates = []
      for count in (0...ship_length) do
        coordinates << "#{(count + 64 + start_y_coord).chr}#{start_x_coord}"
      end
      return coordinates
    end
  end

  def pick_orientation
    choices = [VERTICAL, HORIZONTAL]
    choice = rand(2)
    choices[choice]
  end

  def place_ships
    ships_to_place = @computer_ships.ships.values
    ships_to_place.each do |ship|
      loop do
        break if try_to_place_ship(ship)
      end
    end
  end

  def try_to_place_ship(ship)
    place_at_coordinate = get_random_coordinate
    orientation = pick_orientation
    coordinates = make_coordinates_for_ship(ship, place_at_coordinate, orientation)

    if @board.valid_placement?(ship, coordinates)
      @board.place(ship, coordinates)
      return true
    end
    return false
  end

  def pick_north_guess(y_coord_part, x_coord_part, other_player_board)
    guess = "#{((y_coord_part - 1) + 64).chr}#{x_coord_part}"
    return guess if other_player_board.valid_coordinate?(guess)
  end

  def pick_south_guess(y_coord_part, x_coord_part, other_player_board)
    guess = "#{((y_coord_part + 1) + 64).chr}#{x_coord_part}"
    return guess if other_player_board.valid_coordinate?(guess)
  end

  def pick_east_guess(y_coord_part, x_coord_part, other_player_board)
    guess = "#{(y_coord_part + 64).chr}#{x_coord_part + 1}"
    return guess if other_player_board.valid_coordinate?(guess)
  end

  def pick_west_guess(y_coord_part, x_coord_part, other_player_board)
    guess = "#{(y_coord_part + 64).chr}#{x_coord_part - 1}"
    return guess if other_player_board.valid_coordinate?(guess)
  end

  def set_four_guesses(other_player_board, coordinate)
    y_coord_part = coordinate[0].ord - 64
    x_coord_part = coordinate[1..-1].to_i

    @guesses = [
      pick_north_guess(y_coord_part, x_coord_part, other_player_board),
      pick_east_guess(y_coord_part, x_coord_part, other_player_board),
      pick_south_guess(y_coord_part, x_coord_part, other_player_board),
      pick_west_guess(y_coord_part, x_coord_part, other_player_board)
    ].select do |guess|
      guess != nil
    end
  end

  
end
