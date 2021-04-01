class Coordinates
  def initialize(coords)
    @coords = coords.split(" ")
  end

  def are_diagonal?
    not are_vertical? and not are_horizontal?
  end

  def are_vertical?
  end

  def are_horizontal?
    false
  end

  def to_a
    @coords
  end
end
