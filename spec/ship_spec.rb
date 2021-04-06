require 'rspec'
require './lib/ship'

describe Ship do
  context '#initialize' do
    before :each do
      @test_ship = Ship.new('cruiser', 3)
    end

    it 'exists' do
      expect(@test_ship).to be_instance_of Ship
    end

    it 'tests that health equals the length when created' do
      expect(@test_ship.health).to eq 3
    end

    it 'has a length' do
      expect(@test_ship.length).to eq 3
    end

    it 'is named' do
      expect(@test_ship.name).to eq 'cruiser'
    end

  end

  context '#hit' do
    before :each do
      @test_ship = Ship.new('cruiser', 2)
    end

    it 'reduces the health of the ship by 1' do
      expect(@test_ship.health).to eq 2

      @test_ship.hit

      expect(@test_ship.health).to eq 1
    end

    it 'won\'t let health go below 0' do
      @test_ship.hit
      @test_ship.hit
      expect(@test_ship.health).to eq 0

      @test_ship.hit
      expect(@test_ship.health).to eq 0
    end
  end

  context '#sunk?' do
    it 'tests if ship is sunk or not' do
      test_ship = Ship.new('cruiser', 2)

      test_ship.hit
      expect(test_ship.sunk?).to eq false
      test_ship.hit
      expect(test_ship.sunk?).to eq true
    end
  end

  context '#build_ship' do

    it 'raises error with invalid id' do
      ships = Ship.get_ships
      expect {
        Ship.build_ship(100)
      }.to raise_error(ArgumentError, "Unknown ship id: 100")
    end

    it 'returns a ship based on ids' do
      ships = Ship.get_ships

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
        ship = Ship.build_ship(id)
        expected_length = expected_lengths[id]
        expected_name = expected_names[id]

        expect(ship).to be_instance_of Ship
        expect(ship.length).to eq expected_length
        expect(ship.name).to eq expected_name
      end
    end
  end
end
