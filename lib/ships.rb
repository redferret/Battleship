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
      return Ship.new('Carrier', 5)
    when BATTLESHIP
      return Ship.new('Battleship', 4)
    when DESTROYER
      return Ship.new('Destroyer', 3)
    when SUBMARINE
      return Ship.new('Submarine', 3)
    when PATROLBOAT
      return Ship.new('Patrol Boat', 2)
    else
      raise "Unknown ship id: " + ship_id
    end
  end
end
