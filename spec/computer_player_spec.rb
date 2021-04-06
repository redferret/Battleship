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

    context '#the_choice_is_a_hit?' do
      it 'was a hit' do
        mock_board = double('Board')
        computer_player = ComputerPlayer.new(mock_board)
        mock_cell = double('Cell')
        allow(mock_cell).to receive(:empty?).and_return(false)
        allow(mock_cell).to receive(:coordinate).and_return("A1")
        actual_value = computer_player.the_choice_is_a_hit?(mock_cell)

        expect(actual_value).to eq true
      end
      it 'was not a hit' do
        mock_board = double('Board')
        computer_player = ComputerPlayer.new(mock_board)
        mock_cell = double('Cell')
        allow(mock_cell).to receive(:empty?).and_return(true)
        allow(mock_cell).to receive(:coordinate).and_return("A1")
        actual_value = computer_player.the_choice_is_a_hit?(mock_cell)

        expect(actual_value).to eq false
      end
    end

    context '#cell_was_not_fired_on' do
      it 'was not fired on yet' do
        mock_board = double('Board')
        mock_other_player_board = double('Board')
        mock_cell = instance_double('Cell', coordinate: "A1")
        allow(mock_cell).to receive(:fired_upon?).and_return(false)
        allow(mock_cell).to receive(:fire_upon)
        allow(mock_cell).to receive(:empty?).and_return(false)

        computer_player = ComputerPlayer.new(mock_board)

        return_value = computer_player.cell_was_not_fired_on?(mock_cell, mock_other_player_board)

        expect(return_value).to eq true
      end
      it 'was fired on' do
        mock_board = double('Board')
        mock_other_player_board = double('Board')
        mock_cell = instance_double('Cell', coordinate: "A1")
        allow(mock_cell).to receive(:fired_upon?).and_return(true)
        allow(mock_cell).to receive(:fire_upon)
        allow(mock_cell).to receive(:empty?).and_return(false)

        computer_player = ComputerPlayer.new(mock_board)

        return_value = computer_player.cell_was_not_fired_on?(mock_cell, mock_other_player_board)

        expect(return_value).to eq false
      end
    end

    context '#attempt_to_fire_on' do
      it 'hits a cell successfully' do
        computer_player = ComputerPlayer.new(double('board'))
        allow(computer_player).to receive(:cell_was_not_fired_on?).and_return(true)

        mock_other_player_board = double('Board')

        mock_cell = double('Cell#A1')
        allow(mock_other_player_board).to receive(:get_cell_at).and_return(mock_cell)

        attempt_result = computer_player.attempt_to_fire_on(mock_other_player_board, "A1") do |cell|
          expect(cell).to eq mock_cell
        end
        expect(attempt_result).to eq true
      end
      it 'not able to hit the cell' do
        computer_player = ComputerPlayer.new(double('board'))
        allow(computer_player).to receive(:cell_was_not_fired_on?).and_return(false)

        mock_other_player_board = double('Board')

        mock_cell = double('Cell#A1')
        allow(mock_other_player_board).to receive(:get_cell_at).and_return(mock_cell)

        attempt_result = computer_player.attempt_to_fire_on(mock_other_player_board, "A1")
        expect(attempt_result).to eq false
      end
    end

    context '#take_turn' do
      it 'takes a turn with no previous_hit_made' do
        computer_player = ComputerPlayer.new(double('board'))
        allow(computer_player).to receive(:no_previous_hit_made?).and_return(true)
        allow(computer_player).to receive(:make_a_random_selection)
        allow(computer_player).to receive(:make_a_guess_around_cell)
        mock_other_player_board = double('Board')

        computer_player.take_turn(mock_other_player_board)
        expect(computer_player).to have_received(:make_a_random_selection)
        expect(computer_player).not_to have_received(:make_a_guess_around_cell)
      end
      it 'takes a turn with a previous_hit_made' do
        computer_player = ComputerPlayer.new(double('board'))
        allow(computer_player).to receive(:no_previous_hit_made?).and_return(false)
        allow(computer_player).to receive(:make_a_random_selection)
        allow(computer_player).to receive(:make_a_guess_around_cell)
        mock_other_player_board = double('Board')

        computer_player.take_turn(mock_other_player_board)
        expect(computer_player).not_to have_received(:make_a_random_selection)
        expect(computer_player).to have_received(:make_a_guess_around_cell)
      end
    end
end
