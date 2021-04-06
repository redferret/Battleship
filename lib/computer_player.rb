require './lib/player'
require './lib/ships'

class ComputerPlayer < Player

  HORIZONTAL = :horizontal
  VERTICAL = :vertical

  def initialize(board)
    super
    @computer_ships = Ships.new
    @previous_hit = nil
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

  def the_choice_is_a_hit?(fire_on_cell)
    if not fire_on_cell.empty?
      puts "My shot on #{fire_on_cell.coordinate} was a hit"
      return true
    else
      puts "My shot on #{fire_on_cell.coordinate} was a miss"
      return false
    end
  end

  def cell_was_not_fired_on?(fire_on_cell, other_player_board)
    if not fire_on_cell.fired_upon?
      fire_on_cell.fire_upon

      if the_choice_is_a_hit?(fire_on_cell)
        yield if block_given?
      end
      return true
    end
    return false
  end

  def attempt_to_fire_on(other_player_board, fire_on_coordinate)
    fire_on_cell = other_player_board.get_cell_at(fire_on_coordinate)

    if fire_on_cell
      if cell_was_not_fired_on?(fire_on_cell, other_player_board) do
          yield(fire_on_cell) if block_given?
        end
        return true
      end
    end
    return false
  end

  def make_a_random_selection(other_player_board)
    loop do
      fire_on_coordinate = get_random_coordinate
      break if attempt_to_fire_on(other_player_board, fire_on_coordinate) do |fire_on_cell|
        remember_previous_hit(fire_on_cell)
        set_four_guesses(other_player_board, fire_on_coordinate)
      end
    end
  end

  def make_a_guess_around_cell(other_player_board)
    loop do
      fire_on_coordinate = @guesses.pop
      if not fire_on_coordinate
        fire_on_coordinate = get_random_coordinate
      end
      break if attempt_to_fire_on(other_player_board, fire_on_coordinate) do |fire_on_cell|
        if fire_on_cell.ship.sunk?
          @guesses = []
        end
      end
    end
    move_on?
  end

  def take_turn(other_player_board)
    if no_previous_hit_made?
      make_a_random_selection(other_player_board)
    else
      make_a_guess_around_cell(other_player_board)
    end
  end

  def move_on?
    if @guesses.length == 0
      forget_previous_hit
    end
  end

  def forget_previous_hit
    @previous_hit = nil
  end

  def remember_previous_hit(cell_to_remember)
    @previous_hit = cell_to_remember
  end

  def previous_hit_made?
    @previous_hit != nil
  end

  def the_previous_hit?
    @previous_hit
  end

  def no_previous_hit_made?
    not previous_hit_made?
  end

end
