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
      expect(Advent2022.elf_with_most_calories(example_input).id).to eq(4)
    end
  end

  describe '.total_calories_for_elf' do
    it 'returns 24000 for the 4th elf' do
      store = Advent2022.elf_calories_store(example_input)
      elf = store.find { |e| e.id == 4 }
      expect(elf.calories.sum).to eq(24_000)
    end
  end

  describe '.calories_of_elves' do
    it 'returns a list of 5 lists of calories' do
      expect(Advent2022.elf_calories_store(example_input).count).to eq(5)
    end
  end

  describe 'for day_1_input' do
    it 'returns the 209th elf' do
      fixture_input = File.read('./spec/fixtures/day_1_input.txt')
      expect(Advent2022.elf_with_most_calories(fixture_input).id).to eq(209)
    end

    it 'returns the 74_198 total_calories for the 209th elf' do
      fixture_input = File.read('./spec/fixtures/day_1_input.txt')
      store = Advent2022.elf_calories_store(fixture_input)
      elf = store.find { |e| e.id == 209 }
      expect(elf.calories.sum).to eq(74_198)
    end

    it 'returns top 3 elves by calorie count' do
      fixture_input = File.read('./spec/fixtures/day_1_input.txt')
      store = Advent2022.elf_calories_store(fixture_input)
      elves_order_by_calorie_count = Advent2022.elves_order_by_calorie_count(store)
      top_three_elves = elves_order_by_calorie_count.last(3)
      total_calories = top_three_elves.map(&:calories).map(&:sum).sum
      expect(total_calories).to eq(209_914)
    end
  end
end
