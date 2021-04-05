require './lib/board'

class Player
  def initialize(board)
    @board = board
  end

  def place_ships
    raise NotImplementedError, "A player needs to be able to place ships"
  end

  def take_turn
    raise NotImplementedError, "A player needs to be able to take a turn"
  end

  def render_board
    @board.render
  end
end
