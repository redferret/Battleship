require 'rspec'
require './lib/human_player'
require './lib/computer_player'
require './lib/player'

describe HumanPlayer do
  context '#initialize' do
    it 'exists' do
      board = Board.new
      human_player = HumanPlayer.new(board)

      expect(human_player).to be_instance_of(HumanPlayer)
    end
  end

  context '#place_ships' do
    it 'place ships on board' do

      ship = Ship.build_ship(:destroyer)
      mock_board = double('board')
      human_player = HumanPlayer.new(mock_board)

      allow(mock_board).to receive(:valid_placement?).and_return(true)
      allow(mock_board).to receive(:render).with(true)
      allow(mock_board).to receive(:place).with(ship, ["A1", "A2", "A3"])

      allow(human_player).to receive(:puts).with anything
      allow(human_player).to receive(:get_user_input).and_return("A1 A2 A3")

      allow(human_player).to receive(:get_ships).and_return([ship])

      human_player.place_ships

      expect(human_player).to have_received(:get_user_input)
      expect(human_player).to have_received(:get_ships)

      expect(mock_board).to have_received(:valid_placement?)
      expect(mock_board).to have_received(:render)
      expect(mock_board).to have_received(:place)
    end
  end

  context '#human_shot' do
    it 'human takes shot' do
      mock1_board = double('Board')
      human_player = HumanPlayer.new(mock1_board)
      mock2_board = double('Board')
      mock_cell = double('Cell')
      allow(mock2_board).to receive(:fire_upon).and_return(true)
      allow(mock2_board).to receive(:get_cell_at).and_return(mock_cell)
      allow(human_player).to receive(:validate_player_input).and_return("A1")

      expect(human_player.human_shot(mock2_board)).to eq(mock_cell)
      expect(human_player).to have_received(:validate_player_input)
    end
  end

  context '#take_turn' do
    it 'turn is a miss' do
      mock1_board = double('Board')
      human_player = HumanPlayer.new(mock1_board)
      mock_cell = double('Cell')
      allow(human_player).to receive(:human_shot).and_return(mock_cell)
      allow(mock_cell).to receive(:empty?).and_return(true)
      allow(mock_cell).to receive(:coordinate).and_return("A1")
      allow(human_player).to receive(:puts).with("Your shot on A1 was a miss.")

      human_player.take_turn(mock1_board)
      expect(human_player).to have_received(:human_shot)
      expect(human_player).to have_received(:puts)
    end

    it 'turn is a hit' do
      mock1_board = double('Board')
      human_player = HumanPlayer.new(mock1_board)
      mock_cell = double('Cell')
      allow(human_player).to receive(:human_shot).and_return(mock_cell)
      allow(mock_cell).to receive(:empty?).and_return(false)
      allow(mock_cell).to receive(:coordinate).and_return("A1")
      allow(human_player).to receive(:puts).with("Your shot on A1 was a hit.")

      human_player.take_turn(mock1_board)
      expect(human_player).to have_received(:human_shot)
      expect(human_player).to have_received(:puts)
    end
  end

end
