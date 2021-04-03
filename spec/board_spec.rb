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
      coords_long = Coordinates.to_a("C1 C2 C3 C4")

      expect(board.valid_placement?(carrier, coords_long)).to eq false

      cruiser = Ship.new("Cruiser", 3)
      coords = Coordinates.to_a("A1 A2 A3")

      expect(board.valid_placement?(cruiser, coords)).to eq true
    end

    it 'checks coordinates of ship are consecutive' do
      board = Board.new
      cruiser = Ship.new("Cruiser 1", 3)
      coords_1 = Coordinates.to_a("A1 A2 A3")

      expect(board.valid_placement?(cruiser, coords_1)).to eq true

      submarine = Ship.new("Submarine", 3)
      coords_2 = Coordinates.to_a("B1 C1 D1")

      expect(board.valid_placement?(submarine, coords_2)).to eq true

      destroyer = Ship.new("Destoyer", 2)
      coords_3 = Coordinates.to_a("A1 C1")

      expect(board.valid_placement?(submarine, coords_3)).to eq false

      cruiser = Ship.new("Cruiser 2", 2)
      coords_4 = Coordinates.to_a("A1 A2 A4")

      expect(board.valid_placement?(submarine, coords_4)).to eq false
    end

    it 'make sure ship coordinates are not diagonal' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      coords_1 = Coordinates.to_a("A1 B2 C3")

      expect(board.valid_placement?(cruiser, coords_1)).to eq false

      submarine = Ship.new("Submarine", 3)
      coords_2 = Coordinates.to_a("A1 B1 C1")

      expect(board.valid_placement?(cruiser, coords_2)).to eq true

    end

  context '#place' do
    it 'place ship at given coordinates' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      coords = Coordinates.to_a("A1 A2 A3")
      board.place(cruiser, coordinates)
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]

      expect(cell_1.ship).to eq(cell_2.ship)
      expect(cell_1.ship).to eq(cell_3.ship)
      expect(cell_2.ship).to eq(cell_3.ship)
      expect(cell_1.ship).not_to eq(cell_4.ship)
      expect(valid_placement?(cruiser, coords)).to eq true
    end

    it 'check overlap of ships placement' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])

      expect(board.overlap?(["A1", "B1", "C1"])).to eq true
    end

    it 'check valid placement of ship to pass false' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])

      submarine = Ship.new("Submarine", 3)

      expect(board.valid_placement?(submarine, ["A1", "B1", "C1"])).to eq false
    end

    it 'check valid placement of ship to pass true' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])

      submarine = Ship.new("Submarine", 3)

      expect(board.valid_placement?(submarine, ["B1", "C1", "D1"])).to eq true
    end
  end

  context '#render' do
    it 'render default board' do
      board = Board.new
      board.render
      expected = "  1 2 3 4 \n" +
                 "A . . . . \n" +
                 "B . . . . \n" +
                 "C . . . . \n" +
                 "D . . . . \n"

      expect(board.render).to eq(expected)
    end

    it 'render human players board' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      coords_1 = Coordinates.to_a("A1 A2 A3")
      board.place(cruiser, coords_1)
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      board.render(true)

      expected = "  1 2 3 4 \n
                  A S S S . \n
                  B . . . . \n
                  C . . . . \n
                  D . . . . \n"

      expect(board.render(true)).to eq(expected)
    end
  end

end
