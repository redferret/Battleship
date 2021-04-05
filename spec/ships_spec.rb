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


end
