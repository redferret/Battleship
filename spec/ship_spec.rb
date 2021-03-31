require 'rspec'
require './lib/ship'

describe Ship do

  it 'exists' do
    test_ship = Ship.new('cruiser', 3)
    expect(test_ship).to be_instance_of Ship
  end
end
