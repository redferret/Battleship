class Cell
  attr_accessor :coordinate,
                :ship
                :is_empty

  def initialize(coordinate)
    @coordinate = coordinate
  def place_ship(ship)
    @ship = ship
  end
  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
  end

end
