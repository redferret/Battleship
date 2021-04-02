class Coordinates
  def initialize(coords)
    @coords = coords.split(" ")
  end

  def are_diagonal?
    not are_vertical? and not are_horizontal?
  end

  def are_vertical?
    expected_length = @coords.length
    x_coords = @coords.map do |coord|
      coord[1..-1].to_i
    end
    x_coords.uniq.length == 1
  end

  def are_horizontal?
    expected_length = @coords.length
    y_coords = @coords.map do |coord|
      coord[0]
    end
    y_coords.uniq.length == 1
  end

  def intersects?(coords)
    coords_a = coords.to_a
    for index in (0..@coords.length) do
      coord = @coords[index]
      return true if coords_a.include?(coord)
    end
    false
  end

  def are_consecutive?
    if not are_diagonal?
      if are_horizontal?
        y_coords = @coords.map do |coord|
          coord[1..-1].to_i
        end
        return y_coords.each_cons(2).all? do |a, b|
          b == a + 1
        end
      else
        x_coords = @coords.map do |coord|
          coord[0].ord
        end
        return x_coords.each_cons(2).all? do |a, b|
          b == a + 1
        end
      end
    end
    return false
  end

  def to_a
    @coords
  end
end
