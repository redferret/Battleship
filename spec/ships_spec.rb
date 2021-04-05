require './lib/ships'
require 'rspec'

describe Ships do
  context '#initialize' do
    it 'exists' do
      ships = Ships.new
      expect(ships).to be_instance_of Ships
    end

    it 'has ships list' do
      playable_ships = Ships.new
      expect(playable_ships.ships).not_to eq nil
    end

    it 'populates ships list' do
      playable_ships = Ships.new
      expect(playable_ships.ships.length).to eq 5
    end
  end

  context '#build_ship' do

    it 'raises error with invalid id' do
      ships = Ships.new
      expect {
        ships.build_ship(100)
      }.to raise_error(ArgumentError, "Unknown ship id: 100")
    end

    it 'returns a ship based on ids' do
      ships = Ships.new

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
        ship = ships.build_ship(id)
        expected_length = expected_lengths[id]
        expected_name = expected_names[id]

        expect(ship).to be_instance_of Ship
        expect(ship.length).to eq expected_length
        expect(ship.name).to eq expected_name
      end
    end
  end

end
