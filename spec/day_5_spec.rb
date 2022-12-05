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
end
