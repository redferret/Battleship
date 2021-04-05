require './lib/ship'

class Ships
  attr_reader :ships

  CARRIER = 0
  BATTLESHIP = 1
  DESTROYER = 2
  SUBMARINE = 3
  PATROLBOAT = 4

  def initialize
    @ships = []

  end

  def get_ship(ship_id)
    case ship_id
    when CARRIER
      return new Ship('Carrier', 5)
    when BATTLESHIP
      return new Ship('Battleship', 4)
    when DESTROYER
      return new Ship('Destroyer', 3)
    when SUBMARINE
      return new Ship('Submarine', 3)
    when PATROLBOAT
      return new Ship('Patrol Boat', 2)
    else
      raise "Unknown ship id: " + ship_id
    end
  end
end
