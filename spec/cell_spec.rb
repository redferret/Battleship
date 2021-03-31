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

  end

  it '#fired_upon?' do
    # fires on cell
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
