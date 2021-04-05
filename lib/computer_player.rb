require './lib/player'

class ComputerPlayer < Player
  attr_reader :board
  def get_random_coordinate
    y_range = rand(1..@board.size) + 64
    x_range = rand(1..@board.size)

    "#{y_range.chr}#{x_range}"
  end
