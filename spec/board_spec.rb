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

    it 'check board cells' do
      board = Board.new

      expected_cells = ["A1", "A2", "A3", "A4",
                        "B1", "B2", "B3", "B4",
                        "C1", "C2", "C3", "C4",
                        "D1", "D2", "D3", "D4",]

      expect(board.cells.keys).to eq(expected_cells)
    end

  end