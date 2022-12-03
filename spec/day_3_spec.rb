require "spec_helper"
require './lib/advent_2022'

describe 'day 3' do
  let(:example_input) do
    <<~HEREDOC
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
    HEREDOC
  end

  describe '.compartment_split' do
    it 'splits them evenly into two compartments' do
      expect(Advent2022::RutsackReorganization.compartment_split('vJrwpWtwJgWrhcsFMMfFFhFp')).to eq(['vJrwpWtwJgWr','hcsFMMfFFhFp'])
      expect(Advent2022::RutsackReorganization.compartment_split('jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL')).to eq(['jqHRNqRjqzjGDLGL', 'rsFMfFZSrLrFZsSL'])
      expect(Advent2022::RutsackReorganization.compartment_split('PmmdzqPrVvPwwTWBwg')).to eq(['PmmdzqPrV', 'vPwwTWBwg'])
    end
  end

  describe '.duplicated_item' do
    it 'returns duplicated_item' do
      expect(Advent2022::RutsackReorganization.duplicated_item(['vJrwpWtwJgWr', 'hcsFMMfFFhFp'])).to eq('p')
      expect(Advent2022::RutsackReorganization.duplicated_item(['jqHRNqRjqzjGDLGL', 'rsFMfFZSrLrFZsSL'])).to eq('L')
      expect(Advent2022::RutsackReorganization.duplicated_item(['PmmdzqPrV', 'vPwwTWBwg'])).to eq('P')
    end
  end

  describe '.total_priority_score' do
    it 'returns 157 for example data' do
      expect(Advent2022::RutsackReorganization.total_priority_score(example_input)).to eq(157)
      fixture_input = File.read('./spec/fixtures/day_3_input.txt')
      expect(Advent2022::RutsackReorganization.total_priority_score(fixture_input)).to eq(8349)
    end
  end
end
