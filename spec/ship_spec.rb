require 'rspec'
require './lib/ship'

describe Ship do
  describe '#initialize' do
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

  describe '#hit' do
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

  describe '#sunk?' do
    it 'tests if ship is sunk or not' do
      test_ship = Ship.new('cruiser', 2)

      test_ship.hit
      expect(test_ship.sunk?).to eq false
      test_ship.hit
      expect(test_ship.sunk?).to eq true
    end
  end
end
