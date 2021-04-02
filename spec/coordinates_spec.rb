require 'rspec'
require './lib/coordinates.rb'

describe Coordinates do
  context '#diagonal?' do
    it 'tests if the coordinates are diagonal' do
      coords = Coordinates::to_a("A1 B2 C3")
      expect(Coordinates::diagonal?(coords)).to eq true
    end
  end

  context '#not_diagonal' do
    it 'tests if the coordinates are not diagonal' do
      coords = Coordinates::to_a("A1 B1 C1")
      expect(Coordinates::diagonal?(coords)).to eq false

      coords = Coordinates::to_a("A1 A2 A3")
      expect(Coordinates::diagonal?(coords)).to eq false
    end
  end

  context '#vertical?' do
    it 'tests if the coordinates are vertical' do
      coords = Coordinates::to_a("A1 B1 C1")
      expect(Coordinates::vertical?(coords)).to eq true
    end
  end

  context '#not_vertical' do
    it 'tests if the coordinates are not vertical' do
      coords = Coordinates::to_a("A1 A2 A3")
      expect(Coordinates::vertical?(coords)).to eq false
    end
  end

  context '#horizontal' do
    it 'tests if the coordinates are horizontal' do
      coords = Coordinates::to_a("A1 A2 A3")
      expect(Coordinates::horizontal?(coords)).to eq true
    end
  end

  context '#not_horizontal' do
    it 'tests if the coordinates are not horizontal' do
      coords = Coordinates::to_a("A1 B1 C1")
      expect(Coordinates::horizontal?(coords)).to eq false
    end
  end

  context '#intersects?' do
    it 'tests if coordinates are intersecting' do
      coords_1 = Coordinates::to_a("A1 A2 A3")
      coords_2 = Coordinates::to_a("A2 B2 C2")

      intersection = Coordinates::intersects?(coords_1, coords_2)

      expect(intersection).to eq true
    end

    it 'tests if coordinates are not intersecting' do
      coords_1 = Coordinates::to_a("A1 A2 A3")
      coords_2 = Coordinates::to_a("B2 C2 D2")

      intersection = Coordinates::intersects?(coords_1, coords_2)

      expect(intersection).to eq false
    end
  end

  context '#consecutive' do
    it 'tests that the coordinates are consecutive' do
      coords = Coordinates::to_a("A1 A2 A3")
      expect(Coordinates::consecutive?(coords)).to eq true
    end

    it 'tests that the coordinates are not consecutive' do
      coords = Coordinates::to_a("A1 A3")
      expect(Coordinates::consecutive?(coords)).to eq false
    end
  end
end
