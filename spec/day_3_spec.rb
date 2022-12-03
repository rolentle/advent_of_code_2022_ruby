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
end
