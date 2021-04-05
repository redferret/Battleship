require './lib/ship'

class Cell
  attr_reader   :ship,
                :coordinate

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def render(show_ship = false)
    if fired_upon?
      if empty?
        return 'M'
      else
        return (ship.sunk?)? 'X' : 'H'
      end
    end

  def empty_cell?(show_ship)
    empty? || ((not empty?) && (not show_ship))
  end

  def cell_has_ship?(show_ship)
    not empty? && show_ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if not empty?
      @ship.hit
    end
  end

end
