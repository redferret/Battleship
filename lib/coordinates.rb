require './lib/cell'

class Coordinates
  def self.diagonal?(coordinates)
    not_vertical?(coordinates) and not_horizontal?(coordinates)
  end

  def self.vertical?(coordinates)
    y_coords = coordinates.map do |coord|
      coord[1..-1].to_i
    end
    y_coords.uniq.length == 1
  end

  def self.not_vertical?(coordinates)
    not vertical?(coordinates)
  end

  def self.horizontal?(coordinates)
    x_coords = coordinates.map do |coord|
      coord[0]
    end
    x_coords.uniq.length == 1
  end

  def self.not_horizontal?(coordinates)
    not horizontal?(coordinates)
  end

  def self.intersects?(coords1, coords2)
    for index in (0..coords1.length) do
      coord = coords1[index]
      return true if coords2.include?(coord)
    end
    return false
  end

  def self.not_diagonal?(coordinates)
    not diagonal?(coordinates)
  end

  def self.consecutive?(coordinates)
    if not_diagonal?(coordinates)
      if horizontal?(coordinates)
        y_coords = coordinates.map do |coord|
          coord[1..-1].to_i
        end
        return y_coords.each_cons(2).all? do |a, b|
          b == a + 1
        end
      else
        x_coords = coordinates.map do |coord|
          coord[0].ord
        end
        return x_coords.each_cons(2).all? do |a, b|
          b == a + 1
        end
      end
    end
    return false
  end

  def self.to_a(coordinates)
    coordinates.split(" ")
  end
end
