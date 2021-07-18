require 'rspec'
require './lib/ship_yard'

RSpec.describe ShipYard do
  context '#build_ship' do

    it 'raises error with invalid id' do
      expect {
        ShipYard.build_ship(100)
      }.to raise_error(ArgumentError, "Unknown ship id: 100")
    end

    it 'returns a ship based on ids' do
      ships = ShipYard.get_ships

      expected_names = {
        carrier: 'Carrier',
        battleship: 'Battleship',
        destroyer: 'Destroyer',
        submarine: 'Submarine',
        patrolboat: 'Patrol Boat'
      }

      expected_lengths = {
        carrier: 5,
        battleship: 4,
        destroyer: 3,
        submarine: 3,
        patrolboat: 2
      }

      ship_ids = [
        :carrier,
        :battleship,
        :destroyer,
        :submarine,
        :patrolboat
      ]

      ship_ids.each do |id|
        ship = ShipYard.build_ship(id)
        expected_length = expected_lengths[id]
        expected_name = expected_names[id]

        expect(ship).to be_instance_of Ship
        expect(ship.length).to eq expected_length
        expect(ship.name).to eq expected_name
      end
    end
  end
end