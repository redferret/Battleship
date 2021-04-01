require 'rspec'
require './lib/cell'

describe Cell do
  it 'exists' do
    test_cell = Cell.new("A1")
    expect(test_cell).to be_instance_of(Cell)
  end

  it 'is the cell empty' do
    test_cell = Cell.new("A1")
    expect(test_cell.empty?).to eq(true)
  end

  it '#place_ship(ship)' do
    # put ships in cell
    test_cell = Cell.new("A1")
    test_cell.place_ship("cruiser")
    expect(test_cell.ship).to eq("cruiser")
  end

  it '#fired_upon?' do
    # fires on cell
    test_cell = Cell.new("A1")
    expect(test_cell.fired_upon?).to eq(false)
  end

  context '#fire_upon' do
    it 'marks this cell as fired upon' do
      test_cell = Cell.new("A1")

      expect(test_cell.fired_upon?).to eq(false)
      test_cell.fire_upon
      expect(test_cell.fired_upon?).to eq(true)
    end
    it 'hits a ship if there is a ship' do
      test_cell = Cell.new("A1")
      ship = Ship.new('cruiser', 2)

      test_cell.place_ship(ship)

      test_cell.fire_upon

      expect(test_cell.ship.health).to eq 1
    end
  end

  context '#render' do
    it 'has not been fired upon' do

    end

    it 'check if fired shot missed' do

    end

    it 'check if fired shot hit' do

    end

    it ' check if fired shot sunk ship' do

    end

  end

end
