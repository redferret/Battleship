require './lib/ship'
require './lib/cell'
require './lib/coordinates'
class Board
  attr_reader :cells

  def initialize(size = 4)
    @cells = {}

    for row in (1..size) do
      x_coord = (row + 64).chr

      for column in (1..size) do
        coordinate = "#{x_coord}#{column}"
        @cells[coordinate] = Cell.new(coordinate)
      end
    end

  end

  def valid_placement?(ship, coords)
    ship.length == coords.length &&
      consecutive?(coords)
  end

  def consecutive?(coords)

    y_coords = coords.map do |coord|
      coord[0].ord
    end
    check_y_hor = y_coords.each_cons(2).all? do |a, b|
      b == a
    end

    check_y_ver = y_coords.each_cons(2).all? do |a, b|
      b == a + 1
    end

    x_coords = coords.map do |coord|
      coord[-1].to_i
    end
    check_x_hor = x_coords.each_cons(2).all? do |a, b|
      b == a + 1
    end
    check_x_ver = x_coords.each_cons(2).all? do |a, b|
      b == a
    end
    (check_y_hor && check_x_hor) || (check_y_ver && check_x_ver)

  end

end
