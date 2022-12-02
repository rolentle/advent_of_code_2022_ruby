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
        expect(Advent2022::PaperRockScissors.predicted_total_scores(example_input)).to eq([15, 15])
      end
    end

    describe 'for day_2_input' do
      it 'returns 15 for both players' do
        fixture_input = File.read('./spec/fixtures/day_2_input.txt')
        expect(Advent2022::PaperRockScissors.predicted_total_scores(fixture_input)).to eq([13227, 10816])
      end
    end
  end

  describe '.predicted_scores' do
    it 'calculates predicted score from guide' do
      game_1 = [Advent2022::PaperRockScissors::Choice::Rock, Advent2022::PaperRockScissors::Choice::Paper]
      expect(Advent2022::PaperRockScissors.predicted_scores(game_1)).to eq([1, 8])
    end
  end

  describe '.predicted_encrypted_strategy_guide' do
    describe 'for example_input' do
      it 'returns 15' do
        expect(Advent2022::PaperRockScissors.predicted_encrypted_strategy_guide(example_input)).to eq(
          [
            [Advent2022::PaperRockScissors::Choice::Rock, Advent2022::PaperRockScissors::Choice::Paper],
            [Advent2022::PaperRockScissors::Choice::Paper, Advent2022::PaperRockScissors::Choice::Rock],
            [Advent2022::PaperRockScissors::Choice::Scissors, Advent2022::PaperRockScissors::Choice::Scissors]
          ]
        )
      end
    end
  end

  describe '.actual_total_scores' do
    describe 'for example_input' do
      it 'returns 15, 12 for both players' do
        expect(Advent2022::PaperRockScissors.actual_total_scores(example_input)).to eq([15, 12])
      end

      it 'returns 15 for both players' do
        fixture_input = File.read('./spec/fixtures/day_2_input.txt')
        expect(Advent2022::PaperRockScissors.actual_total_scores(fixture_input)).to eq([13755, 11657])
      end
    end
  end
end
