require "spec_helper"
require './lib/advent_2022'

describe 'day 5' do
  let(:example_input) do
    <<~HEREDOC
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
    HEREDOC
  end

  describe '.stacks_and_procedures' do
    it 'returns it as a hash' do
      expect(Advent2022::SupplyStacks.stacks_and_procedures(example_input)).to eq([
        { 1 => %w[Z N], 2 => %w[M C D], 3 => %w[P] }, 
        [[1, 2, 1], [3, 1, 3], [2, 2, 1], [1, 1, 2]]
      ])
    end
  end

  describe '.run_procedures' do
    it 'returns the correct hash' do
      end_stacks = Advent2022::SupplyStacks.run_procedures(example_input)
      expect(end_stacks).to eq({
        1 => %w[C],
        2 => %w[M],
        3 => %w[P D N Z]
      })
      expect(end_stacks.values.map(&:last)).to eq(%w[C M Z])
      fixture_input = File.read('./spec/fixtures/day_5_input.txt')
      fixture_end_stacks = Advent2022::SupplyStacks.run_procedures(fixture_input)
      expect(fixture_end_stacks.values.map(&:last)).to eq(%w[V G B B J C R M N])
    end
  end
  describe '.run_procedures_9001' do
    it 'returns the correct hash' do
      end_stacks = Advent2022::SupplyStacks.run_procedures_9001(example_input)
      expect(end_stacks).to eq({
        1 => %w[M],
        2 => %w[C],
        3 => %w[P Z N D]
      })
      expect(end_stacks.values.map(&:last)).to eq(%w[M C D])
      fixture_input = File.read('./spec/fixtures/day_5_input.txt')
      fixture_end_stacks = Advent2022::SupplyStacks.run_procedures_9001(fixture_input)
      expect(fixture_end_stacks.values.map(&:last)).to eq(%w[L B B V J B R M H])
    end
  end
end
