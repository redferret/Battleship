require 'rspec'
require './lib/coordinates.rb'

describe Coordinates do
  context '#initialize' do
    it 'exists' do
      coords = Coordinates.new("A1 A2 A3")
      expect(coords).to be_instance_of Coordinates
    end

    it 'has coordinates' do
      coords = Coordinates.new("A1 A2 A3")

      expected_coords = ["A1", "A2", "A3"]
      expect(coords.to_a).to eq expected_coords
    end
  end
end
