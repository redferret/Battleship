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
  end

  context '#get_ship' do
    it 'returns a ship based on ids' do
      ships = Ships.new

      expected_names = [
        'Carrier',
        'Battleship',
        'Destroyer',
        'Submarine',
        'Patrol Boat'
      ]

      expected_lengths = [5, 4, 3, 3, 2]

      for id in (0..4) do
        ship = ships.get_ship(id)
        expected_length = expected_lengths[id]
        expected_name = expected_names[id]

        expect(ship).to be_instance_of Ship
        expect(ship.length).to eq expected_length
        expect(ship.name).to eq expected_name
      end
    end
  end

end
