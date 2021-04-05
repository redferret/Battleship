require './lib/computer_player'
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
