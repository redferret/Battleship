require './lib/ship'
require './lib/cell'
require './lib/coordinates'

class Board
  attr_reader :cells,
              :size

  def initialize(size = 4)
    @cells = {}
    @size = size

    (1..@size).each do |row|
      x_coord = (row + 64).chr
      (1..@size).each do |column|
        coordinate = "#{x_coord}#{column}"
        @cells[coordinate] = Cell.new(coordinate)
      end
    end
  end

  def fire_upon(coordinate)
    if not get_cell_at(coordinate).fired_upon?
      @cells[coordinate].fire_upon
      return true
    else
      return false
    end
  end

  def get_cell_at(coordinate)
    @cells[coordinate]
  end

  def valid_placement?(ship, coords)
    ship.length == coords.length &&
      Coordinates.consecutive?(coords) &&
      Coordinates.not_diagonal?(coords) &&
      Coordinates.not_intersects?(coords, @cells.values) &&
      all_valid?(coords)
  end

  def place(ship, coords)
    coords.each do |coord|
      @cells[coord].place_ship(ship)
    end
  end

  def render(show_ship = false)
    render_string = "  "
    for x in (1..@size) do
      render_string.concat("#{x} ")
    end
    render_string.concat("\n")

    values = @cells.values
    rows = values.each_slice(@size)
    x = 1
    rows.each do |row|
      render_string.concat((x + 64).chr)
      render_string.concat(" ")
      row.each do |cell|
        render_string.concat(cell.render(show_ship))
        render_string.concat(" ")
      end
      render_string.concat("\n")
      x += 1
    end
    render_string
  end

  def valid_coordinate?(coord)
    @cells.keys.include?(coord)
  end

  def all_valid?(given_coords)
    actual_coords = @cells.keys
    given_coords.all? do |coord|
      actual_coords.include?(coord)
    end
  end

end

def place_computer_ships
  cruiser = Ship.new('', 5)
  ship2 = Ship.new('', 3)
  valid = true

  until valid do
    coord = get_a_random_coord
    orientation = rand(2) # => 1 or 0
    coords = coords = build_coords(coord, orientation)
    valid = board.place_ship(ship2, coords)
  end

end
