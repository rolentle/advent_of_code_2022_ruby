require "spec_helper"
require './lib/advent_2022'

describe 'day 1' do
  let(:example_input) do
    <<~HEREDOC
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
    HEREDOC
  end

  describe '.elf_with_most_calories' do
    it 'returns the 4th elf' do
      expect(Advent2022.elf_with_most_calories(example_input)).to eq(4)
    end
  end

  describe '.calories_of_elves' do
    it 'returns a list of 5 lists of calories' do
      expect(Advent2022.calories_of_elves(example_input).count).to eq(5)
    end
  end
end
