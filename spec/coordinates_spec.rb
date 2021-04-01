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

  context '#are_diagonal?' do
    it 'tests if the coordinates are diagonal' do
      coords = Coordinates.new("A1 A2 A3")
      expect(coords.are_diagonal?).to eq true
    end

    it 'tests if the coordinates are not diagonal' do
      coords = Coordinates.new("A1 B1 C1")
      expect(coords.are_diagonal?).to eq false
    end
  end

  context '#vertical?' do
    it 'tests if the coordinates are vertical' do
      coords = Coordinates.new("A1 B1 C1")
      expect(coords.are_vertical?).to eq true
    end

    it 'tests if the coordinates are not vertical' do
      coords = Coordinates.new("A1 A2 A3")
      expect(coords.are_vertical?).to eq false
    end
  end
  context '#horizontal' do
    it 'tests if the coordinates are horizontal' do
      coords = Coordinates.new("A1 A1 A1")
      expect(coords.are_horizontal?).to eq true
    end

    it 'tests if the coordinates are not horizontal' do
      coords = Coordinates.new("A1 B1 C1")
      expect(coords.are_horizontal?).to eq false
    end
  end

  context '#intersects?' do
    it 'tests if coordinates are intersecting' do
      coords_1 = Coordinates.new("A1 A2 A3")
      coords_2 = Coordinates.new("A2 B2 C2")

      intersection = coords_1.intersects?(coords_2)

      expect(intersection).to eq true
    end

    it 'tests if coordinates are not intersecting' do
      coords_1 = Coordinates.new("A1 A2 A3")
      coords_2 = Coordinates.new("B2 C2 D2")

      intersection = coords_1.intersects?(coords_2)

      expect(intersection).to eq false
    end
  end
end
