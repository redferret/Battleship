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

  
  end

  def to_a
    @coords
  end
end
