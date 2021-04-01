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

    if empty? or (not empty? and not show_ship)
      return '.'
    end

    if not empty? and show_ship
      return 'S'
    end
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
  end

end
