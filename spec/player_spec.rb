require './lib/player'
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
    it 'has a board and calls render on it' do
      test_string = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"

      board = double('board')
      allow(board).to receive(:render).and_return(test_string)

      player = Player.new(board)

      expect(player.render_board).to eq test_string
    end
  end

  context '#place_ships' do
    it 'raises NotImplementedError if the method is not implemented' do
      board = double('board')
      player = Player.new(board)
      expect{
        player.place_ships
      }.to raise_error(NotImplementedError)
    end
  end

  context '#take_turn' do
    it 'raises NotImplementedError if the method is not implemented' do
      board = double('board')
      player = Player.new(board)
      expect{
        player.take_turn(nil)
      }.to raise_error(NotImplementedError)
    end
  end
end
