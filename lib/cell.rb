class Cell
  attr_accessor :coordinate,
                :ship
                :is_empty

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @is_empty = true
  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
  end

end
