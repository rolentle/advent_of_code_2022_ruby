require "spec_helper"
require './lib/advent_2022'

describe 'day 3' do
  let(:example_input) do
    <<~HEREDOC
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
    HEREDOC
  end

  describe '.one_section_for_input' do
    describe 'for example input' do
      it 'returns true' do
        expect(Advent2022::CampCleanup.one_section_for_input(example_input).count).to eq(2)
        fixture_input = File.read('./spec/fixtures/day_4_input.txt')
        expect(Advent2022::CampCleanup.one_section_for_input(fixture_input).count).to eq(2)
      end
    end
  end
end
