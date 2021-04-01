class Coordinates
  def initialize(coords)
    @coords = coords.split(" ")
  end

  def to_a
    @coords
  end
end
