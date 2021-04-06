require './lib/board'
require './lib/ship'

class Player
  def initialize(board)
    @board = board
    @player_ships = Ship.get_ships
  end

  def get_ships
    @player_ships.values
  end

  def all_sunk?
    get_ships.all? do |ship|
      ship.sunk?
    end
  end

  def place_ships
    raise NotImplementedError, "A player needs to be able to place ships"
  end

  def take_turn(other_player_board)
    raise NotImplementedError, "A player needs to be able to take a turn"
  end

  def render_board(show_ship = false)
    @board.render(show_ship)
  end
end
