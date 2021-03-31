require 'rspec'
require './lib/ship'

describe Ship do

  describe '#initialize' do
    it 'exists' do
      test_ship = Ship.new('cruiser', 3)
      expect(test_ship).to be_instance_of Ship
    end

    it 'tests that health equals the length when created' do
      test_ship = Ship.new('cruiser', 3)
      expect(test_ship.health).to eq 3
    end

    it 'has a length' do
      test_ship = Ship.new('cruiser', 3)
      expect(test_ship.length).to eq 3
    end

    it 'is named' do
      test_ship = Ship.new('cruiser', 3)
      expect(test_ship.name).to eq 'cruiser'
    end

  end

  describe '#hit' do
    it 'reduces the health of the ship by 1' do
      test_ship = Ship.new('cruiser', 3)

      expect(test_ship.health).to eq 3

      test_ship.hit

      expect(test_ship.health).to eq 2
    end

    it 'won\'t let health go below 0' do
      test_ship = Ship.new('cruiser', 2)

      test_ship.hit
      test_ship.hit
      expect(test_ship.health).to eq 0

      test_ship.hit
      expect(test_ship.health).to eq 0
    end
  end

  describe '#sunk?' do
    it 'returns true if ship is sunk' do
      test_ship = Ship.new('cruiser', 2)

      test_ship.hit
      test_ship.hit
      expect(test_ship.sunk?).to eq true
    end

    it 'returns false if ship has not sunk' do
      test_ship = Ship.new('cruiser', 2)

      test_ship.hit
      expect(test_ship.sunk?).to eq false
    end
  end
end
