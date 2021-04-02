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

  context '#valid_placement?' do
    it 'check length of ship with same number of coordinates' do
      board = Board.new
      carrier = Ship.new("Carrier", 5)
      coords_long = Coordinates.new("C1 C2 C3 C4").to_a

      expect(board.valid_placement?(carrier, coords_long)).to eq false

      cruiser = Ship.new("Cruiser", 3)
      coords = Coordinates.new("A1 A2 A3").to_a

      expect(board.valid_placement?(cruiser, coords)).to eq true
    end

    it 'checks coordinates of ship are consecutive' do
      board = Board.new
      cruiser = Ship.new("Cruiser 1", 3)
      coords_1 = Coordinates.new("A1 A2 A3").to_a

      expect(board.valid_placement?(cruiser, coords_1)).to eq true

      submarine = Ship.new("Submarine", 3)
      coords_2 = Coordinates.new("B1 C1 D1").to_a

      expect(board.valid_placement?(submarine, coords_2)).to eq true

      destroyer = Ship.new("Destoyer", 2)
      coords_3 = Coordinates.new("A1 C1").to_a

      expect(board.valid_placement?(submarine, coords_3)).to eq false

      cruiser = Ship.new("Cruiser 2", 2)
      coords_4 = Coordinates.new("A1 A2 A4").to_a

      expect(board.valid_placement?(submarine, coords_4)).to eq false
    end

    it 'make sure ship coordinates are not diagonal' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      coords_1 = Coordinates.new("A1 B2 C3").to_a

      expect(board.valid_placement?(cruiser, coords_1)).to eq false

      submarine = Ship.new("Submarine", 3)
      coords_2 = Coordinates.new("A1 B1 C1").to_a

      expect(board.valid_placement?(cruiser, coords_2)).to eq true

    end
  context '#place' do
    it 'place ship at given coordinates' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      coordinates = Coordinates.new("A1 A2 A3")
      board.place(cruiser, coordinates)
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]

      expect(cell_1.ship).to eq(cell_2.ship)
      expect(cell_1.ship).to eq(cell_3.ship)
      expect(cell_2.ship).to eq(cell_3.ship)
      expect(cell_1.ship).not_to eq(cell_4.ship)
      expect(valid_placement?(cruiser, coordinates)).to eq true
    end

    it 'check overlap of ship placement' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      coordinates_1 = Coordinates.new("A1 A2 A3")
      board.place(cruiser, coordinates_1)
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]

      submarine = Ship.new("Submarine", 3)
      coordinates_2 = Coordinates.new("A1 B1 C1")
      board.place(submarine, coorinates_2)
      cell_4 = board.cells["A1"]
      cell_5 = board.cells["B1"]
      cell_6 = board.cells["C1"]

      expect(valid_placement?(submarine, coorinates_2)).to eq false
    end
  end