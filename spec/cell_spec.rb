require 'rspec'
require './lib/cell'

describe Cell do
  it 'exists' do
    test_cell = Cell.new("A1")
    expect(test_cell).to be_instance_of(Cell)
  end

end
