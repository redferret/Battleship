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
end
