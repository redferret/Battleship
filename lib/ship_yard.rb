require_relative 'ship'

class ShipYard
  CARRIER = :carrier
  BATTLESHIP = :battleship
  DESTROYER = :destroyer
  SUBMARINE = :submarine
  PATROLBOAT = :patrolboat

  def self.get_ships
    @ships = {}
    ship_keys = [
      CARRIER,
      BATTLESHIP,
      DESTROYER,
      SUBMARINE,
      PATROLBOAT
    ]
    ship_keys.each do |key|
      @ships[key] = build_ship(key)
    end
    return @ships
  end

  def self.build_ship(ship_id)
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