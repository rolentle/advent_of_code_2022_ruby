require "spec_helper"
require './lib/advent_2022'

describe 'day 2' do
  let(:example_input) do
    <<~HEREDOC
A Y
B X
C Z
    HEREDOC
  end

  describe '.predicted_total_score' do
    describe 'for example_input' do
      it 'returns 15 for both players' do
        expect(Advent2022::PaperRockScissors.predicted_total_scores(example_input)).to eq([15,15])
      end
    end
  end

  describe '.predicted_scores' do
    it 'calculates predicted score from guide' do
      game_1 = [Advent2022::PaperRockScissors::Choice::Rock, Advent2022::PaperRockScissors::Choice::Paper]
      expect(Advent2022::PaperRockScissors.predicted_scores(game_1)).to eq([1, 8])
    end
  end

  describe '.encrypted_strategy_guide' do
    describe 'for example_input' do
      it 'returns 15' do
        expect(Advent2022::PaperRockScissors.encrypted_strategy_guide(example_input)).to eq(
          [
            [Advent2022::PaperRockScissors::Choice::Rock, Advent2022::PaperRockScissors::Choice::Paper],
            [Advent2022::PaperRockScissors::Choice::Paper, Advent2022::PaperRockScissors::Choice::Rock],
            [Advent2022::PaperRockScissors::Choice::Scissors, Advent2022::PaperRockScissors::Choice::Scissors]
          ]
        )
      end
    end
  end
end
