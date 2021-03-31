require 'rspec'
require './lib/ship'

describe Ship do

  it 'exists' do
    test_ship = Ship.new('cruiser', 3)
    expect(test_ship).to be_instance_of Ship
  end

  describe '#hit' do
    it 'reduces the health of the ship by 1' do
      test_ship = Ship.new('cruiser', 3)

      expect(test_ship.health).to eq 3

      test_ship.hit

      expect(test_ship.health).to eq 2
    end
  end
end
