require './lib/computer_player'
require './lib/ships'
require 'rspec'

describe ComputerPlayer do

    context '#initialize' do
      it 'exists' do
        board = double()
        computer_player = ComputerPlayer.new(board)

        expect(computer_player).to be_instance_of ComputerPlayer
      end

      it 'gives board to the parent class' do
        board = double('board')
        computer_player = ComputerPlayer.new(board)
        expect(computer_player.board).to eq board
      end
    end

    context '#get_random_coordinate' do
      it 'returns a valid random coordinate' do
        test_board_cells = {
          "A1": double('cell1'),
          "A2": double('cell2'),
          "B1": double('cell3'),
          "B2": double('cell4')
        }
        possible_coordinates = ["A1", "A2", "B1", "B2"]
        board = double('board')
        allow(board).to receive(:size).and_return(2)

        computer_player = ComputerPlayer.new(board)
        random_coordinate = computer_player.get_random_coordinate

        is_correct_coordinate = possible_coordinates.include?(random_coordinate)

        expect(is_correct_coordinate).to eq true
      end
    end

    context '#get_ship' do
      it 'grabs a ship with the given id' do
        test_board = double('board')
        computer_player = ComputerPlayer.new(test_board)

        actual_ship = computer_player.get_ship(:battleship)
        expect(actual_ship.name).to eq 'Battleship'
      end
    end
end
