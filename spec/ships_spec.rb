require './lib/ships'
require 'rspec'

describe Ships do
  context '#initialize' do
    it 'exists' do
      ships = Ships.new
      expects(ships).to be_instance_of Ships
    end
  end
end
