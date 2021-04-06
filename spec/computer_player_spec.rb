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
    end

    context '#get_random_coordinate' do
      it 'returns a valid random coordinate' do
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

    context '#make_coordinates_for_ship' do
      it 'produces a collection of coordinates if horizontal' do
        board = double('board')
        computer_player = ComputerPlayer.new(board)

        test_ship = double('ship')
        allow(test_ship).to receive(:length).and_return(3)
        test_coordinate = "A1"

        actual_coordinates = computer_player.make_coordinates_for_ship(test_ship, test_coordinate, :horizontal)
        expected_coordinates = ["A1", "A2", "A3"]

        expect(actual_coordinates).to eq expected_coordinates
      end

      it 'produces a collection of coordinates if vertical' do
        board = double('board')
        computer_player = ComputerPlayer.new(board)

        test_ship = double('ship')
        allow(test_ship).to receive(:length).and_return(3)
        test_coordinate = "A1"

        actual_coordinates = computer_player.make_coordinates_for_ship(test_ship, test_coordinate, :vertical)
        expected_coordinates = ["A1", "B1", "C1"]

        expect(actual_coordinates).to eq expected_coordinates
      end
    end

    context '#pick_orientation' do
      it 'picks a random orientation' do
        board = double('board')
        computer_player = ComputerPlayer.new(board)
        actual_orientation = computer_player.pick_orientation
        possible_orientations = [:horizontal, :vertical]

        test_orientation = possible_orientations.include?(actual_orientation)

        expect(test_orientation).to eq true
      end
    end

    context '#picking guesses' do
      before :each do
        @coordinate = "B2"
        @y_coord_part = @coordinate[0].ord - 64
        @x_coord_part = @coordinate[1..-1].to_i
        @other_player_board = double('other player board')
        allow(@other_player_board).to receive(:valid_coordinate?).and_return(true)
        board = double('computer board')
        @computer_player = ComputerPlayer.new(board)
      end
      it 'picks a north option' do
        expected_coordinate = "A2"
        actual_coord = @computer_player.pick_north_guess(@y_coord_part, @x_coord_part, @other_player_board)
        expect(actual_coord).to eq expected_coordinate
      end
      it 'picks a east option' do
        expected_coordinate = "B3"
        actual_coord = @computer_player.pick_east_guess(@y_coord_part, @x_coord_part, @other_player_board)
        expect(actual_coord).to eq expected_coordinate
      end
      it 'picks a south option' do
        expected_coordinate = "C2"
        actual_coord = @computer_player.pick_south_guess(@y_coord_part, @x_coord_part, @other_player_board)
        expect(actual_coord).to eq expected_coordinate
      end
      it 'picks a west option' do
        expected_coordinate = "B1"
        actual_coord = @computer_player.pick_west_guess(@y_coord_part, @x_coord_part, @other_player_board)
        expect(actual_coord).to eq expected_coordinate
      end

      it 'selects four guesses' do
        expected_guesses = ["A2", "B3", "C2", "B1"]
        actual_guesses = @computer_player.set_four_guesses(@other_player_board, @coordinate)
        expect(actual_guesses).to eq expected_guesses
      end
    end

end
