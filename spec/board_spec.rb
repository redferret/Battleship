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
  end

  context '#place' do
    it 'place ship at given coordinates' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      coords = Coordinates.to_a("A1 A2 A3")
      board.place(cruiser, coords)
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      cell_4 = board.cells["A4"]

      expect(cell_1.ship).to eq(cell_2.ship)
      expect(cell_1.ship).to eq(cell_3.ship)
      expect(cell_2.ship).to eq(cell_3.ship)
      expect(cell_3.ship == cell_4.ship).to eq false
    end

    it 'check valid placement of ship to not pass' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      coords_1 = Coordinates.to_a("A1 A2 A3")
      board.place(cruiser, coords_1)
      submarine = Ship.new("Submarine", 3)
      coords_2 = Coordinates.to_a("A1 B1 C1")
      board.place(submarine, coords_2)

      expect(board.valid_placement?(submarine, coords_2)).to eq false
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

    it 'render with ships on the board' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      coords_1 = Coordinates.to_a("A1 A2 A3")
      board.place(cruiser, coords_1)

      expected = "  1 2 3 4 \n" +
                 "A S S S . \n" +
                 "B . . . . \n" +
                 "C . . . . \n" +
                 "D . . . . \n"

      expect(board.render(true)).to eq(expected)
    end
  end

  it 'check valid coordinate when player takes shot' do
    board = Board.new
    actual_1 = board.valid_coordinate?("Z1")
    expect(actual_1).to eq false

    actual_2 = board.valid_coordinate?("A1")
    expect(actual_2).to eq true
  end

  it 'checks all given coordinates exist on board' do
    board = Board.new
    coords_1 = Coordinates.to_a("Z1 Z2 Z3")

    expect(board.all_valid?(coords_1)).to eq false

    coords_2 = Coordinates.to_a("A1 A2 A3")

    expect(board.all_valid?(coords_2)).to eq true
  end

  context '#get_cell_at' do
    it 'returns a cell if it exists' do
      board = Board.new
      actual_cell = board.get_cell_at("A1")
      expect(actual_cell.coordinate).to eq "A1"
    end
  end

  context '#fire_upon' do
    it 'fires on a cell that is not fired on' do
      board = Board.new
      result = board.fire_upon("A1")
      expect(result).to eq true
    end
    it 'fires on a cell that is fired on' do
      board = Board.new
      board.fire_upon("A1")
      result = board.fire_upon("A1")
      expect(result).to eq false
    end
  end
end
