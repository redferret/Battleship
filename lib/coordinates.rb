class Coordinates
  def initialize(coords)
    @coords = coords.split(" ")
  end

  def are_diagonal?
  end

  def to_a
    @coords
  end
end
