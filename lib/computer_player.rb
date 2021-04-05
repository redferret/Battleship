require './lib/player'
require './lib/ships'

class ComputerPlayer < Player
  attr_reader :board

  def initialize(board)
    super
    @computer_ships = Ships.new
  end

  def get_random_coordinate
    y_range = rand(1..@board.size) + 64
    x_range = rand(1..@board.size)

    "#{y_range.chr}#{x_range}"
  end

  def get_ship(ship_id)
    @computer_ships.ships[ship_id]
  end