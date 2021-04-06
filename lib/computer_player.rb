require './lib/player'
require './lib/ships'

class ComputerPlayer < Player
  attr_reader :board

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
      number_of_coords = start_x_coord + (ship_length - 1)
      coordinates = []
      for count in (start_x_coord..number_of_coords) do
        coordinates << "#{start_y_coord}#{count}"
      end
      return coordinates
    when VERTICAL
      start_y_coord = coordinate[0].ord - 64
      number_of_coords = start_y_coord + (ship_length - 1)
      coordinates = []
      for count in (start_y_coord..number_of_coords) do
        coordinates << "#{(count + 64).chr}#{start_x_coord}"
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
    ships_to_place = @computer_ships.ships
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

  def take_turn
    # when a computer takes a turn
    # 1) Randomly pick a coordinate to fire on
    # 2) if a miss, go back to step 1) on next turn
    # 3) if a hit remember that location for next turn and goto step 4)
    # 4) pick 4 of the cells around the remembered hit
    # 5) if a miss continue searching around the known hit
    # 6) if a hit is found next to a hit remember that direction and keep
    #    going for hits until the ship is sunk
    # 7) once a ship is sunk go back to step 1

  end
end
