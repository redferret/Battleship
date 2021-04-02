require './lib/player.rb'
require 'rspec'

describe Player do
  context '#initialize' do
    it 'exists' do
      board = double('board')
      player = Player.new(board)
      expect(player).to be_instance_of Player
    end
  end
  context '#render_board' do
    it 'has a board' do
      test_string = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"

      board = double('board')
      allow(board).to receive(:render).and_return(test_string)

      player = Player.new(board)

      expect(player.render_board).to eq test_string
    end
  end
end
