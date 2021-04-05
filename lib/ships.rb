require './lib/ship'

class Ships
  attr_reader :ships

  CARRIER = :carrier
  BATTLESHIP = :battleship
  DESTROYER = :destroyer
  SUBMARINE = :submarine
  PATROLBOAT = :patrolboat

  def initialize
    @ships = []
    for id in (0..4) do
      @ships << build_ship(id)
    end
  end

  def build_ship(ship_id)
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
      raise ArgumentError, "Unknown ship id: #{ship_id}"
    end
  end
end
