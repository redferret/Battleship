class Cell
  attr_accessor :coordinate,
                :ship
                :is_empty

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @is_empty = true
  end

  def empty?
    @is_empty
  end

end
