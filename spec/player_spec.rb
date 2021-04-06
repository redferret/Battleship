require './lib/player'
require './lib/ship'
require 'rspec'

describe Player do
  context '#initialize' do
    it 'exists' do
      board = double('board')
      player = Player.new(board)
      expect(player).to be_instance_of Player
    end
  end

  context '#all_sunk?' do
    it 'returns true if all ships are sunk' do
      mock_board = double('Board')
      mock_ship1 = double('Ship')
      mock_ship2 = double('Ship')

      allow(mock_ship1).to receive(:sunk?).and_return(true)
      allow(mock_ship2).to receive(:sunk?).and_return(true)

      test_ships = {s1:mock_ship1, s2:mock_ship2}
      player = Player.new(mock_board)

      allow(player).to receive(:get_ships).and_return(test_ships.values)

      expect(player.all_sunk?).to be true
    end
    it 'returns false if all ships are not sunk' do
      mock_board = double('Board')
      mock_ship1 = double('Ship')
      mock_ship2 = double('Ship')

      allow(mock_ship1).to receive(:sunk?).and_return(true)
      allow(mock_ship2).to receive(:sunk?).and_return(false)

      test_ships = {s1:mock_ship1, s2:mock_ship2}
      player = Player.new(mock_board)

      allow(player).to receive(:get_ships).and_return(test_ships.values)

      expect(player.all_sunk?).to be false
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
