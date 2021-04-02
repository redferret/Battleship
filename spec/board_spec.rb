require 'rspec'
require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/coordinates'

describe Board do
  context '#initialize' do

    it 'exists' do
      board = Board.new
      expect(board).to be_instance_of(Board)
    end
end